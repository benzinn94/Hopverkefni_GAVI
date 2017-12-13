create table counties (
	county_name varchar(250),
	primary key(county_name)
);

create table election_results (
	id serial,
	county_name varchar(250) references counties(county_name),
	votes_hillary int,
	votes_trump int,
	primary key(id)
);

create table schools (
	id serial,
	county_name varchar(250) references counties(county_name),
	school_name varchar(250),
	school_type varchar(250),
	primary key(id, school_name)
);

create table county_stats (
	county_name varchar(250) references counties(county_name),
	population int,
	population_density real,
	per_capita_income int,
	med_household_income int,
	primary key(county_name)
);

create table vaccination_rate (
	id serial,
	year int,
	school_name varchar(250) references schools(school_name),
	county_name varchar(250) references counties(county_name),
	school_year_total int,
	school_year_vaccinated int,
	primary key(id)
);

create table pertussis_rate(
	year int,
	county_name varchar(250) references counties(county_name),
	cases int,
	rate real,
	primary key(county_name, year)
); 