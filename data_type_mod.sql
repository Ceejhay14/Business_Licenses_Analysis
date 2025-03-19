ALTER TABLE business_licenses_uncleaned 
    ALTER COLUMN id TYPE TEXT,
    ALTER COLUMN license_id TYPE NUMERIC(20) USING license_id::NUMERIC(20),
    ALTER COLUMN account_number TYPE NUMERIC(20) USING account_number::NUMERIC(20),
    ALTER COLUMN site_number TYPE NUMERIC(20) USING site_number::NUMERIC(20),
    ALTER COLUMN legal_name TYPE TEXT,
    ALTER COLUMN doing_business_as_name TYPE TEXT,
    ALTER COLUMN address TYPE TEXT,
    ALTER COLUMN city TYPE TEXT,
    ALTER COLUMN state TYPE TEXT,
    ALTER COLUMN zip_code TYPE TEXT,
    ALTER COLUMN ward TYPE NUMERIC(20) USING ward::NUMERIC(20),
    ALTER COLUMN precinct TYPE NUMERIC(20) USING precinct::NUMERIC(20),
    ALTER COLUMN ward_precinct TYPE TEXT,
    ALTER COLUMN police_district TYPE NUMERIC(20) USING police_district::NUMERIC(20),
    ALTER COLUMN community_area TYPE NUMERIC(20) USING community_area::NUMERIC(20),
    ALTER COLUMN community_area_name TYPE TEXT,
    ALTER COLUMN neighborhood TYPE TEXT,
    ALTER COLUMN license_code TYPE NUMERIC(20) USING license_code::NUMERIC(20),
    ALTER COLUMN license_description TYPE TEXT,
    ALTER COLUMN business_activity_id TYPE TEXT,
    ALTER COLUMN business_activity TYPE TEXT,
    ALTER COLUMN license_number TYPE NUMERIC(20) USING license_number::NUMERIC(20),
    ALTER COLUMN application_type TYPE TEXT,
    ALTER COLUMN application_created_date TYPE TIMESTAMP USING application_created_date::TIMESTAMP,
    ALTER COLUMN application_requirements_complete TYPE TIMESTAMP USING application_requirements_complete::TIMESTAMP,
    ALTER COLUMN payment_date TYPE TIMESTAMP USING payment_date::TIMESTAMP,
    ALTER COLUMN conditional_approval TYPE TEXT,
    ALTER COLUMN license_start_date TYPE TIMESTAMP USING license_start_date::TIMESTAMP,
    ALTER COLUMN expiration_date TYPE TIMESTAMP USING expiration_date::TIMESTAMP,
    ALTER COLUMN license_approved_for_issuance TYPE TIMESTAMP USING license_approved_for_issuance::TIMESTAMP,
    ALTER COLUMN date_issued TYPE TIMESTAMP USING date_issued::TIMESTAMP,
    ALTER COLUMN license_status TYPE TEXT,
    ALTER COLUMN license_status_change_date TYPE TIMESTAMP USING license_status_change_date::TIMESTAMP,
    ALTER COLUMN ssa TYPE TEXT,
    ALTER COLUMN latitude TYPE NUMERIC(20,10) USING latitude::NUMERIC(20,10),
    ALTER COLUMN longitude TYPE NUMERIC(20,10) USING longitude::NUMERIC(20,10)
    ALTER COLUMN location TYPE POINT USING location::POINT
    ;








