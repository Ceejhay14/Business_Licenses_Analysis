INSERT INTO location_dim(address, city, state, zip_code, ward, 
                            precinct, ward_precinct, police_district, 
                            community_area,community_area_name,neighborhood,
                            ssa, latitude, longitude, 
                            location)
SELECT DISTINCT 
    address,
    city, 
    state, 
    zip_code, 
    ward, 
    precinct, 
    ward_precinct, 
    police_district,
    community_area,
    community_area_name,
    neighborhood,
    ssa,
    latitude,
    longitude,
    location::TEXT
FROM business_licenses_fact;

ALTER TABLE location_dim
ALTER COLUMN location TYPE POINT USING location::POINT;


INSERT INTO date_dim (payment_date,
    license_start_date,
    expiration_date,
    license_approved_for_issuance,
    date_issued)
SELECT DISTINCT 
    payment_date,
    license_start_date,
    expiration_date,
    license_approved_for_issuance,
    date_issued
FROM business_licenses_fact;


INSERT INTO license_code_dim (license_code,
    license_description)
SELECT DISTINCT
    license_code,
    license_description
FROM business_licenses_fact
WHERE license_code IS NOT NULL;

INSERT INTO business_activity_dim (business_activity_id,
    business_activity)
SELECT DISTINCT 
    business_activity_id,
    business_activity
FROM business_licenses_fact
WHERE business_activity_id IS NOT NULL;

INSERT INTO license_stat_dim (license_number,
    application_type, 
    conditional_approval,
    license_status)
SELECT DISTINCT license_number,
    application_type, 
    conditional_approval,
    license_status
FROM business_licenses_fact;

INSERT INTO account_info_dim (account_number,
    legal_name,
    doing_business_as_name)
SELECT DISTINCT account_number,
    legal_name,
    doing_business_as_name
FROM business_licenses_fact;

/* CREATING CONSTRAINTS*/

/* Location_dim */
ALTER TABLE business_licenses_fact
    ADD location_id INT;
ALTER TABLE business_licenses_fact
    ADD FOREIGN KEY (location_id) REFERENCES location_dim(location_id);

/* Date_dim */
ALTER TABLE business_licenses_fact
    ADD COLUMN date_id INT;
 ALTER TABLE business_licenses_fact
    ADD FOREIGN KEY (date_id) REFERENCES date_dim(date_id);


/* license_code_dim */
ALTER TABLE business_licenses_fact
    ADD FOREIGN KEY (license_code) REFERENCES license_code_dim (license_code);
    
/* business_activity_dim */
ALTER TABLE business_licenses_fact
    ADD FOREIGN KEY (business_activity_id) REFERENCES business_activity_dim (business_activity_id);

/* license_stat_dim */
ALTER TABLE business_licenses_fact
    ADD COLUMN stat_id INT;

ALTER TABLE business_licenses_fact
    ADD FOREIGN KEY (stat_id) REFERENCES license_stat_dim(stat_id);

/* account_info_dim */
ALTER TABLE business_licenses_fact
    ADD COLUMN account_id INT;
ALTER TABLE business_licenses_fact
    ADD FOREIGN KEY (account_id) REFERENCES account_info_dim(account_id);

-- Create indexes on foreign key columns for better performance
CREATE INDEX idx_date_id ON business_licenses_fact (date_id);
CREATE INDEX idx_license_code ON business_licenses_fact (license_code);
CREATE INDEX idx_location_id ON business_licenses_fact (location_id);
CREATE INDEX idx_business_activity_id ON business_licenses_fact (business_activity_id);
CREATE INDEX idx_stat_id ON business_licenses_fact (stat_id);
CREATE INDEX idx_account_id ON business_licenses_fact (account_id);
CREATE INDEX idx_license_number ON business_licenses_fact (license_number);

/* UPDATE FOREIGN KEYS AND POPULATE IT WITH REFERENCE*/

-- location_dim
UPDATE business_licenses_fact fc
SET location_id = lc.location_id
FROM location_dim lc
WHERE fc.address = lc.address AND
    fc.city = lc.city AND
    fc.state = lc.state AND
    fc.zip_code = lc.zip_code AND
    fc.ward = lc.ward AND 
    fc.precinct = lc.precinct AND 
    fc.ward_precinct = lc.ward_precinct AND 
    fc.police_district = lc.police_district AND 
    fc.community_area = lc.community_area AND
    fc.community_area_name = lc.community_area_name AND
    fc.neighborhood = lc.neighborhood AND
    fc.latitude = lc.latitude AND 
    fc.longitude = lc.longitude AND 
    fc.location::TEXT = lc.location::TEXT
;
-- date_dim
UPDATE business_licenses_fact fc
SET date_id = dd.date_id
FROM date_dim dd
WHERE fc.payment_date = dd.payment_date AND
    fc.license_start_date = dd.license_start_date AND
    fc.expiration_date = dd.expiration_date AND
    fc.license_approved_for_issuance = dd.license_approved_for_issuance AND
    fc.date_issued = dd.date_issued 
;
/*
-- license_code_dim
-- business_activity_dim 

BOTH doesn't need since we didn't create a serial id for each of the primary key*/

--license_stat_dim
UPDATE business_licenses_fact fc
SET stat_id = ls.stat_id
FROM license_stat_dim ls
WHERE fc.license_number = ls.license_number AND
    fc.application_type = ls.application_type AND
    fc.conditional_approval = ls.conditional_approval AND
    fc.license_status = ls.license_status 
;

-- account_info_dim
UPDATE business_licenses_fact fc
SET account_id = ai.account_id
FROM account_info_dim ai
WHERE fc.account_number = ai.account_number AND
    fc.legal_name = ai.legal_name AND
    fc.doing_business_as_name = ai.doing_business_as_name
;


ALTER TABLE business_licenses_fact 
DROP COLUMN address,
DROP COLUMN city, 
DROP COLUMN state, 
DROP COLUMN zip_code, 
DROP COLUMN ward, 
DROP COLUMN precinct, 
DROP COLUMN ward_precinct, 
DROP COLUMN police_district,
DROP COLUMN community_area,
DROP COLUMN community_area_name,
DROP COLUMN neighborhood,
DROP COLUMN ssa,
DROP COLUMN latitude,
DROP COLUMN longitude,
DROP COLUMN location,
DROP COLUMN payment_date,
DROP COLUMN license_start_date,
DROP COLUMN expiration_date,
DROP COLUMN license_approved_for_issuance,
DROP COLUMN date_issued,
DROP COLUMN license_description,
DROP COLUMN business_activity,
DROP COLUMN application_type, 
DROP COLUMN conditional_approval,
DROP COLUMN license_status,
DROP COLUMN account_number,
DROP COLUMN legal_name,
DROP COLUMN doing_business_as_name;

SELECT * FROM business_licenses_fact limit 5;

/* DROP TABLE business_licenses_fact;
DROP TABLE location_dim;
DROP TABLE date_dim;
DROP TABLE license_code_dim;
DROP TABLE license_stat_dim;
DROP TABLE business_activity_dim;
DROP TABLE account_info_dim;*/