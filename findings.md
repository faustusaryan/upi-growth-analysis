# Findings

Data: NPCI UPI statistics (see Sources). Monthly totals: Aug 2016 to Sep 2026 (122 months). FY = April to March; FY17 (8 months) and FY27 (Apr–Sep 2026) are partial, so growth and CAGR only use complete years FY18–FY26. App-wise and P2P/P2M data: Sep 2024 to Aug 2026 (24 months).

Terms used:
- **pp** = percentage points, the change in a share (45% → 47% is +2 pp).
- **HHI** = sum of squared market shares (0 to 10,000). Above 2,500 is "highly concentrated" in the 2010 US merger guidelines; the 2023 guidelines use 1,800.
- **Avg ticket** = value ÷ volume. **P2P** = person to person, **P2M** = person to merchant.

## Summary
1. UPI grew 264x in 8 years (FY18–FY26, CAGR 100.8%) and now adds about 55 bn transactions a year.
2. YoY growth has settled in the low 20s (22.6% in Sep 2026). That is a base effect at this scale, not weak demand.
3. Payments are getting smaller (avg ticket ₹1,838 in FY21 → ₹1,301 in FY26), so growth is coming from everyday spending, but the drop is slowing.
4. The PhonePe–Google Pay duopoly is loosening (top-2 share 85.4% → 77.9%, Sep 2024 → Aug 2026), mostly at Google Pay's cost. The market is still highly concentrated (HHI 3,215).
5. Navi is the standout challenger (+1.88 pp share in a year); CRED fell from rank 6 to 10.
6. P2M is ~63% of transactions but only ~30% of value, and its share of value is slowly rising.

## Day 3: Growth, ticket size, seasonality

### A1. Yearly growth (Q1)
- UPI went from 0.9 bn transactions (₹1.10 lakh cr) in FY18 to 241.6 bn (₹314.23 lakh cr) in FY26.
- YoY volume growth has dropped every year since FY22: 105.8% → 82.2% → 56.6% → 41.7% → 30.0%. The FY21 dip (78.4%) was probably COVID, and it bounced back in FY22.
- In absolute terms it's holding up. FY26 added 55.7 bn transactions, about the same as FY25 (54.7 bn). So UPI adds roughly 55 bn a year now, and the % falls because the base keeps getting bigger.
- Value growth is lower than volume growth (20.6% vs 30.0% in FY26) because ticket sizes are falling.

### A2. CAGR (Q1)
- Volume grew 264x from FY18 to FY26, a CAGR of 100.8% over 8 years. On average, UPI doubled every year.
- Value CAGR is a bit higher at 102.8%. That surprised me at first, but FY26's average ticket (₹1,301) is still slightly above FY18's (₹1,200), so value grew a little faster end to end. The rise and fall in between only shows in A4.

### A3. Last 24 months (Q2)
- YoY volume growth cooled from 33–39% (Nov 2024 to May 2025) to 21.5–24.9% since Mar 2026. Sep 2026 is at 22.6%. So yes, % growth is slowing.
- The 3-month rolling average still rose almost every month, from 15.53 bn to 24.08 bn. Usage keeps climbing, just at a lower rate.
- Value grew slower than volume in all 24 months, but the gap is closing: about 12 pp in early 2025 vs 2.4–5.3 pp since Feb 2026. Ticket sizes are still falling, just more slowly.
- Sep 2026 shows -1.8% MoM, but Sep has 30 days and Aug has 31. Per day it's up about 1.5%.
- Oct 2024 YoY (45.4%) is inflated because Diwali fell on Oct 31 in 2024 vs Nov 12 in 2023.
- Jul 2026 (23.66 bn) and Aug 2026 (24.51 bn) match the numbers reported in the news, so my data checks out.

### A4. Average ticket size (Q3)
- Average ticket peaked at ₹1,838 in FY21 and has fallen every year since, to ₹1,301 in FY26 (-29%). FY27 so far is ₹1,259.
- This suggests UPI is now used for small daily payments (tea, groceries, autos), not just bank transfers. B4 supports this: P2M is 63% of transactions.
- FY17's ₹3,912 is only 8 months right after launch with very few users, so I left it out of the trend.

