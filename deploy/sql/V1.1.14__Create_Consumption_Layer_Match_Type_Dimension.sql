-- use sysadmin role to create objects --
use role sysadmin;
-- use database --
use database cricket;
-- use schema --
use schema consumption;

truncate table cricket.consumption.match_type_dim;
insert into cricket.consumption.match_type_dim(match_type)
select distinct match_type from clean.match_detail_clean;