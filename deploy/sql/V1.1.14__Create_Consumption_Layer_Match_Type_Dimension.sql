-- USE SYSADMIN ROLE TO CREATE OBJECTS --
USE ROLE SYSADMIN;
-- USE DATABASE --
USE DATABASE CRICKET;
-- USE SCHEMA --
USE SCHEMA CONSUMPTION;

TRUNCATE TABLE CRICKET.CONSUMPTION.venue_dim;
INSERT INTO CRICKET.CONSUMPTION.venue_dim(venue_name,city)
select venue, 
case when city is null then 'NA'
else city end as city,
from cricket.clean.match_detail_clean
group by venue, city
