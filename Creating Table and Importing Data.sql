Create Table business_licenses_fact (
    ID Text,
    License_ID NUMERIC(20),
    Account_Number NUMERIC(20),
    Site_Number NUMERIC(20),
    LEGAL_NAME Text,
    DOING_BUSINESS_AS_NAME Text,
    ADDRESS Text,
    CITY Text,
    STATE Text,
    ZIP_CODE Text,
    WARD NUMERIC(20),
    PRECINCT NUMERIC(20),
    WARD_PRECINCT Text,
    POLICE_DISTRICT NUMERIC(20),
    LICENSE_CODE NUMERIC(20),
    LICENSE_DESCRIPTION Text,
    BUSINESS_ACTIVITY_ID Text,
    BUSINESS_ACTIVITY Text,
    LICENSE_NUMBER NUMERIC(20),
    APPLICATION_TYPE Text,
    APPLICATION_CREATED_DATE TIMESTAMP,
    APPLICATION_REQUIREMENTS_COMPLETE TIMESTAMP,
    PAYMENT_DATE TIMESTAMP,
    CONDITIONAL_APPROVAL Text,
    LICENSE_TERM_START_DATE TIMESTAMP,
    LICENSE_TERM_EXPIRATION_DATE TIMESTAMP,
    LICENSE_APPROVED_FOR_ISSUANCE TIMESTAMP,
    DATE_ISSUED TIMESTAMP,
    LICENSE_STATUS Text,
    LICENSE_STATUS_CHANGE_DATE TIMESTAMP,
    SSA Text,
    LATITUDE NUMERIC(20),
    LONGITUDE NUMERIC(20),
    LOC Point
);


COPY business_licenses_fact
FROM 'C:\Users\carlj\OneDrive\Desktop\Business_Licenses\Business_Licenses_2024100.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

Create TABLE business_owners_dim (
   Account_Number Numeric(20), 
   Legal_Name text,
   Owner_First_Name Text,
   Owner_Middle_Initial Text,
   Owner_Last_Name Text,
   Suffix Text,
   Legal_Entity_Onwer Text,
   Title Text
)


COPY business_owners_dim
FROM 'C:\Users\carlj\OneDrive\Desktop\Business_Licenses\Business_Owners_20241009.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

ALTER TABLE business_owners_dim 
    ADD Owner_ID SERIAL PRIMARY KEY;

ALTER TABLE business_licenses_fact
    DROP Owner_ID;


Select *
FROM business_owners_dim
LIMIT 1000;


