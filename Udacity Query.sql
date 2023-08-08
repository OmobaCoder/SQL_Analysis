/*Q1 Query the database to displays all the data in the 
occurred_at, account_id, and channel columns of the web_events table,
and limits the output to only the first 15 rows.*/

SELECT occurred_at, account_id,channel
FROM web_events
ORDER BY account_id
LIMIT 15;

/* Q2 Write a query to return the 10 earliest orders in the 
orders table. Include the id,occurred_at, and total_amt_usd.*/
SELECT id, occurred_at,total_amt_usd
FROM orders
ORDER BY id ASC
LIMIT 10;

/*3. Write a query to return the top 5 orders in terms of 
largest total_amt_usd.Include the id, account_id,
and total_amt_usd.*/
SELECT id, account_id,total_amt_usd
FROM orders
ORDER BY total_amt_usd DESC
LIMIT 5;

/* 4 Write a query to return the lowest 20 orders in 
terms of smallest total_amt_usd.Include the id, 
account_id, and total_amt_usd.*/
SELECT id,account_id,total_amt_usd
FROM orders
ORDER BY total_amt_usd ASC
LIMIT 20;

/* 5. Write a query that displays the order ID, account ID, 
and total dollar amount for all the orders, sorted first by
the account ID (in ascending order), and then by 
the total dollar amount (in descending order).*/
SELECT id,account_id,total_amt_usd
FROM orders
ORDER BY account_id ASC,total_amt_usd DESC;

/* 6. Now write a query that again displays order ID,account ID, 
and total dollar amount for each order,but this time sorted first 
by total dollar amount(in descending order), 
and then by account ID (in ascending order).*/ 
SELECT id,account_id,total_amt_usd
FROM orders
ORDER BY total_amt_usd DESC,account_id ASC;

/*7. Compare the results of these two queries above. 
How are the results different when you switch the column you 
sort on first?*/
The first query sorts first by the account_id in Ascending order
(prioirity is placed on the account_id ).
The second query places priority on total_amt_usd whish is sorted in Desc order

/*8. Pulls the first 5 rows and all columns from the 
orders table that have a dollar amount of gloss_amt_usd 
greater than or equal to 1000.*/
SELECT *
FROM orders
WHERE gloss_amt_usd >=1000
LIMIT 5;
/*9. Pulls the first 10 rows and all columns from the orders 
table that have a total_amt_usd less than 500.*/
SELECT *
FROM orders
WHERE total_amt_usd <500
LIMIT 10;

/*10 Filter the accounts table to include the company name, 
website, and the primary point of contact (primary_poc) just for the
Exxon Mobil company in the accounts table.*/
SELECT name as Company_name, website, primary_poc
FROM accounts
WHERE name= 'Exxon Mobil';


-- Query2 Questions
-- 1. Use the accounts table to find 
SELECT * FROM accounts;
-- • All the companies whose names start with 'C'.
SELECT * FROM accounts
WHERE name LIKE 'C%';
• All companies whose names contain the string 'one' somewhere in the name.
SELECT * FROM accounts
WHERE name LIKE '%one%';
• All companies whose names end with 's'.
SELECT * FROM accounts
WHERE name LIKE '%s';

/*2. Use the accounts table to find the account name, primary_poc, and 
sales_rep_id for Walmart, Target, and Nordstrom. */
SELECT name, primary_poc,sales_rep_id
FROM accounts
WHERE name IN('Walmart', 'Target', 'Nordstrom');

/*3. Use the web_events table to find all information regarding 
individuals who were contacted via the channel of organic or adwords.*/
SELECT * 
FROM web_events
WHERE channel IN('organic', 'adwords');

/*4. Write a query that returns all the orders where the 
standard_qty is over 1000,the poster_qty is 0, and the gloss_qty is 0.*/
SELECT * FROM orders
WHERE standard_qty >1000 OR poster_qty=0 OR gloss_qty=0;

/* 5. Using the accounts table, find all the companies whose 
names do not start with 'C' and end with 's'.*/
SELECT * FROM accounts
WHERE name NOT LIKE 'C%'AND name NOT LIKE '%s';

