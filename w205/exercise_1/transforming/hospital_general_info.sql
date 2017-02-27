-- creating tansformed hospital general info table
DROP TABLE IF EXISTS hospital_general_info;
CREATE TABLE hospital_general_info AS
SELECT
	CAST(provider_id AS INT),
	hospital_name,
	address,
	city,
	state,
	CAST(zip_code AS INT),
	county_name,
	CAST(phone_number AS INT),
	hospital_type,
	hospital_ownership,
	emergency_services
FROM hospitals
;