
INSERT INTO silver.crm_sales_details (
	sls_ord_num,
	sls_prd_key,
	sls_cust_id,
	sls_order_dt,
	sls_ship_dt,
	sls_due_dt,
	sls_sales,
	sls_price,
	sls_quantity
)

SELECT
	sls_ord_num,
	sls_prd_key,
	sls_cust_id,
	CASE WHEN sls_order_dt <=0 OR LEN(sls_order_dt)!=8 THEN NULL
		ELSE CAST(CAST(sls_order_dt AS VARCHAR) AS DATE)
	END AS sls_order_dt,
	CASE WHEN sls_ship_dt <=0 OR LEN(sls_ship_dt) !=8 THEN NULL
		ELSE CAST(CAST(sls_ship_dt AS VARCHAR) AS DATE)
	END AS sls_ship_dt,
	CASE WHEN sls_due_dt <= 0 OR LEN(sls_due_dt) !=8 THEN NULL
		ELSE CAST(CAST(sls_due_dt AS VARCHAR)AS DATE)
	END AS sls_due_dt,
	CASE WHEN sls_sales IS NULL OR sls_sales <=0 OR sls_sales != ABS(sls_price)*sls_quantity
	THEN sls_quantity*sls_price
	ELSE sls_sales
	END as sls_sales,
	CASE WHEN sls_price <=0 OR sls_price IS NULL
		THEN sls_sales/sls_quantity
		ELSE sls_price
	END AS sls_price,
	sls_quantity
FROM bronze.crm_sales_details;
