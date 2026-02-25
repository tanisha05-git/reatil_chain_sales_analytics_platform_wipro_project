CREATE ROLE analyst_role;

GRANT USAGE ON DATABASE retail_db TO ROLE analyst_role;
GRANT USAGE ON SCHEMA retail_schema TO ROLE analyst_role;
GRANT SELECT ON ALL TABLES IN SCHEMA retail_schema TO ROLE analyst_role;

CREATE MASKING POLICY mask_name
AS (val STRING) RETURNS STRING ->
CASE
    WHEN CURRENT_ROLE() IN ('ANALYST_ROLE') 
        THEN '*****'
    ELSE val
END;
