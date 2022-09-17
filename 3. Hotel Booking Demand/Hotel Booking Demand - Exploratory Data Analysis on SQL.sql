-- Taking a look at the dataset

SELECT * 
FROM hotelbookings;


-- Creating a table for Resort Hotel

SELECT *
INTO ResortHotel
FROM hotelbookings
WHERE hotel = 'Resort Hotel';


-- Creating a table for City Hotel

SELECT *
INTO CityHotel
FROM hotelbookings
WHERE hotel = 'City Hotel';


-- Counting how many observations (bookings) in the dataset

SELECT COUNT(*) AS TotalBookings
FROM hotelbookings;


-- Counting total bookings for each hotel type (resort vs city)

SELECT 
	hotel,
	COUNT(*) AS "Bookings",
	COUNT(*) * 100 / SUM(COUNT(*)) OVER() AS "PercentOfTotal"
FROM hotelbookings
GROUP BY hotel;


-- Cancellation rates and confirmed bookings for each hotel

SELECT
	hotel,
	COUNT(is_canceled) AS "ConfirmedBookings"
INTO #ConfirmedBookings
FROM hotelbookings
WHERE is_canceled = 0
GROUP BY hotel;

SELECT
	hotel,
	COUNT(is_canceled) AS "CanceledBookings"
INTO #CanceledBookings
FROM hotelbookings
WHERE is_canceled = 1
GROUP BY hotel;

SELECT
	A.hotel,
	A.ConfirmedBookings,
	B.CanceledBookings,
	A.ConfirmedBookings + B.CanceledBookings AS TotalBookings,
	A.ConfirmedBookings * 100 / (A.ConfirmedBookings + B.CanceledBookings) AS "ConfirmationRate",
	B.CanceledBookings * 100 / (A.ConfirmedBookings + B.CanceledBookings) AS "CancellationRate"
FROM #ConfirmedBookings AS A
	LEFT JOIN #CanceledBookings AS B
		ON A.hotel = B.hotel

DROP TABLE #ConfirmedBookings
DROP TABLE #CanceledBookings


-- Number of Arrivals per Year

SELECT
	hotel,
	arrival_date_year AS ArrivalYear,
	COUNT(arrival_date_year) AS NumberOfArrivals
FROM hotelbookings
GROUP BY arrival_date_year, hotel
ORDER BY 1,2 ASC;


-- Number of Arrivals per Month

SELECT
	hotel,
	arrival_date_month AS ArrivalMonth,
	COUNT(arrival_date_year) AS NumberOfArrivals
FROM hotelbookings
GROUP BY arrival_date_month, hotel
ORDER BY 1,2 ASC;


-- Average Length of Stay

SELECT
	hotel,
	ROUND(AVG(stays_in_week_nights +	stays_in_weekend_nights),2) AS AverageLengthOfStay
FROM hotelbookings
GROUP BY hotel;


-- Average Length of Stay by Arrival Month

SELECT
	hotel,
	arrival_date_month AS "ArrivalMonth",
	ROUND(AVG(stays_in_week_nights + stays_in_weekend_nights),2) AS AverageLengthOfStay
FROM hotelbookings
GROUP BY hotel, arrival_date_month
ORDER BY 1,3 DESC;


-- Average Length of Stay by Market Segment

SELECT 
	hotel, 
	market_segment AS "MarketSegment",
	ROUND(AVG(stays_in_week_nights + stays_in_weekend_nights),2) AS AverageLengthOfStay
FROM hotelbookings
GROUP BY hotel, market_segment
ORDER BY 1,3 DESC;


-- Checking the most popular meal types for each hotel

SELECT 
	hotel,
	meal AS MealType,
	COUNT(meal) AS NumberofBookings
FROM hotelbookings
GROUP BY hotel, meal
ORDER BY hotel, MealType;


-- Top 10 source markets for each hotel

SELECT 
	hotel,
	country,
	COUNT(country) AS "BookingsPerSourceMarket",
	DENSE_RANK() OVER(PARTITION BY hotel ORDER BY COUNT(country) DESC) AS "Top10SourceMarkets"
INTO #MainSourceMarkets
FROM hotelbookings
GROUP BY hotel, country
ORDER BY 1,3 DESC;

SELECT *
FROM #MainSourceMarkets
WHERE Top10SourceMarkets <= 10;

DROP TABLE #MainSourceMarkets;


-- Most significant market segments for each hotel 

SELECT 
	hotel,
	market_segment AS "MarketSegment",
	COUNT(market_segment) AS "BookingsPerMarketSegment"
FROM hotelbookings
GROUP BY hotel, market_segment
ORDER BY 1,3 DESC;


-- Most significant distribution channels for each hotel

SELECT 
	hotel,
	distribution_channel AS "DistributionChannel",
	COUNT(distribution_channel) AS "BookingsPerDistributionChannel"
FROM hotelbookings
GROUP BY hotel, distribution_channel
ORDER BY 1,3 DESC;


-- Number of Repeated Guests for Each Hotel

SELECT
	hotel,
	is_repeated_guest,
	CASE
		WHEN is_repeated_guest = 1 THEN 'Yes' ELSE 'No' END AS "RepeatedGuests"
INTO #RepeatedGuests
FROM hotelbookings

SELECT
	hotel,
	COUNT(RepeatedGuests) AS "RepeatedGuests"
FROM #RepeatedGuests
GROUP BY hotel, RepeatedGuests
ORDER BY 1,2;

DROP TABLE #RepeatedGuests


--Most common deposit types for each hotel

SELECT
	hotel,
	deposit_type,
	COUNT(deposit_type) AS "NumberofBookings"
FROM hotelbookings
GROUP BY hotel, deposit_type
ORDER BY 1,3 DESC;


-- Most significant customer type for each hotel

SELECT
	hotel,
	customer_type,
	COUNT(customer_type) AS "NumberOfBookings"
FROM hotelbookings
GROUP BY hotel, customer_type
ORDER BY 1,3 DESC;


-- Average Daily Rate (ADR) for each hotel

SELECT	
	hotel,
	ROUND(AVG(CAST(adr AS FLOAT)),2) AS "ADR"
FROM hotelbookings 
GROUP BY hotel;


-- ADR per Market Segment for each hotel

SELECT 
	hotel,
	market_segment,
	ROUND(AVG(CAST(adr AS FLOAT)),2) AS "ADR"
FROM hotelbookings
GROUP BY hotel, market_segment
ORDER BY 1,3 DESC;


-- ADR per Source Market (Top 10 Only)

SELECT
	hotel,
	country,
	ROUND(AVG(CAST(adr AS FLOAT)),2) AS "ADR"
INTO #AdrSourceMarkets
FROM hotelbookings
GROUP BY hotel, country
ORDER BY 1,3 DESC;

SELECT 
	*,
	DENSE_RANK() OVER(PARTITION BY hotel ORDER BY ADR DESC) AS Ranking
INTO #RankedSourceMarkets
FROM #AdrSourceMarkets

SELECT *
FROM #RankedSourceMarkets
WHERE Ranking <= 10;

DROP TABLE #AdrSourceMarkets
DROP TABLE #RankedSourceMarkets


-- ADR by Arrival Month for each hotel

SELECT
	hotel,
	arrival_date_month AS "ArrivalMonth",
	ROUND(AVG(CAST(adr AS FLOAT)),2) AS ADR
FROM hotelbookings
GROUP BY hotel, arrival_date_month
ORDER BY 1,2;


