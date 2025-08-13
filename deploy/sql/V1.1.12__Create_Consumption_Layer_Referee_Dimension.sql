-- use sysadmin role to create objects --
use role sysadmin;
-- use database --
use database cricket;
-- use schema --
use schema consumption;

truncate table cricket.consumption.referee_dim;
insert into cricket.consumption.referee_dim(referee_type,referee_name)
select
category,
name
from(
select
raw.info,
o.key::text as category,
o.value::text as official_name,
f.value::text as name
from raw.match_raw_tbl raw,
lateral flatten(input => raw.info:officials) o,
lateral flatten(
    input => parse_json(official_name)) f);
