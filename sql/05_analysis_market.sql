USE upi_analysis;

-- B1. Market share, rank and ticket size in the latest month (Q4)

SELECT 
	a.app_name,
	RANK() OVER (ORDER BY a.volume_mn DESC) AS vol_rank,
	ROUND(a.volume_mn, 1) AS volume_mn,
	ROUND(100 * a.volume_mn / m.volume_mn, 2) AS vol_share_pct,
	ROUND(100 * a.value_cr  / m.value_cr, 2) AS val_share_pct,
	ROUND(a.value_cr * 10 / a.volume_mn, 0) AS avg_ticket_rs
FROM upi_apps a
JOIN upi_monthly m USING (month_date)
WHERE a.month_date = (SELECT MAX(month_date) FROM upi_apps)
ORDER BY vol_rank;

-- B2. Concentration over time: top-2, top-5 share and HHI (Q4)

WITH s AS 
(
SELECT 
	a.month_date,
	a.app_name,
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
GROUP BY month_date
ORDER BY month_date;

-- B3. Challengers: YoY growth, share change and rank movement (Q5)

WITH s AS 
(
SELECT 
	a.month_date,
	a.app_name,
	a.volume_mn,
	100 * a.volume_mn / m.volume_mn AS share_pct,
	RANK() OVER (PARTITION BY a.month_date ORDER BY a.volume_mn DESC) AS vol_rank
FROM upi_apps a
JOIN upi_monthly m USING (month_date)
),
latest AS
(
SELECT 
	MAX(month_date) AS d 
FROM upi_apps
)
SELECT 
	cur.app_name,
	cur.vol_rank AS rank_now,
	prev.vol_rank AS rank_12m_ago,
	CAST(prev.vol_rank AS SIGNED) - CAST(cur.vol_rank AS SIGNED) AS ranks_gained,
	ROUND(cur.volume_mn, 1) AS volume_now_mn,
	ROUND(100 * (cur.volume_mn / prev.volume_mn - 1), 1) AS yoy_growth_pct,
	ROUND(cur.share_pct - prev.share_pct, 2) AS share_change_pp
FROM s AS cur
JOIN latest AS l
  ON cur.month_date = l.d
JOIN s AS prev
  ON prev.app_name   = cur.app_name
 AND prev.month_date = DATE_SUB(l.d, INTERVAL 12 MONTH)
WHERE cur.volume_mn >= 50
  AND cur.vol_rank > 2
ORDER BY share_change_pp DESC;

-- B4. P2P vs P2M mix and ticket size (Q7)

WITH t AS 
(
SELECT 
	month_date,
	SUM(CASE WHEN txn_type = 'P2M' THEN volume_mn END) AS p2m_vol,
	SUM(CASE WHEN txn_type = 'P2P' THEN volume_mn END) AS p2p_vol,
	SUM(CASE WHEN txn_type = 'P2M' THEN value_cr  END) AS p2m_val,
	SUM(CASE WHEN txn_type = 'P2P' THEN value_cr  END) AS p2p_val
FROM upi_p2p_p2m
GROUP BY month_date
)
SELECT 
	month_date,
	ROUND(100 * p2m_vol / (p2m_vol + p2p_vol), 1) AS p2m_volume_share_pct,
	ROUND(100 * p2m_val / (p2m_val + p2p_val), 1) AS p2m_value_share_pct,
	ROUND(p2m_val * 10 / p2m_vol, 0) AS p2m_ticket_rs,
	ROUND(p2p_val * 10 / p2p_vol, 0) AS p2p_ticket_rs
FROM t
ORDER BY month_date;
