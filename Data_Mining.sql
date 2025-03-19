SELECT location FROM business_licenses_uncleaned
WHERE latitude IS NULL AND longitude IS NULL;
/* There are 89,939 entries that doesn't have a longitude and latitude information*/

SELECT location FROM test
WHERE zip_code IS NULL AND latitude IS NULL AND longitude IS NULL;
/*There are only 90 entries where there's no information on zip code latitude and longitude*/

SELECT COUNT(*) FROM business_licenses_fact;
/* 1,158,057 rows*/
-- loc, date, license code, business_activity_dim, license stat, account info
SELECT COUNT(*) FROM location_dim limit 5;
SELECT COUNT(*) FROM date_dim LIMIT 5;
SELECT COUNT(*) FROM license_code_dim LIMIT 5;
SELECT COUNT(*) FROM business_activity_dim LIMIT 5;
SELECT COUNT(*) FROM license_stat_dim LIMIT 5;
SELECT COUNT(*) FROM account_info_dim LIMIT 5;


SELECT account_number, count(*) 
FROM account_info_dim 
GROUP BY account_number
ORDER BY COUNT(*) DESC;