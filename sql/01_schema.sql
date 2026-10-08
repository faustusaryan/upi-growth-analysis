SET PERSIST local_infile = 1;

CREATE DATABASE IF NOT EXISTS upi_analysis;
USE upi_analysis;

-- Drop child tables first (they depend on upi_monthly)
DROP TABLE IF EXISTS upi_apps;
DROP TABLE IF EXISTS upi_p2p_p2m;
DROP TABLE IF EXISTS upi_monthly;

-- 1. One row per month: UPI totals
CREATE TABLE upi_monthly (
    month_date   DATE          NOT NULL,
    banks_live   INT           NULL,
    volume_mn    DECIMAL(12,2) NOT NULL,   -- transactions, in million
    value_cr     DECIMAL(14,2) NOT NULL,   -- rupees, in crore
    -- Indian financial year: Apr 2025 - Mar 2026 = FY26
    fiscal_year  VARCHAR(4) AS (
        CONCAT('FY', RIGHT(YEAR(month_date) + (MONTH(month_date) >= 4), 2))
    ) STORED,
    PRIMARY KEY (month_date),
    CHECK (volume_mn > 0),
    CHECK (value_cr > 0)
);

-- 2. One row per app per month
CREATE TABLE upi_apps (
    app_id      INT AUTO_INCREMENT PRIMARY KEY,
    month_date  DATE          NOT NULL,
    app_name    VARCHAR(60)   NOT NULL,
    volume_mn   DECIMAL(12,2) NOT NULL,
    value_cr    DECIMAL(14,2) NOT NULL,
    UNIQUE KEY uq_app_month (month_date, app_name),
    FOREIGN KEY (month_date) REFERENCES upi_monthly(month_date),
    CHECK (volume_mn > 0),
    CHECK (value_cr > 0)
);

-- 3. Two rows per month: P2P and P2M
CREATE TABLE upi_p2p_p2m (
    month_date  DATE              NOT NULL,
    txn_type    ENUM('P2P','P2M') NOT NULL,
    volume_mn   DECIMAL(12,2)     NOT NULL,
    value_cr    DECIMAL(14,2)     NOT NULL,
    PRIMARY KEY (month_date, txn_type),
    FOREIGN KEY (month_date) REFERENCES upi_monthly(month_date),
    CHECK (volume_mn > 0),
    CHECK (value_cr > 0)
);


