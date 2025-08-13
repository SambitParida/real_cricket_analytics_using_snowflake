-- use sysadmin role to create objects --
use role sysadmin;
-- use database --
use database cricket;
-- use schema --
use schema consumption;

create or replace transient table calendar_dates as
select
    dateadd(day, seq4(), '2000-01-01') as date
from table(generator(rowcount => 11323 + 1))
order by date;

create or replace table date_dim (date_id, full_dt, day, month, year, quarter, dayofweek, dayofmonth, dayofyear, dayofweekname, isweekend)
as
select 
    row_number() over(order by date) as date_id,
    date as full_dt,
    extract(day from date) as day,
    extract(month from date) as month,
    extract(year from date) as year,
    extract(quarter from date) as quarter,
    dayofweekiso(date) as dayofweek,
    extract(day from date) as dayofmonth,
    dayofyear(date) as dayofyear,
    dayname(date) as dayofweekname,
    case when upper(dayname(date)) in ('sat','sun') then 1 else 0 end as isweekend
from cricket.consumption.calendar_dates;





