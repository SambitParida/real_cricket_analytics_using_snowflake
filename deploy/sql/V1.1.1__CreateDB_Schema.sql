-- use sysadmin role to create objects --
use role sysadmin;
-- use database --
use database cricket;
-- create schemas --
create schema if not exists land;
create schema if not exists raw;
create schema if not exists clean;
create schema if not exists consumption;