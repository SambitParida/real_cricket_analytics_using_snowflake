-- use sysadmin role to create objects --
use role sysadmin;
-- use database --
use database cricket;
-- use schema --
use schema consumption;

truncate table cricket.consumption.team_dim;
insert into cricket.consumption.team_dim (team_name)
select team_name as team_name
from (
select distinct first_team as team_name from clean.match_detail_clean
union
select distinct second_team as team_name from clean.match_detail_clean
) order by team_name;