/*6. When you use the BETWEEN operator in SQL,do the results include the values of
your endpoints, or not? 
Figure out the answer to this important question by writing a query that displays
the order date and gloss_qty data for all orders where gloss_qty
is between 24 and 29. Then look at your output to see if the BETWEEN operator
included the begin and end values or not.*/
SELECT occurred_at as order_date, gloss_qty
FROM orders
WHERE gloss_qty BETWEEN 24 AND 29;

-- The between operator includes both start and enpoint values

/*7. Use the web_events table to find all information regarding 
individuals who were contacted via the organic or adwords channels, 
and started their account at any point in 2016, sorted from newest to oldest.*/

SELECT * FROM web_events
WHERE channel IN ('organic', 'adwords') AND Extract(YEAR FROM occurred_at)= 2016
ORDER BY occurred_at ASC;

/*8. Find list of orders ids where either gloss_qty or 
poster_qty is greater than 4000.Only include the id field in the resulting table.*/
SELECT id FROM orders
WHERE gloss_qty>4000 or poster_qty>4000;

/*9. Write a query that returns a list of orders where the standard_qty is zero 
and either the gloss_qty or poster_qty is over 1000.*/
SELECT * FROM orders
WHERE standard_qty = 0 AND(gloss_qty>1000 OR poster_qty>1000);

/* 10. Find all the company names that start with a 'C' or 'W', 
and the primary contact contains 'ana' or 'Ana', but it doesn't contain 'eana'.*/

SELECT name FROM accounts
WHERE name LIKE 'C%' OR name LIKE 'W%' 
AND primary_poc LIKE '%ana%' OR primary_poc LIKE '%Ana%' 
AND primary_poc NOT LIKE '%eana%';

/*11. Create a column that divides the standard_amt_usd by the standard_qty to
find the unit price for standard paper for each order. Limit the results to 
the first 10 orders, and include the id and account_id fields.*/

SELECT id, account_id,(standard_amt_usd/standard_qty) AS unit_price
FROM orders
WHERE standard_amt_usd !=0
GROUP BY id,account_id,unit_price
-- ORDER BY unit_price DESC
LIMIT 10;

/*12. Write a query that finds the percentage of revenue that comes from
poster paper for each order. You will need to use only the columns that 
end with _usd. (Try to do this without using the total column.) 
Display the id and account_id fields*/
SELECT * FROM orders
WHERE (standard_amt_usd,gloss_amt_usd,poster_amt_usd)<>(0,0,0);

SELECT id,account_id, ROUND((standard_amt_usd/total_amt_usd)*100,2) AS standard_amt_percent,
ROUND((gloss_amt_usd/total_amt_usd)*100,2) AS gloss_amt_percent, 
ROUND((poster_amt_usd/total_amt_usd) * 100,2) AS poster_amt_percent
FROM orders
WHERE(standard_amt_usd,gloss_amt_usd,poster_amt_usd)!=(0,0,0)
GROUP BY id,account_id,standard_amt_percent,gloss_amt_percent,poster_amt_percent;

/*13. Pulls the first 5 rows and all columns from the orders table that have a dollar
amount of gloss_amt_usd greater than or equal to 1000.*/
SELECT * FROM orders
WHERE gloss_amt_usd >=1000
LIMIT 5;

/*14. Pulls the first 10 rows and all columns from the orders table that have a
total_amt_usd less than 500.*/

SELECT * FROM orders
WHERE total_amt_usd <500
LIMIT 10;

-- Query3 SQL JOINS
/*1. Provide a table for all web_events associated with account name of Walmart. 
There should be three columns. Be sure to include the primary_poc, 
time of the event, and the channel for each event.Additionally, you might choose 
to add a fourth column to assure only Walmart events were chosen.*/
SELECT w.account_id,w.channel,a.primary_poc,a.name
FROM accounts a
JOIN web_events w ON
a.id=w.id
WHERE a.name= 'Walmart';

/*2. Provide a table that provides the region for each sales_rep along with 
their associated accounts. Your final table should include three columns: 
the region name, the sales rep name, and the account name. 
Sort the accounts alphabetically (A-Z) according to account name.*/
SELECT r.name region_name, s.name salesrep_name , a.name account_name
FROM region r
JOIN sales_reps s
ON r.id = s.region_id
JOIN accounts a ON
a.sales_rep_id = s.id
ORDER BY region_name ASC;

