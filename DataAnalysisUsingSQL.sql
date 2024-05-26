Select * from artist
Select * from canvas_size
Select * from image_link
select * from museum_hours
select * from museum 
select * from product_size
Select * from subject
Select * from work 


---Q1 Identify the artists whose paintings are displayed in multiple countries:--

SELECT a.full_name
FROM artist a
JOIN work w ON a.artist_id = w.artist_id
JOIN museum m ON w.museum_id = m.museum_id
GROUP BY a.full_name
HAVING COUNT(DISTINCT m.country) > 1;


----Q2 Which are the top 5 most popular museums? (Popularity is defined based on the number of paintings in a museum):


SELECT m.name, COUNT(w.work_id) AS num_paintings
FROM museum m
JOIN work w ON m.museum_id = w.museum_id
GROUP BY m.name
ORDER BY num_paintings DESC
LIMIT 5;

--Q3 Fetch the top 10 most famous painting subjects:

SELECT s.subject, COUNT(*) AS subject_count
FROM work w
JOIN subject s ON w.work_id = s.work_id
GROUP BY s.subject
ORDER BY subject_count DESC
LIMIT 10;

--- Q4 Identify the museums which are open on both Sunday and Monday.

SELECT mh.museum_id, m.name, m.city
FROM museum_hours AS mh
JOIN museum AS m ON mh.museum_id = m.museum_id
WHERE day = 'Sunday' AND mh.museum_id IN (SELECT museum_id FROM museum_hours WHERE day = 'Monday');
  
---Q5 Identify the top 5 artists whose paintings are displayed in multiple countries  
  
SELECT a.full_name AS artist_name, COUNT(DISTINCT m.country) AS num_of_countries_displayed
FROM museum AS m
JOIN work AS w ON m.museum_id = w.museum_id
JOIN artist AS a ON w.artist_id = a.artist_id
GROUP BY a.full_name
HAVING COUNT(DISTINCT m.country) > 2
ORDER BY num_of_countries_displayed DESC
LIMIT 5;


---Q6 Fetch all the paintings which are not displayed at any museums

SELECT name
FROM work
WHERE museum_id IS NULL


---- Q7 Most expensive Paintnig 
SELECT a.full_name AS artist_name, w.name AS painting_name,ps.sale_price AS price,m.name, m.city
FROM work w
JOIN artist a ON w.artist_id = a.artist_id
JOIN museum m ON w.museum_id = m.museum_id
JOIN product_size ps ON w.work_id = ps.work_id
ORDER BY ps.sale_price DESC
LIMIT 1;


----Q8 Least Expensive Paintings:

SELECT a.full_name AS artist_name, w.name AS painting_name, ps.sale_price AS price, m.name AS museum_name, m.city
FROM work w
JOIN artist a ON w.artist_id = a.artist_id
JOIN museum m ON w.museum_id = m.museum_id
JOIN product_size ps ON w.work_id = ps.work_id
ORDER BY ps.sale_price ASC
LIMIT 1;
  

----Q9 Identify the artist with the highest average sale price of their paintings:

SELECT a.full_name AS artist_name,ROUND(AVG(ps.sale_price)) AS avg_sale_price
FROM product_size ps
JOIN work w ON ps.work_id = w.work_id
JOIN artist a ON w.artist_id = a.artist_id
GROUP BY a.full_name
ORDER BY AVG(ps.sale_price) DESC
LIMIT 1;

---Q10 Find the museum with the most diverse collection of painting subjects:

SELECT m.name AS museum_name,COUNT(DISTINCT w.work_id) AS unique_subjects_count
FROM work w
JOIN museum m ON w.museum_id = m.museum_id
GROUP BY m.name
ORDER BY COUNT(DISTINCT w.work_id) DESC
LIMIT 1;

---Which country has the 5th highest no of paintings?

SELECT m.country,COUNT(w.work_id) AS painting_count
FROM museum m
JOIN work w ON m.museum_id = w.museum_id
GROUP BY m.country
ORDER BY COUNT(w.work_id) DESC
OFFSET 4
LIMIT 1;


