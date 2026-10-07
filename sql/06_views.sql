USE upi_analysis;

-- 1. Monthly trend (all months)

CREATE OR REPLACE VIEW vw_monthly_trend AS
SELECT 
	month_date,
	fiscal_year,
	banks_live,
	ROUND(volume_mn / 1000, 3) AS volume_bn,
	ROUND(value_cr / 100000, 3) AS value_lakh_cr,
	ROUND(value_cr * 10 / volume_mn, 0) AS avg_ticket_rs,
	ROUND(volume_mn / DAY(LAST_DAY(month_date)), 1) AS volume_per_day_mn,
	ROUND(100 * (volume_mn / LAG(volume_mn, 1) OVER w - 1), 1) AS mom_pct,
	ROUND(100 * (volume_mn / LAG(volume_mn, 12) OVER w - 1), 1) AS yoy_volume_pct,
	ROUND(100 * (value_cr  / LAG(value_cr, 12) OVER w - 1), 1) AS yoy_value_pct
FROM upi_monthly
WINDOW w AS (ORDER BY month_date);

-- 2. Financial-year summary

CREATE OR REPLACE VIEW vw_fy_summary AS
WITH fy AS 
(
SELECT 
	fiscal_year, 
	COUNT(*) AS months,
	SUM(volume_mn) AS volume_mn, 
	SUM(value_cr) AS value_cr
FROM upi_monthly
GROUP BY fiscal_year
)
SELECT 
	fiscal_year,
	months,
	CASE WHEN months = 12 THEN 'Complete' ELSE 'Partial' END AS fy_status,
	ROUND(volume_mn / 1000, 3) AS volume_bn,
	ROUND(value_cr / 100000, 2) AS value_lakh_cr,
	ROUND(value_cr * 10 / volume_mn, 0) AS avg_ticket_rs
FROM fy;

-- 3. App share (long format for pivots and slicers)

CREATE OR REPLACE VIEW vw_app_share AS
SELECT 
	a.month_date,
	a.app_name,
	CASE WHEN a.app_name IN ('PhonePe', 'Google Pay', 'Paytm') THEN a.app_name
	ELSE 'Challengers' END AS app_group,
	a.volume_mn,
	a.value_cr,
	ROUND(100 * a.volume_mn / m.volume_mn, 2) AS vol_share_pct,
	ROUND(100 * a.value_cr  / m.value_cr, 2) AS val_share_pct,
	ROUND(a.value_cr * 10 / a.volume_mn, 0) AS avg_ticket_rs,
	RANK() OVER (PARTITION BY a.month_date ORDER BY a.volume_mn DESC) AS vol_rank
FROM upi_apps a
JOIN upi_monthly m USING (month_date);

-- 4. Concentration per month

CREATE OR REPLACE VIEW vw_concentration AS
WITH s AS 
(
SELECT 
	a.month_date,
	100 * a.volume_mn / m.volume_mn AS share_pct,
	ROW_NUMBER() OVER (PARTITION BY a.month_date ORDER BY a.volume_mn DESC) AS rn
FROM upi_apps a
JOIN upi_monthly m USING (month_date)
)
SELECT 
	month_date,
	ROUND(SUM(CASE WHEN rn <= 2 THEN share_pct END), 1) AS top2_share_pct,
	ROUND(SUM(CASE WHEN rn <= 5 THEN share_pct END), 1) AS top5_share_pct,
	ROUND(SUM(share_pct * share_pct), 0) AS hhi
FROM s
GROUP BY month_date;

-- 5. P2P vs P2M (long format)

CREATE OR REPLACE VIEW vw_p2p_p2m AS
SELECT 
	month_date,
	txn_type,
	volume_mn,
	value_cr,
	ROUND(100 * volume_mn / SUM(volume_mn) OVER (PARTITION BY month_date), 1) AS volume_share_pct,
	ROUND(100 * value_cr  / SUM(value_cr)  OVER (PARTITION BY month_date), 1) AS value_share_pct,
	ROUND(value_cr * 10 / volume_mn, 0) AS ticket_rs
FROM upi_p2p_p2m;

-- 6. Seasonality: average per-day MoM by calendar month (2021 onwards)

CREATE OR REPLACE VIEW vw_seasonality AS
WITH d AS 
(
SELECT 
	month_date,
	volume_mn / DAY(LAST_DAY(month_date)) AS vol_per_day
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
	LEFT(MONTHNAME(month_date), 3) AS month_name,
	ROUND(AVG(100 * (vol_per_day / prev_per_day - 1)), 1) AS avg_mom_per_day_pct,
	COUNT(*) AS years_used
FROM m
WHERE month_date >= '2021-01-01'
  AND prev_per_day IS NOT NULL
GROUP BY MONTH(month_date), LEFT(MONTHNAME(month_date), 3);

-- Check: must return 6 views

SHOW FULL TABLES FROM upi_analysis WHERE Table_type = 'VIEW';

-- Savings csv:

SELECT * FROM vw_monthly_trend ORDER BY month_date;

SELECT * FROM vw_fy_summary ORDER BY fiscal_year;

SELECT * FROM vw_app_share ORDER BY month_date, vol_rank;

SELECT * FROM vw_concentration ORDER BY month_date;

SELECT * FROM vw_p2p_p2m ORDER BY month_date, txn_type;

SELECT * FROM vw_seasonality ORDER BY month_no;