### A5. Seasonality (Q6)
I used volume per day so 28/30/31-day months compare fairly, averaged from 2021 onwards.
- October is strong at +5.9%, 2nd highest, which fits the festive season.
- November is weak at +1.3% because it comes off a high October. Oct + Nov together come to about +7.3%, the same as two normal months (avg ~3.6% each). So the festive season moves spending into October more than it adds extra.
- February is the highest (+6.3%). My guess is fixed monthly payments (rent, bills, EMIs) get packed into fewer days.
- May is the weakest (+0.4%), likely pulled down by the May 2021 lockdown. January (+1.7%) is a post-December lull.
- Oct–Dec use 5 years of data and the rest use 6, since my data ends in Sep 2026.

## Day 4: Apps, concentration, P2P vs P2M

### B1. Market share, Aug 2026 (Q4)
- Top 2 hold 77.9%: PhonePe 45.6%, Google Pay 32.3%. Paytm 8.0%, Navi 4.4%.
- Among apps with 50 mn+ monthly transactions, CRED has the highest ticket (₹3,988 vs ~₹1,275 for PhonePe/Google Pay), likely credit-card bill payments. ICICI is next (₹3,513).

### B2. Concentration, Sep 2024 → Aug 2026 (Q4)
- Top-2 share fell from 85.4% to 77.9%; HHI from 3,757 to 3,215. Still highly concentrated under both US thresholds (2,500 and 1,800).
- Most of the drop is Google Pay (-5.1 pp). PhonePe fell only 2.4 pp.
- Top-5 share fell only 2.1 pp (94.2% → 92.1%), so the apps just behind the top 2 (now Paytm, Navi, super.money) took most (5.4 of the 7.5 pp) of what the top 2 lost.
- All apps outside the top 3 ("Challengers") went from 6.2% to 13.5% share, more than double.

### B3. Challengers, Aug 2025 → Aug 2026 (Q5)
I only ranked apps with 50 mn+ monthly transactions. Tiny apps show huge % growth on almost no volume (Unity SFB: +28,971%, but 0.08% share).
- Navi: +113.9% YoY, share +1.88 pp (2.5% → 4.4%). Biggest gainer; it held #4 and widened its lead over #5 super.money (1.2 → 2.7 pp).
- Paytm recovering (+1.00 pp). Next-biggest share gains: BHIM (+0.53 pp, rank 9 → 6), super.money (+0.44 pp) and WhatsApp (+0.36 pp, rank 11 → 8).
- Slice SFB climbed the most ranks (19 → 13, +278.6% YoY) but is still only ~0.3% share.
- Google Pay lost 3.04 pp in the same year; PhonePe was flat (-0.11 pp).
- Losing ground: CRED (rank 6 → 10, -0.16 pp) and ICICI (12 → 16).

### B4. P2P vs P2M (Q7)
- Aug 2026: P2M is 63.3% of volume but only 30.0% of value, matching PIB's ~63%.
- P2M ticket ₹577 vs P2P ₹2,319 (4x).
- Sep 2024 → Aug 2026: P2M's value share rose from 27.4% to 30.0% (volume share 62.2% → 63.3%). P2P ticket fell 12% (₹2,633 → ₹2,319), while P2M stayed in a ₹570–648 band, peaking in Oct 2024.

## Day 6: Insights and recommendations
Format: finding (heading) → evidence → so what → recommendation.

### I1. UPI grew 264x in 8 years (Q1)
- **Evidence:** Volume went from 0.9 bn (FY18) to 241.6 bn (FY26), value from ₹1.10 to ₹314.23 lakh cr. CAGR 100.8%, so UPI doubled every year on average.
- **So what:** UPI is no longer a niche option; it is India's default digital payment rail.
- **Recommendation:** Banks and payment apps should plan capacity and uptime for UPI adding ~55 bn transactions every year.

