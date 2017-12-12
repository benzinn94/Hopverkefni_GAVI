create table counties (
	county varchar(250),
	primary key(county)
);

create table election_results (
	id serial,
	county_name varchar(250) references counties(county),
	votes_hillary int,
	votes_trump int,
	winner varchar(250),
	primary key(id)
);

create table schools (
	county_name varchar(250) references counties(county),
	school_name varchar(250),
	school_type varchar(250),
	vacc_rate_pertussis real,
	primary key(school_name)
);

create table county_stats (
	county_name varchar(250) references counties(county),
	population int,
	population_density real,
	per_capita_income int,
	med_household_income int,
	primary key(county_name)
);