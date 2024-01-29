--Question 3
select 
		count(index) trips
from
		green_trip_data
where
		TO_DATE(lpep_pickup_datetime, 'yyyy-mm-dd') = '2019-09-18';   --15767


--Question 4
SELECT 
		TO_DATE(lpep_pickup_datetime, 'yyyy-mm-dd') Pup_day
FROM
		green_trip_data
WHERE
		trip_distance = (select max(trip_distance) 
						 from   green_trip_data
						);											   -- 2019-09-26
						


--Question 5
SELECT
		 z."Borough"
FROM
		 zones z
JOIN
		 green_trip_data d
ON		 z."LocationID" = d."PULocationID"
where    z."Borough" is not null AND TO_DATE(d.lpep_pickup_datetime, 'yyyy-mm-dd') = '2019-09-18'
GROUP BY z."Borough"
HAVING   sum(d.total_amount) > 50000
ORDER BY sum(d.total_amount) DESC
LIMIT 3;																-- "Brooklyn" "Manhattan" "Queens"


--Question 6
SELECT 
		 DOz."Zone"
FROM	 zones DOz
JOIN	 green_trip_data d	ON	DOz."LocationID" = d."PULocationID"
JOIN     zones PUz 			ON PUz."LocationID" = d."DOLocationID"
WHERE    
		 TO_DATE(d.lpep_pickup_datetime, 'YYYY-MM-DD') between '2019-09-01' AND '2019-09-30'
		 AND     PUz."Zone" = 'Astoria'
GROUP BY DOz."Zone"				
ORDER BY SUM(d.tip_amount) DESC
LIMIT 1;