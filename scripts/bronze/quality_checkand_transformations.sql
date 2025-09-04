-- TO CHECK IF THE PRIMARY KEY IN THE TABLE IS REPEATING OR NOT.

SELECT 
cst_id,
COUNT(*)
FROM bronze.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1 OR cst_id IS NULL;


-- TO REMOVE THE DUPLICATE VALUES

SELECT * FROM(
SELECT
*,
ROW_NUMBER() OVER( PARTITION BY cst_id ORDER BY cst_create_date DESC) AS flag_last
FROM bronze.crm_cust_info
)t
WHERE flag_last = 1;



-- DATA QUALITY CHECKS:
-- SPACES

-- IN FIRST NAME
SELECT 
cst_firstname
FROM bronze.crm_cust_info
WHERE cst_firstname != TRIM(cst_firstname);

-- IN lAST NAME
SELECT 
cst_lastname
FROM bronze.crm_cust_info
WHERE cst_lastname != TRIM(cst_lastname);

-- IN GENDER COLUMN
SELECT 
cst_gndr
FROM bronze.crm_cust_info
WHERE cst_gndr != TRIM(cst_gndr);

-- CHECK CONSISTENCY OF marital status
SELECT 
DISTINCT(cst_gndr)
FROM bronze.crm_cust_info


SELECT * FROM bronze.crm_cust_info

-- RENAME COLUMN
EXEC sp_rename 'silver.crm_cust_info.cst_material_status', 'cst_marital_status', 'COLUMN';
