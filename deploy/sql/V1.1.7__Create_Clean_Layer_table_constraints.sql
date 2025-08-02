-- USE SYSADMIN ROLE TO CREATE OBJECTS --
USE ROLE SYSADMIN;
-- USE DATABASE --
USE DATABASE CRICKET;
-- USE SCHEMA --
USE SCHEMA CLEAN;

-- CREATE Constraints --
alter table cricket.clean.delivery_clean_tbl
modify column match_type_number set not null;

alter table cricket.clean.delivery_clean_tbl
modify column team_name set not null;

alter table cricket.clean.delivery_clean_tbl
modify column over set not null;

alter table cricket.clean.delivery_clean_tbl
modify column bowler set not null;

alter table cricket.clean.delivery_clean_tbl
modify column batter set not null;

alter table cricket.clean.delivery_clean_tbl
modify column non_striker set not null;

-- foreign key relationship


ALTER TABLE ricket.clean.match_detail_clean
ADD CONSTRAINT pk_match_detail_clean PRIMARY KEY (match_type_number);

alter table cricket.clean.delivery_clean_tbl
add constraint fk_delivery_match_id
foreign key (match_type_number)
references cricket.clean.match_detail_clean (match_type_number);