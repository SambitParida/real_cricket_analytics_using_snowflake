# Real Cricket Analytics using Snowflake

## Project 
Create a data pipeline for cricket match and delivery summary reports.

## Implementation Overview
The implementation is structured into the following key activities:

1. ### Data Ingestion : Acquire match data in JSON format.
  The nested JSON structure contains:
- Match metadata: Match ID, match type, venue, overs, participating teams, toss winner, match winner.
- Match officials: On-field umpires, referee, TV umpire.
- Player information.
- Delivery and scoring details: Runs scored, wickets taken, extras.

2. ### Data Transformation
- Flatten the nested JSON structure to extract the required attributes.
- Load the transformed data into the Clean Schema in a normalized, row–column format.

3. ### Consumption Layer Design
- Develop and populate a consumption layer optimized for analytical queries.
- Define and load fact and dimension tables to support downstream reporting and analytics requirements.

    #### Dimension Tables  
    These hold descriptive attributes for analysis.  
    date_dim — Stores calendar details (day, month, year, quarter, weekend flag).  
    referee_dim — Stores referee names and their types (on-field, TV umpire, match referee, etc.).  
    team_dim — Stores team names.  
    player_dim — Stores player details and links each player to their team.  
    venue_dim — Stores venue details (location, pitch, capacity, coordinates, etc.).  
    match_type_dim — Stores match types (e.g., Test, ODI, T20).

    #### Fact Tables  
    These store numeric, measurable data linked to dimensions.  

    match_fact — One row per match.  
    Contains:  
    Foreign keys to date_dim, referee_dim, team_dim (for both teams), match_type_dim, venue_dim.  
    Match-level statistics (overs, runs, wickets, extras, etc.).  
    Match outcome details (toss winner, decision, match result, winning team).

    delivery_fact — One row per delivery (ball bowled).  
    Contains:  
    Foreign keys to match_fact, team_dim, player_dim (bowler, batter, non-striker).  
    Delivery-level data (runs scored, extras, wickets).


## Data Model

![Alt text](https://github.com/SambitParida/real_cricket_analytics_using_snowflake/blob/main/datamodel/datamodel.jpg)

## Data Lineage

![Alt text](https://github.com/SambitParida/real_cricket_analytics_using_snowflake/blob/main/datamodel/DataLineage.jpg)

## Snowflake Concepts used

1. Internal stage
2. JSON handling

Tools Used: 
1. Snowflake Business Critical Edition
2. VSCODE

### References 
https://www.youtube.com/watch?v=qDmqE89DSQQ  
Data Engineering Simplified