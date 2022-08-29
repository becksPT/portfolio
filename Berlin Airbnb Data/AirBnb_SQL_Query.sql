--Checking listings Dataset
SELECT *
FROM airbnb..listings 

-- Checking more detailed listings dataset

SELECT * 
FROM listings_summary


--Combining both tables for a final dataset

SELECT ls1.id, ls1.host_id, ls2.city, ls2.country, ls1.latitude, ls1.longitude,ls2.property_type, ls2.accommodates, ls1.room_type, 
ls1.minimum_nights, ls2.maximum_nights, ls1.price, ls2.weekly_price, ls2.monthly_price, ls2. security_deposit, ls2.cleaning_fee, ls2.extra_people,
ls2.first_review, ls2.last_review, ls2.review_scores_rating, ls2.reviews_per_month INTO final_dataset
FROM listings as ls1 
RIGHT JOIN listings_summary as ls2 ON ls1.id = ls2.id;


--ALTER "first_review" and "last_review" from datetime to date dtype

ALTER TABLE airbnb..final_dataset
ALTER COLUMN first_review DATE
GO

ALTER TABLE airbnb..final_dataset
ALTER COLUMN last_review DATE
GO

SELECT *
FROM airbnb..final_dataset

