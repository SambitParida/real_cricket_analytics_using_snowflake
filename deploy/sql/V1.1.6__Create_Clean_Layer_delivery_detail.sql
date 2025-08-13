-- use sysadmin role to create objects --
use role sysadmin;
-- use database --
use database cricket;
-- use schema --
use schema clean;
-- create transient table --
create or replace transient table cricket.clean.delivery_clean_tbl as
select 
    raw.info:match_type_number::int as match_type_number,   
    i.value:team::text as team_name,
    o.value:over::text as over,
    d.value:bowler::text as bowler,
    d.value:batter::text as batter,
    d.value:non_striker::text as non_striker,
    d.value:runs:batter::int as runs,
    d.value:runs:extras::int as extras,
    d.value:runs:total::int as total,
    e.key::text as extra_type,
    w.value:player_out::text as player_out,
    w.value:kind::text as player_out_kind,
    w.value:fielders::variant as fielders,
    -- o.overs:over:value:over::int as over,
    raw.stg_file_name,
    raw.stg_file_row_number,
    raw.stg_file_content_key,
    raw.stg_modified_ts
from
cricket.raw.match_raw_tbl raw,
lateral flatten(input => raw.innings) i,
lateral flatten(input => i.value:overs) o,
lateral flatten(input => o.value:deliveries) d,
lateral flatten(input => d.value:wickets, outer => true) w,
lateral flatten(input => d.value:extras, outer => true) e