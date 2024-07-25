-- This is the data for HDB resale price from early as 2017 January to 2024 July.
-- This data is collected as of 22nd July 2024, from the data.gov.sg website. 

-- Following query breaks the Year and Month into respective column and transfrom the remaining_lease column to float instead of string type. 
-- It also filter anything before 2024 as 2024 is incomplete.

USE hdb_resale
SELECT 
	CAST(SUBSTRING(month, 0, 5) AS INT) as year, 
	CAST(SUBSTRING(month, 6,2) AS INT) as month, 
	CONCAT(town, ',SINGAPORE') as town, 
	flat_type, 
	block, 
	street_name, 
	storey_range, 
	floor_area_sqm, 
	flat_model, 
	lease_commence_date, 
	CAST(SUBSTRING(remaining_lease,1, CHARINDEX(' ', remaining_lease) - 1) as FLOAT) + 
	CASE 
		WHEN LEN(remaining_lease) < 9 THEN 0 
		ELSE ROUND(CAST(SUBSTRING(remaining_lease, CHARINDEX('s ', remaining_lease) + 1, 3) as FLOAT)/12, 1) END AS remaining_lease_in_years,
	resale_price
FROM dbo.hdbresaleprice
WHERE CAST(SUBSTRING(month, 0, 5) AS INT) < YEAR(GETDATE())

