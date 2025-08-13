-- use sysadmin role to create objects --
use role sysadmin;
-- use database --
use database cricket;
-- use schema --
use schema consumption;

truncate table cricket.consumption.player_dim;
insert into cricket.consumption.player_dim(team_id,player_name)
select 
distinct 
pd.team_id as team_id,
pd.player_name as player_name
from
(select distinct 
td.team_id as team_id,
pct.player_name as player_name
from cricket.clean.player_clean_tbl pct inner join consumption.team_dim td
on pct.country = td.team_name order by td.team_id, player_name) pd;