### I2. % growth is slowing, but absolute growth is steady (Q2)
- **Evidence:** YoY volume growth cooled from 33–39% (Nov 2024 to May 2025) to 21.5–24.9% since Mar 2026 (22.6% in Sep 2026). FY26 still added 55.7 bn transactions, about the same as FY25 (54.7 bn).
- **So what:** The falling % is a base effect, not weak demand.
- **Recommendation:** Apps should stop expecting 2x growth and focus on engagement and new use cases (for example credit on UPI, recurring payments).

### I3. Payments are getting smaller (Q3)
- **Evidence:** Average ticket fell from ₹1,838 (FY21) to ₹1,301 (FY26), down 29%, while volume grew ~11x (22.3 bn → 241.6 bn).
- **So what:** UPI is replacing cash for small daily spends, not just bank transfers.
- **Recommendation:** Apps and merchant acquirers should compete on speed and reliability of small payments (for example UPI Lite, sound boxes), since that is where the volume is.

### I4. The PhonePe–Google Pay duopoly is loosening (Q4)
- **Evidence:** Sep 2024 → Aug 2026: top-2 share fell from 85.4% to 77.9%; HHI from 3,757 to 3,215. Most of the drop is Google Pay (-5.1 pp vs -2.4 pp for PhonePe).
- **So what:** The market is still highly concentrated (HHI well above 2,500), but it is slowly opening up.
- **Recommendation:** RBI and NPCI (UPI's operator) should track top-2 share and HHI every month; challengers have real room to grow while share is shifting.

### I5. Navi is the standout challenger (Q5)
- **Evidence:** Aug 2025 → Aug 2026: Navi volume +113.9% and share +1.88 pp (2.5% → 4.4%), holding #4. Paytm regained +1.00 pp; BHIM (rank 9 → 6) and WhatsApp (11 → 8) climbed. Google Pay lost 3.04 pp; CRED fell from 6 to 10.
- **So what:** The share Google Pay lost spread across several apps, not one winner.
- **Recommendation:** Incumbents should work on retention; challengers should track repeat usage, not only volume, to show the gains will last.

### I6. Shops get most payments, but not most money (Q7)
- **Evidence:** Aug 2026: P2M is 63.3% of volume but only 30.0% of value. P2M ticket ₹577 vs P2P ₹2,319 (4x). P2M's value share rose from 27.4% to 30.0% (Sep 2024 → Aug 2026).
- **So what:** Most transactions are small shop payments, while large amounts still move person to person. Shops are slowly taking a bigger share of the money too.
- **Recommendation:** Merchant acquirers should focus on low-cost, reliable acceptance for small merchants, since they drive volume and a growing share of value.

### Limitations
- Data was copied manually from NPCI and validated in Python; NPCI can revise counts later.
- App-wise data lags the monthly totals by one month (latest app month is Aug 2026).
- App data only covers apps NPCI lists: 97.5–99.4% of volume per month (75 apps in Sep 2024, 92 in Aug 2026). The listed total rose from 98.7% to 99.4%, so up to 0.7 pp of the challengers' 7.3 pp gain may come from more apps being listed rather than real share gains.
- Top-2 share and HHI are calculated on listed apps only, so they are very slightly understated.
- Average ticket mixes P2P and P2M, so a change in mix moves it too.
- Mar 2026 shows a one-month jump in listed apps' share (97.8% → 99.3%), likely an NPCI reporting change.
- Seasonality averages only 5–6 years per month, and 2021 includes COVID lockdown months.

## Sources
**Data (all from NPCI):**
- NPCI UPI statistics: https://www.npci.org.in/product/ecosystem-statistics/upi
  - Monthly totals: Aug 2016 to Sep 2026.
  - App-wise and P2P/P2M: 24 monthly files (Sep 2024 to Aug 2026), downloaded Oct 2026 and combined into data/raw/upi_raw.xlsx.

**Used only to cross-check my numbers (no data taken from these):**
- PIB, "UPI completes 10 glorious years" (P2M ~63% of volume, P2P ~71% of value): https://www.pib.gov.in/PressReleasePage.aspx?PRID=2257087
- Business Standard, Sep 2026 (Jul 2026: 23.66 bn, Aug 2026: 24.51 bn transactions): https://www.business-standard.com/finance/news/upi-transactions-august-2026-record-volume-npci-126090100506_1.html
