"""
Validates the manually collected NPCI UPI data and exports clean CSVs.
Run from the project folder:  python python/validate_and_export.py
"""
from pathlib import Path
import pandas as pd

BASE = Path(__file__).resolve().parent.parent
RAW_FILE = BASE / "data" / "raw" / "upi_raw.xlsx"
CLEAN_DIR = BASE / "data" / "clean"
CLEAN_DIR.mkdir(parents=True, exist_ok=True)

# Same app can appear with slightly different names across months.
# Key = lowercase name as typed, value = one standard name.
APP_NAME_MAP = {
    "phonepe": "PhonePe",
    "google pay": "Google Pay",
    "gpay": "Google Pay",
    "paytm": "Paytm",
    "paytm payments bank app": "Paytm",
    "cred": "CRED",
    "navi": "Navi",
    "super.money": "super.money",
    "bhim": "BHIM",
    "whatsapp": "WhatsApp",
    "amazon pay": "Amazon Pay",
}

errors, warnings = [], []


def to_number(series):
    """'23,660.12' -> 23660.12 ; anything not a number -> NaN"""
    return pd.to_numeric(series.astype(str).str.replace(",", "").str.strip(),
                         errors="coerce")


def to_month(series):
    """Accepts real Excel dates or text like 'Jul-26'; returns 1st of month."""
    text_parsed = pd.to_datetime(series.astype(str).str.strip(),
                                 format="%b-%y", errors="coerce")
    date_parsed = pd.to_datetime(series, errors="coerce", dayfirst=True)
    return text_parsed.fillna(date_parsed).dt.to_period("M").dt.to_timestamp()


def load_sheet(name, columns):
    df = pd.read_excel(RAW_FILE, sheet_name=name)
    df = df.dropna(how="all")                 # remove fully empty rows
    df.columns = columns                      # force standard headers
    df["month"] = to_month(df["month"])
    for col in ["volume_mn", "value_cr"]:
        df[col] = to_number(df[col])
    if df["month"].isna().any():
        errors.append(f"[{name}] {df['month'].isna().sum()} rows have a bad month")
    for col in ["volume_mn", "value_cr"]:
        bad = df[col].isna() | (df[col] <= 0)
        if bad.any():
            errors.append(f"[{name}] {bad.sum()} rows have missing/zero {col}")
    return df


# ---------- 1. Monthly totals ----------
monthly = load_sheet("monthly", ["month", "banks_live", "volume_mn", "value_cr"])
monthly["banks_live"] = to_number(monthly["banks_live"]).astype("Int64")

if monthly["month"].duplicated().any():
    errors.append("[monthly] duplicate months found")
full_range = pd.date_range(monthly["month"].min(), monthly["month"].max(), freq="MS")
missing = sorted(set(full_range) - set(monthly["month"]))
if missing:
    errors.append(f"[monthly] missing months: {[m.strftime('%Y-%m') for m in missing]}")

# ---------- 2. App-wise ----------
apps = load_sheet("apps", ["month", "app_name", "volume_mn", "value_cr"])
apps["app_name"] = apps["app_name"].fillna("").astype(str).str.strip()
if (apps["app_name"] == "").any():
    errors.append("[apps] some rows have an empty app_name")
apps["app_name"] = apps["app_name"].apply(lambda n: APP_NAME_MAP.get(n.lower(), n))

if apps.duplicated(["month", "app_name"]).any():
    errors.append("[apps] same app appears twice in one month")

# Apps' total cannot be bigger than the UPI total for that month
app_sum = apps.groupby("month")["volume_mn"].sum()
check = app_sum.to_frame("apps_total").join(monthly.set_index("month")["volume_mn"])
check["coverage_pct"] = 100 * check["apps_total"] / check["volume_mn"]
if (check["coverage_pct"] > 102).any():
    errors.append("[apps] app total > UPI total in some month (check units)")
print("\nListed apps' share of total UPI volume per month (expect roughly 85-100%):")
print(check["coverage_pct"].round(1).to_string())

# ---------- 3. P2P vs P2M ----------
p2p = load_sheet("p2p_p2m", ["month", "txn_type", "volume_mn", "value_cr"])
p2p["txn_type"] = p2p["txn_type"].fillna("").astype(str).str.strip().str.upper()
if not p2p["txn_type"].isin(["P2P", "P2M"]).all():
    errors.append("[p2p_p2m] txn_type must be only P2P or P2M")
if p2p.duplicated(["month", "txn_type"]).any():
    errors.append("[p2p_p2m] same txn_type appears twice in one month")
if (p2p.groupby("month")["txn_type"].nunique() != 2).any():
    errors.append("[p2p_p2m] some months do not have both P2P and P2M")

# Every app / P2P month must exist in the monthly sheet (MySQL foreign key needs it)
for name, df in [("apps", apps), ("p2p_p2m", p2p)]:
    extra = set(df["month"].dropna()) - set(monthly["month"].dropna())
    if extra:
        errors.append(f"[{name}] months not in monthly sheet: "
                      f"{sorted(m.strftime('%Y-%m') for m in extra)}")

mix = p2p.groupby("month")["volume_mn"].sum().to_frame("p2p_p2m_total")
mix = mix.join(monthly.set_index("month")["volume_mn"])
mix["diff_pct"] = 100 * (mix["p2p_p2m_total"] / mix["volume_mn"] - 1)
if (mix["diff_pct"].abs() > 5).any():
    warnings.append("[p2p_p2m] P2P+P2M differs from total by >5% in some months "
                    "(can be normal; note it in README)")

# ---------- Result ----------
for w in warnings:
    print("WARNING:", w)
if errors:
    print("\nFIX THESE, then run again:")
    for e in errors:
        print(" -", e)
else:
    monthly.to_csv(CLEAN_DIR / "upi_monthly.csv", index=False, date_format="%Y-%m-%d", lineterminator="\n")
    apps.to_csv(CLEAN_DIR / "upi_apps.csv", index=False, date_format="%Y-%m-%d", lineterminator="\n")
    p2p.to_csv(CLEAN_DIR / "upi_p2p_p2m.csv", index=False, date_format="%Y-%m-%d", lineterminator="\n")
    print(f"\nOK. Exported: monthly={len(monthly)} rows, apps={len(apps)} rows, "
          f"p2p_p2m={len(p2p)} rows -> {CLEAN_DIR}")
