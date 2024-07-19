-- Q1. Show the number of cities with the highest use of electric cars
SELECT 
city,
count (*) total
FROM Electric_Vehicle 
GROUP by 1
order by 2 DESC

-- Q2. Show query for car products released in 2023
select 
  make,
  COUNT (*) total
  from Electric_Vehicle
WHERE
	model_year = 2023
group by 1
order by 2 DESC

-- Q3. Returns all car names and car types that have an electic range above average
select
make,
model,
electric_range
from Electric_Vehicle
WHERE electric_range > (SELECT
                        avg (electric_range) avg_electric_range
                        from Electric_Vehicle)
GROUP by 1, 2
ORDER by 3 DESC

-- Q4. Sort 5 car brands from 
-- a.	Tesla
-- b.	Chevrolet
-- c.	Nissan
-- d.	Ford
-- e.	KIA
-- based on the highest number of uses
SELECT
CASE
	WHEN lower (make) like '%tesla%' then 'tesla'
    WHEN lower (make) like '%chevrolet%' THEN 'chevrolet'
    when lower (make) like '%nissan%' then 'nissan'
    when lower (make) like '%ford%' then 'ford'
    WHEN lower (make) like '%kia%' then 'kia'
    end vehicle_brand,
count (*)
from Electric_Vehicle
WHERE
 vehicle_brand NOTNULL
group by 1
order by 2 DESC
    
-- Q5. Show a query about the number of tesla users and the models used. 
-- Sort by highest number of users
SELECT
	model,
	COUNT (*) total
FROM Electric_Vehicle
where make = 'TESLA'
GROUP by 1
order by 2 DESC

-- Q6. compare the value of electric car users in 2023 and 2022. 
-- Mention any car brands that have experienced an increase in the number of users
with vehicle as 
(SELECT
	make,
	sum (model_year = '2022') total_2022,
	sum (model_year = '2023') total_2023
from Electric_Vehicle
GROUP by 1
order by 3 desc, 2)
SELECT
	vehicle.*,
CASE
	when total_2023 > total_2022 then 'increase'
	when total_2023 < total_2022 then 'decrease'
	ELSE 'stagnan'
	end as usage_status
from vehicle
where 
total_2023 NOTNULL

-- Q7. show a comparison between the number of types of electric vehicles used, between Battery Electric Vehicle (BEV) and Plug-in Hybrid Electric Vehicle (PHEV). 
-- Sorted by type or brand of electric vehicle
with Perc_type as
(SELECT
	make,
	COUNT (*) Total_Vehicle,
	sum (electric_vehicle_type = 'Battery Electric Vehicle (BEV)') BEV,
	sum (electric_vehicle_type = 'Plug-in Hybrid Electric Vehicle (PHEV)') PHEV
from Electric_Vehicle
group by 1
ORDER by 2 DESC)
select
	perc_type.*,
    (total_vehicle-PHEV)*1.0/total_vehicle*100 perc_BEV,
    (total_vehicle-BEV)*1.0/total_vehicle*100 perc_PHEV
from perc_type

 





