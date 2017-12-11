import csv

f = open('all_anonymized_2015_11_2017_03.csv')

dread = csv.DictReader(f)

data = []

for i in dread:
	data.append(i)

f.close()


print(data)
#f = open('insertcommands.sql', 'w')


#newdata = list()



#for i in data:
	
	




'''maker,
model
mileage
manufacture_year
engine_displacement
engine_power
transmission
fuel_type
date_created
price_eur'''
