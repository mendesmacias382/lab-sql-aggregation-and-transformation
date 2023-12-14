#- 1.1 Determine the **shortest and longest movie durations** and name the values as `max_duration` and `min_duration`.
#- 1.2. Express the **average movie duration in hours and minutes**. Don't use decimals.
#- *Hint: Look for floor and round functions.*

Select max(length) as max_duration, min(length) as min_duration
from film;

SELECT 
    AVG(length) AS avg_length,
    FLOOR(AVG(length) / 60) AS hours,
    ROUND((AVG(length) - FLOOR(AVG(length) / 60) * 60)) AS seconds
FROM film;

#2. You need to gain insights related to rental dates:
#- 2.1 Calculate the **number of days that the company has been operating**.
#- *Hint: To do this, use the `rental` table, and the `DATEDIFF()` function to subtract the earliest date in the `rental_date` column from the latest date.*


select 
	timestampdiff(day, min(rental_date), max(rental_date)) as diff_date
from rental;

#2.2 Retrieve rental information and add two additional columns to show the **month and weekday of the rental**. 
#Return 20 rows

select 
	rental_date,
    Month(rental_date) as Month,
    dayname(rental_date) as WeekDay
from rental
limit 20;


#3. You need to ensure that customers can easily access information about the movie collection. 
#To achieve this, retrieve the **film titles and their rental duration**. 
#If any rental duration value is **NULL, replace** it with the string **'Not Available'**. 
#Sort the results of the film title in ascending order.
#- *Please note that even if there are currently no null values in the rental duration column, the query should still be written to handle such cases in the future.*
#- *Hint: Look for the `IFNULL()` function.*

select title, 
	ifnull(rental_duration, ' Not Avaiable') as rental_duration
from film;

## Challenge 2

#Next, you need to analyze the films in the collection to gain some more insights. Using the `film` table, determine:
#1.1 The **total number of films** that have been released.
#1.2 The **number of films for each rating**.
#1.3 The **number of films for each rating, sorting** the results in descending order of the number of films.
#This will help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly.

select sum(film_id) as total_films
from film;

select rating, count(film_id) as film_by_rating
from film
group by rating;

select rating, count(film_id) as film_by_rating
from film
group by rating
order by count(film_id)asc;

#2. Using the `film` table, determine:
#2.1 The **mean film duration for each rating**, and sort the results in descending order of the mean duration. 
#Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.

select rating, round(avg(length), 2) as mean_film_duration
from film
group by rating 
order by mean_film_duration desc;


	# 2.2 Identify **which ratings have a mean duration of over two hours** in order to help select films for customers who prefer longer movies.

SELECT rating, AVG(length) AS mean_duration
FROM film
GROUP BY rating
HAVING mean_duration > 120;
