-- loc, date, license code, business_activity_dim, license stat, account info

CREATE TABLE business_licenses_fact AS (
    SELECT * FROM business_licenses_uncleaned
);

/*add in loc_dimension:
    community_area TYPE: NUMERIC(20)
    c ommunity_area_name TYPE: TEXT
    neighborhood TYPE: TEXT*/

CREATE TABLE location_dim(
    location_id SERIAL PRIMARY KEY, /*Surrogate key */
    address TEXT,
    city TEXT,
    state TEXT,
    zip_code TEXT,
    ward NUMERIC(20),
    precinct NUMERIC(20),
    ward_precinct TEXT,
    police_district NUMERIC(20),
    community_area NUMERIC(20),
    community_area_name TEXT,
    neighborhood TEXT,
    ssa TEXT,
    latitude NUMERIC(20),
    longitude NUMERIC(20),
    location TEXT
);


CREATE TABLE date_dim (
    date_id SERIAL PRIMARY KEY, /*surrogate */
    payment_date DATE,
    license_start_date DATE,
    expiration_date DATE,
    license_approved_for_issuance DATE,
    date_issued DATE 
);

/* CREATE LICENSE DIMENSION TABLE */
CREATE TABLE license_code_dim(
    license_code NUMERIC(20) PRIMARY KEY,
    license_description TEXT
);



/* CREATE BUSINESS_ACTIVITY_DIM TABLE */
CREATE TABLE business_activity_dim(
    business_activity_id TEXT PRIMARY KEY,
    business_activity TEXT
);


/* CREATE LICENSE_STAT_DIM TABLE */
CREATE TABLE license_stat_dim (
    stat_id SERIAL PRIMARY KEY, /*surrogate */
    license_number NUMERIC (20), 
    application_type TEXT,
    conditional_approval TEXT,
    license_status TEXT
);

CREATE TABLE account_info_dim (
    account_id SERIAL PRIMARY KEY, /*surrogate */
    account_number numeric (20),
    legal_name TEXT,
    doing_business_as_name TEXT
);







