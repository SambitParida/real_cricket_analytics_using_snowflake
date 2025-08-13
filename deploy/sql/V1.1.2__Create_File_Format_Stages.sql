-- use sysadmin role to create objects --
use role sysadmin;
-- use database --
use database cricket;
-- use schema --
use schema land;

-- create json file format --
create or replace file format json_format
    type = json 
    null_if = ('\n', 'null', 'nul', '')
    strip_outer_array = true
    comment = 'json file format';

-- create internal named stage --
create or replace stage cricket_stg 
    directory =(enable = true);
