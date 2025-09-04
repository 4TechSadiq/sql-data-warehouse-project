/********************************************************************
 Script: Data Quality and Deduplication Checks for crm_cust_info Table
 Layer : Bronze / Silver
 Author: [Your Name]
 Purpose:
   - Identify duplicate primary keys
   - Remove duplicates while keeping the latest record
   - Perform data quality checks (trailing/leading spaces, consistency)
   - Apply column renaming for standardization
********************************************************************/


/********************************************************************
 1. CHECK IF PRIMARY KEY (cst_id) HAS DUPLICATES OR NULLS
   - Group records by cst_id
   - Count how many times each appears
   - Return rows where count > 1 (duplicate) or where cst_id is NULL
********************************************************************/
SELECT 
    cst_id,
    COUNT(*) AS duplicate_count
FROM bronze.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1 OR cst_id IS NULL;



/********************************************************************
 2. REMOVE DUPLICATE VALUES WHILE KEEPING LATEST RECORD
   - Use ROW_NUMBER() to assign ranking for each cst_id
   - Partition by cst_id so numbering restarts for each customer
   - Order by cst_create_date DESC (latest record gets flag = 1)
   - Keep only the latest record (flag_last = 1)
********************************************************************/
SELECT * 
FROM (
    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY cst_id 
            ORDER BY cst_create_date DESC
        ) AS flag_last
    FROM bronze.crm_cust_info
) t
WHERE flag_last = 1;



/********************************************************************
 3. DATA QUALITY CHECKS: LEADING/TRAILING SPACES
   - Identify records where values are not properly trimmed
********************************************************************/

-- Check spaces in FIRST NAME
SELECT 
    cst_firstname
FROM bronze.crm_cust_info
WHERE cst_firstname != TRIM(cst_firstname);

-- Check spaces in LAST NAME
SELECT 
    cst_lastname
FROM bronze.crm_cust_info
WHERE cst_lastname != TRIM(cst_lastname);

-- Check spaces in GENDER column
SELECT 
    cst_gndr
FROM bronze.crm_cust_info
WHERE cst_gndr != TRIM(cst_gndr);



/********************************************************************
 4. CHECK CONSISTENCY OF GENDER VALUES
   - Extract distinct values from cst_gndr
   - Helps to identify inconsistent entries 
     (e.g., 'M', 'Male', 'male', 'F', 'Female', 'f')
********************************************************************/
SELECT 
    DISTINCT(cst_gndr) AS distinct_gender_values
FROM bronze.crm_cust_info;



/********************************************************************
 5. RENAME COLUMN IN SILVER LAYER
   - Standardize column name: 
     'cst_material_status' -> 'cst_marital_status'
********************************************************************/
EXEC sp_rename 
    'silver.crm_cust_info.cst_material_status', 
    'cst_marital_status', 
    'COLUMN';



/********************************************************************
 6. FULL DATA FETCH (for validation after transformations)
********************************************************************/
SELECT * 
FROM bronze.crm_cust_info;
