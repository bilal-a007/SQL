-- Question 1 Who is the senior most employee based on job title?
select * from employee
order by levels desc
limit 1

--Q2 Which countries have the most invoices?
select billing_country, count(*)  from invoice
group by billing_country 
order by count(*) desc

--Q3 What are top 3 values of total invoice?

select total from invoice
order by total desc
limit 3

-- Q4 Which city has the best customers? We would like to throw a promotional Music Festival in the city we made the most money. Write a query that returns one city that has the highest sum of invoice totals. Return both the city name & sum of all invoice totals.

select billing_city, sum(total) from invoice
group by billing_city
order by sum(total) desc
limit 1

--Q5 Who is the best customer? The customer who has spent the most money will be declared the best customer. Write a query that returns the person who has spent the most money.

select customer.customer_id, customer.first_name, customer.last_name, sum(invoice.total) from customer
join invoice on customer.customer_id = invoice.customer_id
Group by customer.customer_id
order by sum(invoice.total) desc
limit 1

--set 2 Q1  Write query to return the email, first name, last name, & Genre of all Rock Music listeners. Return your list ordered alphabetically by email starting with A.

--select * from genre
--select * from customer
--select * from invoice_line
--select * from track

select distinct customer.first_name, customer.last_name, customer.email
from customer
join invoice on customer.customer_id = invoice.customer_id
join invoice_line on invoice.invoice_id = invoice_line.invoice_id 
join track on invoice_line.track_id = track.track_id
join genre on track.genre_id = genre.genre_id

where genre.name = 'Rock'
order by email asc


--Set 2 Q2 Let's invite the artists who have written the most rock music in our dataset. Write a query that returns the Artist name and total track count of the top 10 rock bands.

--select  artist.name track, track_id, genre.genre_id, count (genre.genre_id) from artist

select  artist.name track, count (genre.genre_id) from artist
join album on artist.artist_id = album.artist_id
join track on album.album_id = track.album_id
join genre on track.genre_id = genre.genre_id

where genre.genre_id like '1'
group by artist.name
order by count (genre.genre_id) desc
limit 10

-- set 2 Q3 Return all the track names that have a song length longer than the average song length. Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed first.

select name, milliseconds from track where  milliseconds > (select avg(milliseconds) from track)
order by milliseconds desc
--select avg (milliseconds) from track