/*3. Provide the name for each region for every order, as well as
the account name and the unit price they paid (total_amt_usd/total)
for the order. Your final table should have 3 columns: region name,
account name, and unit price. A few accounts have 0 for total, 
so I divided by (total + 0.01) to assure not dividing by zero.*/
SELECT a.name account_name,r.name region_name,
ROUND(o.total_amt_usd/(o.total+0.01),2)AS unit_price
FROM accounts a
JOIN sales_reps s ON
a.sales_rep_id = s.id
JOIN region r ON
r.id = s.region_id
JOIN orders o ON
r.id = o.id;

/*4. Provide a table that provides the region for each sales_rep along with 
their associated accounts. This time only for the Midwest region.Your final table
should include three columns: the region name,the sales rep name, and the 
account name.Sort the accounts alphabetically (A-Z) according to account name. */
SELECT s.name salesrep,a.name account_name, r.name region_name
FROM sales_reps s
JOIN accounts a ON
s.id = a.sales_rep_id
JOIN region r ON
r.id = s.region_id
WHERE r.name = 'Midwest'
ORDER BY a.name ASC;

/*5 Provide a table that provides the region for each sales_rep along with their 
associated accounts. This time only for accounts where the sales rep has a first name
starting with S and in the Midwest region.Your final table should include three 
columns: the region name, the sales rep name,and the account name. 
Sort the accounts alphabetically (A-Z) according to account name.*/
SELECT s.name salesrep,a.name account_name, r.name region_name
FROM sales_reps s
JOIN accounts a ON
s.id = a.sales_rep_id
JOIN region r ON
r.id = s.region_id
WHERE r.name = 'Midwest' and a.name LIKE 'S%'
ORDER BY a.name ASC;

/*6. Provide a table that provides the regionfor each sales_rep along with their
associated accounts.This time only for accounts where the sales rep has a last name 
starting with K and in the Midwest region. Your final table should include three
columns: the region name, the sales rep name,and the account name. 
Sort the accounts alphabetically (A-Z) according to account name.*/

SELECT r.name AS region_name, s.name AS salesrep, a.name AS account_name
FROM sales_reps s
JOIN accounts a ON s.id = a.sales_rep_id
JOIN region r ON r.id = s.region_id
WHERE r.name = 'Midwest' AND substring(s.name from '\s(.*)') LIKE 'K%'
ORDER BY a.name ASC;
/*7. Provide the name for each region for every order, as well as the account name 
and the unit price they paid (total_amt_usd/total) for the order.However, you 
should only provide the results if the standard order quantity exceeds 100. 
Your final table should have 3 columns: region name, account name, and unit price. 
In order to avoid a division by zero error, adding .01 to the denominator here is 
helpful total_amt_usd/(total+0.01) */

SELECT a.name account_name,r.name region_name,
ROUND(o.total_amt_usd/(o.total+0.01),2)AS unit_price
FROM accounts a
JOIN sales_reps s ON
a.sales_rep_id = s.id
JOIN region r ON
r.id = s.region_id
JOIN orders o ON
r.id = o.id
WHERE o.standard_qty >100;

/*8. Provide the name for each region for every order, as well as the account name and
the unit price they paid (total_amt_usd/total) for the order. However, 
you should only provide the results if the standard order quantity 
exceeds 100 and the poster order quantity exceeds 50. Your final table should have
3 columns: region name, account name, and unit price. Sort for the smallest 
unit price first. In order to avoid a division by zero error,adding .01 to the
denominator here is helpful (total_amt_usd/(total+0.01). */

SELECT a.name account_name,r.name region_name,
ROUND(o.total_amt_usd/(o.total+0.01),2)AS unit_price
FROM accounts a
JOIN sales_reps s ON
a.sales_rep_id = s.id
JOIN region r ON
r.id = s.region_id
JOIN orders o ON
r.id = o.id
WHERE o.standard_qty >100 AND o.poster_qty>50;

/* 9 What are the different channels used by account id 1001? Your final table should
have only 2 columns: account name and the different channels.You can try 
SELECT DISTINCT to narrow down the results to only the unique values.*/

SELECT DISTINCT  a.name,w.id
FROM web_events w
JOIN accounts a ON
w.account_id = a.id
WHERE w.id = 1001;