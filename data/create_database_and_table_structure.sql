--- create databse
create database ddd_nba_players;

--- select all data
select * from all_seasons;

-- public.all_seasons definition
-- DROP TABLE public.all_seasons;
drop table if exists all_seasons;
CREATE TABLE all_seasons (
	id_all_seasons serial4 NOT NULL,
	player_name varchar(50) NULL,
	team_abbreviation varchar(50) NULL,
	age smallint NULL,
	player_height float4 NULL,
	player_weight float4 NULL,
	college varchar(50) NULL,
	country varchar(50) NULL,
	draft_year varchar(50) NULL,
	draft_round varchar(50) NULL,
	draft_number varchar(50) NULL,
	gp smallint NULL,
	pts float4 NULL,
	reb float4 NULL,
	ast float4 NULL,
	net_rating float4 NULL,
	oreb_pct float4 NULL,
	dreb_pct float4 NULL,
	usg_pct float4 NULL,
	ts_pct float4 NULL,
	ast_pct float4 NULL,
	season varchar(50) NULL
);

alter table all_seasons ;

