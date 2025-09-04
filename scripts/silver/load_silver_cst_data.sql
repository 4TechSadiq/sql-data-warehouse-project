/********************************************************************
 Script: Bronze ➝ Silver Transformation for crm_cust_info Table
 Layer : Silver
 Author: [Your Name]
 Purpose:
   - Load cleansed and standardized customer data into Silver layer
   - Apply transformations:
       * Deduplication (keep latest record per cst_id)
       * Trimming spaces in names
       * Standardizing Marital Status and Gender values
       * Exclude records with NULL primary key (cst_id)
********************************************************************/


/********************************************************************
 1. INSERT INTO SILVER LAYER
   - Target: silver.crm_cust_info
   - Columns: 
       cst_id, cst_key, cst_firstname, cst_lastname,
       cst_marital_status, cst_gndr, cst_create_date
********************************************************************/
INSERT INTO silver.crm_cust_info (
    cst_id,
    cst_key,
    cst_firstname,
    cst_lastname,
    cst_marital_status,
    cst_gndr,
    cst_create_date
)


/********************************************************************
 2. SELECT TRANSFORMED DATA FROM BRONZE LAYER
********************************************************************/
SELECT 
    cst_id,
    cst_key,

    -- Trim spaces from first name
    TRIM(cst_firstname) AS cst_firstname,

    -- Trim spaces from last name
    TRIM(cst_lastname) AS cst_lastname,

    -- Standardize marital status:
    -- 'M' -> Married
    -- 'F' -> Single
    -- Anything else -> n/a
    CASE 
        WHEN UPPER(TRIM(cst_material_status)) = 'M' THEN 'Married'
        WHEN UPPER(TRIM(cst_material_status)) = 'F' THEN 'Single'
        ELSE 'n/a'
    END AS cst_marital_status,

    -- Standardize gender:
    -- 'M' -> Male
    -- 'F' -> Female
    -- Anything else -> n/a
    CASE 
        WHEN UPPER(TRIM(cst_gndr)) = 'M' THEN 'Male'
        WHEN UPPER(TRIM(cst_gndr)) = 'F' THEN 'Female'
        ELSE 'n/a'
    END AS cst_gndr,

    -- Keep original creation date
    cst_create_date


/********************************************************************
 3. SUBQUERY: DEDUPLICATION + FILTER
   - Use ROW_NUMBER() to rank records per cst_id by cst_create_date
   - Keep only latest record (flag_last = 1)
   - Exclude records with NULL cst_id
********************************************************************/
FROM (
    SELECT 
        *,
        ROW_NUMBER() OVER(
            PARTITION BY cst_id 
            ORDER BY cst_create_date
        ) AS flag_last
    FROM bronze.crm_cust_info
    WHERE cst_id IS NOT NULL
) t
WHERE flag_last = 1;
