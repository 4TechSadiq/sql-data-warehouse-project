/*
====================================================================================
-- Data Warehouse ETL Process: Silver Layer Population for Customer Data
--
-- Purpose:
-- Extract transformed customer data from the Bronze Layer, apply business rules,
-- and load into the Silver Layer for downstream analytics and reporting.
--
-- Source Table:
--   bronze.erp_cust_az12
--
-- Target Table:
--   silver.erp_cust_az12
--
-- Description:
--  1. Clean and standardize customer IDs by removing 'NAS' prefix if present.
--  2. Validate birthdate (bdate) by setting future dates to NULL.
--  3. Normalize gender values to standard format: 'Male', 'Female', or 'n/a'.
====================================================================================
*/

-- Insert cleaned and transformed customer data into Silver Layer
INSERT INTO silver.erp_cust_az12 (
    cid,
    bdate,
    gen
)
SELECT 
    -- Remove 'NAS' prefix from cid if present
    CASE 
        WHEN cid LIKE 'NAS%' THEN SUBSTRING(cid, 4, LEN(cid)) 
        ELSE cid 
    END AS cid,

    -- Set birthdate to NULL if it is in the future
    CASE 
        WHEN bdate > GETDATE() THEN NULL 
        ELSE bdate 
    END AS bdate,

    -- Normalize gender field to 'Male', 'Female', or 'n/a'
    CASE
        WHEN UPPER(TRIM(gen)) IN ('F','FEMALE') THEN 'Female'
        WHEN UPPER(TRIM(gen)) IN ('M','MALE') THEN 'Male'
        ELSE 'n/a'
    END AS gen

FROM bronze.erp_cust_az12;

GO

-- Verify the data inserted into the Silver Layer
SELECT * FROM silver.erp_cust_az12;
