use database cricket;
use schema land;

list @cricket_stg;

SELECT * FROM raw.match_raw_tbl;

create or replace transient table cricket.clean.match_detail_clean as


select 
    raw.info:match_type_number::int as match_type_number,   
    i.value:team::text as country,
    o.value:over::text as overs,
    d.value:bowler::text as bowler,
    d.value:batter::text as batter,
    d.value:non_striker::text as non_striker,
    d.value:runs:batter::int as runs,
    d.value:runs:extras::int as extras,
    d.value:runs:total::int as total,
    w.value:player_out::text as player_out,
    w.value:kind::text as player_out_kind,
    w.value:fielders::variant as fielders,
    -- o.overs:over:value:over::int as over,
    raw.stg_file_name,
    raw.stg_file_row_number,
    raw.STG_FILE_CONTENT_KEY,
    raw.STG_MODIFIED_TS
from
cricket.raw.match_raw_tbl raw,
LATERAL FLATTEN(input => raw.innings) i,
LATERAL FLATTEN(input => i.value:overs) o,
LATERAL FLATTEN(input => o.value:deliveries) d,
LATERAL FLATTEN(input => d.value:wickets, outer => TRUE) w

-----

select * from clean.player_clean_tbl;

SELECT * FROM RAW.MATCH_RAW_TBL;


select
raw.info,
o.key::text as category,
o.value::text as official_name
-- o.umpires::text as umpires

FROM RAW.MATCH_RAW_TBL RAW,
LATERAL FLATTEN(input => RAW.info:officials) o,
LATERAL FLATTEN(input => o.value) u

select
category,
name
from(
select
raw.info,
o.key::text as category,
o.value::text as official_name,
f.value::text as name
FROM RAW.MATCH_RAW_TBL RAW,
LATERAL FLATTEN(input => RAW.info:officials) o,
LATERAL FLATTEN(
    INPUT => PARSE_JSON(official_name)) f)


select * from clean.match_detail_clean;

select venue, 
case when city is null then 'NA'
else city end as city,
from cricket.clean.match_detail_clean
group by venue, city
----------------------------

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