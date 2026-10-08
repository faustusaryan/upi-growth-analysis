USE upi_analysis;

-- 1. Row counts: compare with what Python printed
SELECT 'upi_monthly' AS table_name, COUNT(*) AS row_count FROM upi_monthly
UNION ALL SELECT 'upi_apps',    COUNT(*) FROM upi_apps
UNION ALL SELECT 'upi_p2p_p2m', COUNT(*) FROM upi_p2p_p2m;

-- 2. Date coverage of each table
SELECT 'monthly' AS source, MIN(month_date) AS first_month, MAX(month_date) AS last_month FROM upi_monthly
UNION ALL SELECT 'apps', MIN(month_date), MAX(month_date) FROM upi_apps
UNION ALL SELECT 'p2p_p2m', MIN(month_date), MAX(month_date) FROM upi_p2p_p2m;

-- 3. Gaps: any month whose previous row is more than 1 month earlier
SELECT month_date, prev_month
FROM (
    SELECT month_date,
           LAG(month_date) OVER (ORDER BY month_date) AS prev_month
    FROM upi_monthly
) AS t
WHERE TIMESTAMPDIFF(MONTH, prev_month, month_date) > 1;
-- Expected: 0 rows

-- 4. App name spelling variants: scan this list by eye
SELECT app_name,
       COUNT(*)        AS months_present,
       MIN(month_date) AS first_seen,
       MAX(month_date) AS last_seen
FROM upi_apps
GROUP BY app_name
ORDER BY app_name;

-- 5. Suspicious jumps: MoM change above 30% (likely a typing error)
SELECT month_date, volume_mn, prev_volume,
       ROUND(100 * (volume_mn - prev_volume) / prev_volume, 1) AS mom_pct
FROM (
    SELECT month_date, volume_mn,
           LAG(volume_mn) OVER (ORDER BY month_date) AS prev_volume
    FROM upi_monthly
) AS t
WHERE ABS((volume_mn - prev_volume) / prev_volume) > 0.30
  AND month_date >= '2018-01-01';
-- Months before 2018 grew very fast (e.g. demonetisation, Nov 2016),
-- so real jumps there would look like errors; they are excluded.

-- 6. Fiscal year check
SELECT fiscal_year, COUNT(*) AS months
FROM upi_monthly
GROUP BY fiscal_year
ORDER BY fiscal_year;
-- Every full FY should show 12 months.

-- 7. Cross-check with news: Jul 2026 should be ~23,660 mn (23.66 bn, Business Standard)
SELECT volume_mn FROM upi_monthly WHERE month_date = '2026-07-01';
