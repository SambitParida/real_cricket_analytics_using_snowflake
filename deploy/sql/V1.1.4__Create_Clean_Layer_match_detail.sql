-- use sysadmin role to create objects --
use role sysadmin;
-- use database --
use database cricket;
-- use schema --
use schema clean;
-- create transient table --
create or replace transient table cricket.clean.match_detail_clean as
select 
    info:match_type_number::int as match_type_number,
    info:event:name::text as event_name,
    case 
    when 
        info:event:match_number::text is not null then info:event:match_number::text
    when
        info:event:stage::text is not null then info:event::text
    else
        'na'
    end as match_stage,
    info:dates[0]::date as event_date,
    date_part('year', info:dates[0]::date) as event_year,
    date_part('month', info:dates[0]::date) as event_month,
    date_part('day', info:dates[0]::date) as event_day,
    info:match_type::text as match_type,
    info:season::text as season,
    info:officials:match_referees[0]::string  as match_referee,
    info:officials:reserve_umpires[0]::string  as reserve_umpire,
    info:officials:tv_umpires[0]::string  as tv_umpires,
    info:officials:umpires[0]::string  as first_umpire,
    info:officials:umpires[1]::string  as second_umpire,
    info:team_type as team_type,
    info:overs::text as overs,
    info:city::text as city,
    info:venue::text as venue, 
    info:gender::text as gender,
    info:teams[0]::text as first_team,
    info:teams[1]::text as second_team,
    case 
        when info:outcome.winner is not null then 'result declared'
        when info:outcome.result = 'tie' then 'tie'
        when info:outcome.result = 'no result' then 'no result'
        else info:outcome.result
    end as matach_result,
    case 
        when info:outcome.winner is not null then info:outcome.winner
        else 'na'
    end as winner,   

    info:toss.winner::text as toss_winner,
    initcap(info:toss.decision::text) as toss_decision,
    --
    stg_file_name ,
    stg_file_row_number,
    stg_file_content_key,
    stg_modified_ts
from
cricket.raw.match_raw_tbl;