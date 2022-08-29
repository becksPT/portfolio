-- Taking a look at the dataset

SELECT *
FROM airbnb_newyork..newyork_airbnb_data;


-- How many Airbnbs listings and distinct hosts in the dataset?

SELECT COUNT(id) as "Number of Airbnb Listings", COUNT(DISTINCT(host_id)) as "Number of Distinct Hosts"
FROM airbnb_newyork..newyork_airbnb_data;


--Which hosts have the most listings? 

SELECT host_id, host_name, calculated_host_listings_count
FROM airbnb_newyork..newyork_airbnb_data
ORDER BY calculated_host_listings_count DESC


-- What are the distinct neighbourhood groups?

SELECT neighbourhood_group AS "Neighbourhood Groups", COUNT(*) AS "Number of Instances"
FROM airbnb_newyork..newyork_airbnb_data
GROUP BY neighbourhood_group
ORDER BY "Neighbourhood Groups" ASC


-- What are the distinct neighbourhoods?

SELECT neighbourhood AS "Neighbourhoods", COUNT(*) AS "Number of Instances"
FROM airbnb_newyork..newyork_airbnb_data
GROUP BY neighbourhood
ORDER BY "Neighbourhoods" ASC


--Distinct Room Types on the dataset

SELECT room_type, COUNT(*)
FROM airbnb_newyork..newyork_airbnb_data
GROUP BY room_type
ORDER BY room_type DESC


--First and Last Review in the dataset

SELECT MIN(last_review) AS "First Review", MAX(last_review) AS "Last Review"
FROM airbnb_newyork..newyork_airbnb_data


--Top 10 Most Reviewed Airbnbs in the dataset

SELECT TOP 10 id AS "Airbnb ID", name AS "Airbnb Name/Description", number_of_reviews AS "Number of Reviews"
FROM airbnb_newyork..newyork_airbnb_data
ORDER BY number_of_reviews DESC


--Checking the availability of the Airbnbs

SELECT availability_365 AS "Yearly Availability (in days)", COUNT(*) AS "Number of Instances"
FROM airbnb_newyork..newyork_airbnb_data
GROUP BY availability_365
ORDER BY availability_365 ASC


-- What is the minimum nights distribution in the dataset?

SELECT minimum_nights AS "Minimum Nights", COUNT(*) AS "Number of Instances"
FROM airbnb_newyork..newyork_airbnb_data
GROUP BY minimum_nights
ORDER BY minimum_nights ASC


--What is the average Airbnb price in New York?

SELECT ROUND(AVG(price),2) AS "Average Airbnb Price"
FROM airbnb_newyork..newyork_airbnb_data


--What is the average Airbnb price per Neighbourhood group?

SELECT neighbourhood_group AS "Neighbourhood Group", ROUND(AVG(price),2) AS "Average Price"
FROM airbnb_newyork..newyork_airbnb_data
GROUP BY neighbourhood_group
ORDER BY "Average Price" DESC


--What is the average Airbnb price per Neighbourhood?

SELECT neighbourhood AS "Neighbourhood", ROUND(AVG(price),2) AS "Average Price"
FROM airbnb_newyork..newyork_airbnb_data
GROUP BY neighbourhood
ORDER BY "Average Price" DESC


--What is the average Airbnb price per room type?

SELECT room_type AS "Room Type", ROUND(AVG(price),2) AS "Average Price"
FROM airbnb_newyork..newyork_airbnb_data
GROUP BY room_type
ORDER BY "Average Price" DESC


--How many Airbnbs mention the word "cozy"?

SELECT *
FROM airbnb_newyork..newyork_airbnb_data
WHERE "name" LIKE '%Cozy%'


--How many Airbnbs mention the word "studio"?

SELECT *
FROM airbnb_newyork..newyork_airbnb_data
WHERE "name" LIKE '%studio%' 