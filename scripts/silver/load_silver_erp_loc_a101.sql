/*
====================================================================================
-- Data Warehouse ETL Process: Silver Layer Population for Location Data
--
-- Purpose:
-- Extract and transform location data from the Bronze Layer, apply business rules,
-- and load it into the Silver Layer for analytics and reporting.
--
-- Source Table:
--   bronze.erp_loc_a101
--
-- Target Table:
--   silver.erp_loc_a101
--
-- Description:
--  1. Remove any hyphens '-' from customer IDs (cid) to standardize the format.
--  2. Normalize country (cntry) values according to business rules:
--     - 'USA' and 'US' → 'United States'
--     - 'DE' → 'Germany'
--     - Empty or NULL values → 'n/a'
--     - All other values are trimmed and passed as-is.
====================================================================================
*/

-- Insert cleaned and standardized location data into Silver Layer
INSERT INTO silver.erp_loc_a101 (
    cid,
    cntry
)
SELECT 
    -- Remove hyphens from customer ID
    REPLACE(cid, '-', '') AS cid,

    -- Normalize country codes to full names or 'n/a'
    CASE 
        WHEN TRIM(cntry) IN ('USA', 'US') THEN 'United States'
        WHEN TRIM(cntry) = 'DE' THEN 'Germany'
        WHEN TRIM(cntry) = '' OR cntry IS NULL THEN 'n/a'
        ELSE TRIM(cntry)
    END AS cntry

FROM bronze.erp_loc_a101;
