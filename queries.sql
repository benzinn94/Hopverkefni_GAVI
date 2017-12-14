#Q:	Is it more likely for less populated counties to get pertussis?
#A:	It seems to be rather random whether inhabitants get pertussis. There doesn't seem to be any connection
#	between the population or the population density and the rate of people affected.
SELECT st.county_name, st.population, st.population_density, AVG(p.rate) as avg_affected_per_100K_inhabitants
FROM county_stats st, pertussis_rate p
WHERE st.county_name = p.county_name
GROUP BY st.county_name, st.population
ORDER BY st.population ASC;

#Q:	Are wealthier counties more likely to have a higher rate of pertussis?
#A:	There doesn't seem to be a strong connection between wealth and rate of pertussis but the
#	fact that the county with the highest income per capita has the highest rate of pertussis
#	is noteworthy. It's also worthy to mention that the counties in the lower end of income 
#	per capita have a relatively low rate of pertussis in most cases.
SELECT cs.county_name, cs.per_capita_income, AVG(p.rate) as average_pertussis_rate
FROM county_stats cs, pertussis_rate p
WHERE cs.county_name = p.county_name
GROUP BY cs.county_name, cs.per_capita_income
ORDER BY cs.per_capita_income DESC;

#Q: Is there a difference in pertussis rates between counties and is there a connection between the 
#	percentage of children vaccinated in those counties and the pertussis rate?
#A:	No significant connection between those variables, it differs between counties whether the vaccination
#	rate is high and the pertussis rate is low and vice versa.
SELECT v.county_name, AVG(v.school_year_vaccinated/v.school_year_total::FLOAT) as vaccinated_rate, AVG(p.rate) as pertussis_rate
FROM vaccination_rate v, pertussis_rate p
WHERE v.county_name = p.county_name
GROUP BY v.county_name
ORDER BY vaccinated_rate;



#Q:	Which of the two candidates had the largest margin through all the counties 
#	of California?
#A: Clinton, with roughly 89,6% in the county of San Francisco while Trump's largest 
#	margin was roughly 76,6% in the county of Lassen.


CREATE VIEW county_election_results as
SELECT e.county_name, 'Trump won!' as winner, (e.votes_trump/(e.votes_trump+e.votes_hillary)::FLOAT) as margin
FROM election_results e
WHERE e.votes_trump > e.votes_hillary
UNION
SELECT e.county_name,'Clinton won!' as winner, (e.votes_hillary/(e.votes_trump+e.votes_hillary)::FLOAT) as margin
FROM election_results e
WHERE e.votes_hillary > e.votes_trump
ORDER BY winner, margin DESC;

SELECT  cer1.county_name as county_name_clinton, cer1.margin as clinton_margin,
        cer2.county_name as county_name_trump, cer2.margin as trump_margin
FROM county_election_results cer1, county_election_results cer2
WHERE cer1.winner like '%Clinton%'
AND cer2.winner like '%Trump%'
LIMIT 1;


#Q:	Are the voters of Trump more likely than the voters of Clinton to be more
#	susceptible to pertussis or vice versa?
#A:	It turns out that the top 8 counties with the highest pertussis rate voted 
#	for Clinton, whereas the bottom 2-5 counties voted for Trump.
SELECT cer.county_name, cer.winner, cer.margin, AVG(p.rate) as avg_pertussis_rate
FROM pertussis_rate p, county_election_results cer
WHERE cer.county_name = p.county_name
GROUP BY cer.county_name, cer.winner, cer.margin
ORDER BY cer.winner, cer.margin DESC;

#

