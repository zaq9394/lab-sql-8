use sakila;
-- 1.Write a query to display for each store its store ID, city, and country.
SELECT s.store_id,ci.city,co.country from sakila.store s
JOIN sakila.customer c using(store_id)
JOIN sakila.address a 
ON a.address_id= c.address_id
JOIN sakila.city ci using(city_id)
JOIN sakila.country co using(country_id);
-- i am not sure if it is right or not. The question is so weird.

-- 2. Write a query to display how much business, in dollars, each store brought in.
SELECT s.store_id, count(p.amount) AS 'Amount of business' FROM sakila.store s
JOIN sakila.customer c USING(store_id)
JOIN sakila.payment p USING(customer_id)
GROUP BY s.store_id;

-- 3.Which film categories are longest?
SELECT c.name, avg(f.length) AS LENGTH FROM sakila.category c
JOIN sakila.film_category fc using(category_id)
JOIN sakila.film f using(film_id)
GROUP BY c.name
ORDER BY AVG(f.length) desc
LIMIT 1;

-- 4.Display the most frequently rented movies in descending order.
SELECT f.film_id,f.title,count(r.rental_id) AS 'Frequency of rental'FROM sakila.film f
JOIN sakila.inventory i using(film_id)
JOIN sakila.rental r using(inventory_id) 
GROUP BY f.film_id
ORDER BY count(r.rental_id) desc;

-- 5.List the top five genres in gross revenue in descending order.
SELECT c.category_id,c.name,count(p.amount)AS 'Revenue' FROM sakila.category c
JOIN sakila.film_category fc using(category_id)
JOIN sakila.inventory i using(film_id)
JOIN sakila.rental r using(inventory_id)
JOIN sakila.payment p using(rental_id)
GROUP BY c.category_id
ORDER BY count(p.amount) desc;

-- 6.Is "Academy Dinosaur" available for rent from Store 1?
SELECT DISTINCT a.store_id, a.title,CASE
WHEN a.title='Academy Dinosaur' AND a.store_id=1 then "YES"
ELSE 'NO'
END AS JUDGING from (SELECT f.film_id,f.title,s.store_id FROM sakila.film f
JOIN sakila.inventory i using(film_id)
JOIN sakila.store s using(store_id)) a
WHERE a.title="Academy Dinosaur";

-- 7.Get all pairs of actors that worked together.
SELECT a1.film_id AS FILM_ID,a1.actor_id AS A1, a2.actor_id AS A2,concat(a1.actor_id,' ',a2.actor_id) AS 'Pairs' from sakila.film_actor a1
JOIN sakila.film_actor a2 
ON (a1.film_id=a2.film_id) AND (a1.actor_id<>a2.actor_id)
WHERE a1.actor_id<a2.actor_id;
