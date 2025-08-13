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

## Data Model



## Snowflake Concepts used

1. Internal stage
2. JSON handling

Tools Used: 
1. Snowflake Business Critical Edition
2. VSCODE

### References 
https://www.youtube.com/watch?v=qDmqE89DSQQ
Data Engineering Simplified