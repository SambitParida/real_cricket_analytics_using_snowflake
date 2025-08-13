-- use sysadmin role to create objects --
use role sysadmin;
-- use database --
use database cricket;
-- use schema --
use schema consumption;

truncate table cricket.consumption.match_fact;
insert into cricket.consumption.match_fact(match_id, date_id, referee_id, team_a_id, team_b_id, match_type_id, venue_id, total_overs, balls_per_over, overs_played_by_team_a, bowls_played_by_team_a, extra_bowls_played_by_team_a, extra_runs_scored_by_team_a, fours_by_team_a, sixes_by_team_a, total_score_by_team_a, wicket_lost_by_team_a, overs_played_by_team_b, bowls_played_by_team_b, extra_bowls_played_by_team_b, extra_runs_scored_by_team_b, fours_by_team_b, sixes_by_team_b, total_score_by_team_b, wicket_lost_by_team_b, toss_winner_team_id, toss_decision, match_result, winner_team_id)
select 
    m.match_type_number as match_id,
    dd.date_id as date_id,
    rd.referee_id as referee_id,
    ftd.team_id as first_team_id,
    std.team_id as second_team_id,
    mtd.match_type_id as match_type_id,
    vd.venue_id as venue_id,
    50 as total_overs,
    6 as balls_per_overs,
    max(case when d.team_name = m.first_team then  d.over else 0 end ) as overs_played_by_team_a,
    sum(case when d.team_name = m.first_team then  1 else 0 end ) as balls_played_by_team_a,
    sum(case when d.team_name = m.first_team then  d.extras else 0 end ) as extra_balls_played_by_team_a,
    sum(case when d.team_name = m.first_team then  d.extras else 0 end ) as extra_runs_scored_by_team_a,
    0 fours_by_team_a,
    0 sixes_by_team_a,
    (sum(case when d.team_name = m.first_team then  d.runs else 0 end ) + sum(case when d.team_name = m.first_team then  d.extras else 0 end ) ) as total_runs_scored_by_team_a,
    sum(case when d.team_name = m.first_team and player_out is not null then  1 else 0 end ) as wicket_lost_by_team_a,    
    
    max(case when d.team_name = m.second_team then  d.over else 0 end ) as overs_played_by_team_b,
    sum(case when d.team_name = m.second_team then  1 else 0 end ) as balls_played_by_team_b,
    sum(case when d.team_name = m.second_team then  d.extras else 0 end ) as extra_balls_played_by_team_b,
    sum(case when d.team_name = m.second_team then  d.extras else 0 end ) as extra_runs_scored_by_team_b,
    0 fours_by_team_b,
    0 sixes_by_team_b,
    (sum(case when d.team_name = m.second_team then  d.runs else 0 end ) + sum(case when d.team_name = m.second_team then  d.extras else 0 end ) ) as total_runs_scored_by_team_b,
    sum(case when d.team_name = m.second_team and player_out is not null then  1 else 0 end ) as wicket_lost_by_team_b,
    tw.team_id as toss_winner_team_id,
    m.toss_decision as toss_decision,
    m.matach_result as matach_result,
    mw.team_id as winner_team_id
     
from 
    cricket.clean.match_detail_clean m
    join date_dim dd on m.event_date = dd.full_dt
    join team_dim ftd on m.first_team = ftd.team_name 
    join team_dim std on m.second_team = std.team_name 
    join match_type_dim mtd on m.match_type = mtd.match_type
    join venue_dim vd on m.venue = vd.venue_name and m.city = vd.city
    join cricket.clean.delivery_clean_tbl d  on d.match_type_number = m.match_type_number 
    join team_dim tw on m.toss_winner = tw.team_name 
    join team_dim mw on m.winner= mw.team_name 
    join referee_dim rd on m.match_referee = rd.referee_name
    group by
        m.match_type_number,
        date_id,
        referee_id,
        first_team_id,
        second_team_id,
        match_type_id,
        venue_id,
        total_overs,
        toss_winner_team_id,
        toss_decision,
        matach_result,
        winner_team_id;