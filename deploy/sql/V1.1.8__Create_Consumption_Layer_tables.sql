-- use sysadmin role to create objects --
use role sysadmin;
-- use database --
use database cricket;
-- use schema --
use schema consumption;

create or replace table date_dim (
    date_id int primary key autoincrement,
    full_dt date,
    day int,
    month int,
    year int,
    quarter int,
    dayofweek int,
    dayofmonth int,
    dayofyear int,
    dayofweekname varchar(3), -- to store day names (e.g., "mon")
    isweekend boolean -- to indicate if it's a weekend (true/false sat/sun both falls under weekend)
);

create or replace table referee_dim (
    referee_id int primary key autoincrement,
    referee_name text not null,
    referee_type text not null
);

create or replace table team_dim (
    team_id int primary key autoincrement,
    team_name text not null
);

-- player..
create or replace table player_dim (
    player_id int primary key autoincrement,
    team_id int not null,
    player_name text not null
);

alter table cricket.consumption.player_dim
add constraint fk_team_player_id
foreign key (team_id)
references cricket.consumption.team_dim (team_id);

create or replace table venue_dim (
    venue_id int primary key autoincrement,
    venue_name text not null,
    city text not null,
    state text,
    country text,
    continent text,
    end_names text,
    capacity number,
    pitch text,
    flood_light boolean,
    established_dt date,
    playing_area text,
    other_sports text,
    curator text,
    lattitude number(10,6),
    longitude number(10,6)
);

create or replace table match_type_dim (
    match_type_id int primary key autoincrement,
    match_type text not null
);


create or replace table match_fact (
    match_id int primary key,
    date_id int not null,
    referee_id int not null,
    team_a_id int not null,
    team_b_id int not null,
    match_type_id int not null,
    venue_id int not null,
    total_overs number(3),
    balls_per_over number(1),

    overs_played_by_team_a number(2),
    bowls_played_by_team_a number(3),
    extra_bowls_played_by_team_a number(3),
    extra_runs_scored_by_team_a number(3),
    fours_by_team_a number(3),
    sixes_by_team_a number(3),
    total_score_by_team_a number(3),
    wicket_lost_by_team_a number(2),

    overs_played_by_team_b number(2),
    bowls_played_by_team_b number(3),
    extra_bowls_played_by_team_b number(3),
    extra_runs_scored_by_team_b number(3),
    fours_by_team_b number(3),
    sixes_by_team_b number(3),
    total_score_by_team_b number(3),
    wicket_lost_by_team_b number(2),

    toss_winner_team_id int not null, 
    toss_decision text not null, 
    match_result text not null, 
    winner_team_id int not null,

    constraint fk_date foreign key (date_id) references date_dim (date_id),
    constraint fk_referee foreign key (referee_id) references referee_dim (referee_id),
    constraint fk_team1 foreign key (team_a_id) references team_dim (team_id),
    constraint fk_team2 foreign key (team_b_id) references team_dim (team_id),
    constraint fk_match_type foreign key (match_type_id) references match_type_dim (match_type_id),
    constraint fk_venue foreign key (venue_id) references venue_dim (venue_id),

    constraint fk_toss_winner_team foreign key (toss_winner_team_id) references team_dim (team_id),
    constraint fk_winner_team foreign key (winner_team_id) references team_dim (team_id)
);

create or replace table delivery_fact (
    match_id int ,
    team_id int,
    bowler_id int,
    batter_id int,
    non_striker_id int,
    over int,
    runs int,
    extra_runs int,
    extra_type varchar(255),
    player_out varchar(255),
    player_out_kind varchar(255),

    constraint fk_del_match_id foreign key (match_id) references match_fact (match_id),
    constraint fk_del_team foreign key (team_id) references team_dim (team_id),
    constraint fk_bowler foreign key (bowler_id) references player_dim (player_id),
    constraint fk_batter foreign key (batter_id) references player_dim (player_id),
    constraint fk_stricker foreign key (non_striker_id) references player_dim (player_id)
);



