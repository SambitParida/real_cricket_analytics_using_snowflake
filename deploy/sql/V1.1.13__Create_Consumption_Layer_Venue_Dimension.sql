-- use sysadmin role to create objects --
use role sysadmin;
-- use database --
use database cricket;
-- use schema --
use schema consumption;

truncate table cricket.consumption.venue_dim;
insert into cricket.consumption.venue_dim(venue_name,city)
select venue, 
case when city is null then 'na'
else city end as city,
from cricket.clean.match_detail_clean
group by venue, city
