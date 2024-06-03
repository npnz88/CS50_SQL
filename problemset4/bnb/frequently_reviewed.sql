--In frequently_reviewed.sql, write a SQL statement to create a view named frequently_reviewed. This view should contain the 100 most frequently reviewed listings, sorted from most- to least-frequently reviewed.
--no_des_reviews
--Wirte a CTE to aggregate all the reviews
CREATE VIEW "frequently_reviewed" AS
    SELECT "listings"."id", "listings"."property_type", "listings"."host_name", COUNT("reviews"."listing_id") as "reviews"
    FROM "listings"
    JOIN "reviews" ON "listings"."id" = "reviews"."listing_id"
    GROUP BY "reviews"."listing_id"
    ORDER BY "reviews" DESC, "listings"."property_type", "listings"."host_name"
    LIMIT 100;


