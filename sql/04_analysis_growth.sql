USE upi_analysis;

-- A1. Fiscal-year totals and YoY growth (Q1)

WITH fy AS 
(
SELECT fiscal_year,
	COUNT(*) AS months,
	SUM(volume_mn) AS volume_mn,
	SUM(value_cr) AS value_cr
FROM upi_monthly
GROUP BY fiscal_year
)
SELECT 
	fiscal_year,
	ROUND(volume_mn / 1000, 1) AS volume_bn,
	ROUND(value_cr / 100000, 2) AS value_lakh_cr,
	ROUND(100 * (volume_mn / LAG(volume_mn) OVER (ORDER BY fiscal_year) - 1), 1) AS volume_yoy_pct,
	ROUND(100 * (value_cr  / LAG(value_cr)  OVER (ORDER BY fiscal_year) - 1), 1) AS value_yoy_pct
FROM fy
WHERE months = 12          -- only complete financial years
ORDER BY fiscal_year;

-- A2. CAGR over complete financial years (Q1)

WITH fy AS 
(
SELECT fiscal_year,
	SUM(volume_mn) AS volume_mn,
	SUM(value_cr) AS value_cr
FROM upi_monthly
GROUP BY fiscal_year
HAVING COUNT(*) = 12
),
ends AS 
(
SELECT
	(SELECT fiscal_year FROM fy ORDER BY fiscal_year ASC  LIMIT 1) AS start_fy,
	(SELECT fiscal_year FROM fy ORDER BY fiscal_year DESC LIMIT 1) AS end_fy,
	(SELECT volume_mn   FROM fy ORDER BY fiscal_year ASC  LIMIT 1) AS start_vol,
	(SELECT volume_mn   FROM fy ORDER BY fiscal_year DESC LIMIT 1) AS end_vol,
	(SELECT value_cr    FROM fy ORDER BY fiscal_year ASC  LIMIT 1) AS start_val,
	(SELECT value_cr    FROM fy ORDER BY fiscal_year DESC LIMIT 1) AS end_val,
	(SELECT COUNT(*) - 1 FROM fy) AS years
)
SELECT 
	start_fy, 
    end_fy, 
    years,
	ROUND(end_vol / start_vol, 0) AS volume_multiple_x,
	ROUND(100 * (POW(end_vol / start_vol, 1 / years) - 1), 1) AS volume_cagr_pct,
	ROUND(100 * (POW(end_val / start_val, 1 / years) - 1), 1) AS value_cagr_pct
FROM ends;

-- A3. Last 24 months: MoM, YoY and 3-month rolling average (Q2)

WITH m AS 
(
SELECT 
	month_date,
	volume_mn,
	value_cr,
	LAG(volume_mn, 1) OVER w AS prev_month_vol,
	LAG(volume_mn, 12) OVER w AS last_year_vol,
	LAG(value_cr, 12) OVER w AS last_year_val,
	AVG(volume_mn) OVER (ORDER BY month_date ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) 
    AS rolling_3m_vol
FROM upi_monthly
WINDOW w AS (ORDER BY month_date)
)
SELECT 
	month_date,
	ROUND(volume_mn / 1000, 2) AS volume_bn,
	ROUND(rolling_3m_vol / 1000, 2) AS rolling_3m_bn,
	ROUND(100 * (volume_mn / prev_month_vol - 1), 1) AS mom_pct,
	ROUND(100 * (volume_mn / last_year_vol - 1), 1) AS yoy_volume_pct,
	ROUND(100 * (value_cr  / last_year_val - 1), 1) AS yoy_value_pct
FROM m
WHERE month_date >= (SELECT DATE_SUB(MAX(month_date), INTERVAL 23 MONTH) FROM upi_monthly)
ORDER BY month_date;

-- A4. Average ticket size by financial year (Q3)

SELECT 
	fiscal_year,
	ROUND(SUM(value_cr) * 10 / SUM(volume_mn), 0) AS avg_ticket_rs,
	COUNT(*) AS months
FROM upi_monthly
GROUP BY fiscal_year
ORDER BY fiscal_year;

-- A5. Seasonality: which months are strong (Q6)

WITH d AS 
(
SELECT 
	month_date,
	volume_mn / DAY(LAST_DAY(month_date)) AS vol_per_day   -- remove 28/30/31-day effect
FROM upi_monthly
),
m AS
(
SELECT 
	month_date,
	vol_per_day,
	LAG(vol_per_day) OVER (ORDER BY month_date) AS prev_per_day
FROM d
)
SELECT 
	MONTH(month_date) AS month_no,
	MONTHNAME(month_date) AS month_name,
	ROUND(AVG(100 * (vol_per_day / prev_per_day - 1)), 1) AS avg_mom_per_day_pct,
	COUNT(*) AS years_used
FROM m
WHERE month_date >= '2021-01-01'      -- skip early hyper-growth and 2020 lockdown
  AND prev_per_day IS NOT NULL
GROUP BY MONTH(month_date), MONTHNAME(month_date)
ORDER BY month_no;
