use project;

/* Who is the senior most employee based on job title?  */

SELECT * FROM EMPLOYEE 
ORDER BY LEVELS DESC LIMIT 1;


/* Which countries have the most Invoices? */

SELECT COUNT(*) AS Count, BILLING_COUNTRY FROM invoice
GROUP BY billing_country
ORDER BY Count DESC;


/* What are top 3 values of total invoice? */

SELECT * FROM invoice 
ORDER BY total DESC LIMIT 3;


/*  Which city has the best customers? We would like to throw a promotional Music 
Festival in the city we made the most money. Write a query that returns one city that 
has the highest sum of invoice totals. Return both the city name & sum of all invoice 
totals */

SELECT billing_city,SUM(total) AS sum FROM invoice
GROUP BY billing_city
ORDER BY sum desc Limit 1; 


/*  Who is the best customer? The customer who has spent the most money will be 
declared the best customer. Write a query that returns the person who has spent the 
most money */

SELECT FIRST_NAME,LAST_NAME, sum(total) as spent from  CUSTOMER 
JOIN invoice ON customer.customer_id=invoice.customer_id
group by customer.customer_id,customer.first_name,customer.last_name
order by spent desc limit 1;


/*  Write query to return the email, first name, last name, & Genre of all Rock Music listeners. 
Return your list ordered alphabetically by email starting with A.    */

select * from genre;  # To see the all records from genre table
select * from customer; # To see the all records from customer table
select * from track;


SELECT DISTINCT email AS Email,first_name AS FirstName, last_name AS LastName, genre.name AS Name
FROM customer
JOIN invoice ON invoice.customer_id = customer.customer_id
JOIN invoice_line ON invoice_line.invoice_id = invoice.invoice_id
JOIN track ON track.track_id = invoice_line.track_id
JOIN genre ON genre.genre_id = track.genre_id
WHERE genre.name LIKE 'Rock'
ORDER BY email;


/*   Let's invite the artists who have written the most rock music in our dataset. 
Write a query that returns the Artist name and total track count of the top 10 rock bands.  */

SELECT artist.artist_id, artist.name, COUNT(artist.artist_id) AS number_of_songs
FROM track
JOIN album ON album.album_id = track.album_id
JOIN artist ON artist.artist_id = album.artist_id
JOIN genre ON genre.genre_id = track.genre_id
WHERE genre.name LIKE 'Rock'
GROUP BY artist.artist_id, artist.name
ORDER BY number_of_songs DESC
LIMIT 10;

/*   Return all the track names that have a song length longer than the average song length. 
Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed first.    */

SELECT * FROM track;

SELECT name,milliseconds FROM track
WHERE milliseconds > (SELECT AVG(milliseconds) AS avg_track_length FROM track )
ORDER BY milliseconds DESC;
