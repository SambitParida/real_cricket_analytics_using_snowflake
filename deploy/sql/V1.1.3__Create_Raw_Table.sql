-- use sysadmin role to create objects --
use role sysadmin;
-- use database --
use database cricket;
-- use schema --
use schema raw;
-- create transient table --
create or replace transient table match_raw_tbl
(
    meta object not null,
    info variant not null,
    innings array not null,
    stg_file_name text not null,
    stg_file_row_number int not null,
    stg_file_content_key text not null,
    stg_modified_ts timestamp not null
)
comment = 'this is the raw table to store all the json data file with root elements'
;