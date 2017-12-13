import csv

f1 = open('datasets/election_results/2016_results_county.csv')
f2 = open('datasets/diseases_california/pertusisRates2010_2015.csv')
f3 = open('datasets/diseases_california/StudentData.csv')
f4 = open('datasets/county_statistics.csv')
f5 = open('datasets/diseases_california/pertusisRates2010_2015.csv')
dread1 = csv.DictReader(f1)
dread2 = csv.DictReader(f2)
dread3 = csv.DictReader(f3)
dread4 = csv.DictReader(f4)
dread5 = csv.DictReader(f5)


data1 = []
data2 = []
data3 = []
data4 = []
data5 = []

for i in dread1:
	data1.append(i)
for i in dread2:
	data2.append(i)
for i in dread3:
	data3.append(i)
for i in dread4:
	data4.append(i)
for i in dread5:
	data5.append(i)

f1.close()
f2.close()
f3.close()
f4.close()
f5.close()


for i in data3:
	i['SCHOOL'] = i['SCHOOL'].replace("'", "''")
counties = dict()
countycount = list()


for i in data1:
	counties.update({i['State']: []})

for i in data1:
	counties[i['State']].append(i['Vote by county'])


f = open('insertcommands1.sql', 'w')
for i in counties['California']:
	f.write("insert into counties(county_name) values ('{}');\n".format(i.upper()))

f.close()

f = open('insertcommands2.sql', 'w')
schools = set()

for i in data3:
	temp = (i['schoolType'], i['COUNTY'], i['SCHOOL'])
	schools.add(temp)

for i in schools:
	f.write('''insert into schools(school_type, county_name, school_name) values ('{}', '{}', '{}');\n'''.format(i[0], i[1], i[2]))
f.close()

f = open('insertcommands3.sql', 'w')
for i in data1:
	if i['State'] == 'California':
		f.write("insert into election_results(county_name, votes_hillary, votes_trump) values('{}', {}, {});\n ".format(i['Vote by county'].upper(), i['Clinton'], i['Trump']))
f.close()

f = open('insertcommands4.sql', 'w')
for i in data3:
	f.write('''insert into vaccination_rate(year, school_name, school_year_total, school_year_vaccinated, county_name) values({}, '{}', {}, {}, '{}');\n'''.format(i['year'], i['SCHOOL'], i['n'], i['nDTP'], i['COUNTY']))
f.close()

f = open('insertcommands5.sql', 'w')
for i in data4:
	f.write('''insert into county_stats(county_name, population, population_density, per_capita_income, med_household_income) values('{}', {}, {}, {}, {});\n '''.format(i['county'].upper(), i['population'], i['population_density'], i['per_capita_income'], i['median_household_income']))
f.close()

f = open('insertcommands6.sql', 'w')


for i in data5:
	f.write("Insert into pertussis_rate(year, county_name, cases, rate) values(2010, '{}', {}, {});\n".format(i['county'], i['Cases2010'], i['Rate2010']))
	f.write("Insert into pertussis_rate(year, county_name, cases, rate) values(2011, '{}', {}, {});\n".format(i['county'], i['Cases2011'], i['Rate2011']))
	f.write("Insert into pertussis_rate(year, county_name, cases, rate) values(2012, '{}', {}, {});\n".format(i['county'], i['Cases2012'], i['Rate2012']))
	f.write("Insert into pertussis_rate(year, county_name, cases, rate) values(2013, '{}', {}, {});\n".format(i['county'], i['Cases2013'], i['Rate2013']))
	f.write("Insert into pertussis_rate(year, county_name, cases, rate) values(2014, '{}', {}, {});\n".format(i['county'], i['Cases2014'], i['Rate2014']))

f.close()
	