-- use sysadmin role to create objects --
use role sysadmin;
-- use database --
use database cricket;
-- use schema --
use schema clean;
-- create transient table --
create or replace transient table cricket.clean.player_clean_tbl as
select raw.info:match_type_number::int as match_type_number,
    f.path::text as country,
    team.value::text as player_name,
    stg_file_name,
    stg_file_row_number,
    stg_file_content_key,
    stg_modified_ts
from cricket.raw.match_raw_tbl raw,
    lateral flatten(input => raw.info:players) f,
    lateral flatten(input => f.value) team;