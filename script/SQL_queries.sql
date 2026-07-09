
select first_name, lower(country) from dbo.customers where score >= 500; 
select * from dbo.customers; 
select score, upper(country) from dbo.customers where country = 'Germany'; 
select  * from dbo.orders; 
select customer_id, sales from orders; 
select first_name, country from customers; 
select *  from customers where country = 'germany'; 

select * from customers order by score asc; 
select * from customers order by score desc;
select * from customers order by score; 
select * from customers order by country, score desc;

select sum(score), country from customers group by country; 
select country, sum(score) as total_score from customers group by country;

select 
country, 
count(id) as no_of_customers, 
sum(score) as total_score
from customers group by country;     --this will groupby based on country and display sum and count 
--in group by you can only have columns displayed that are either part of group by of having sum form of aggregation like sum() or count()


select country, first_name, sum(score) as total from customers group by country, first_name; 
--here groupby will happen based on both country and first_name, means score will only be aggregated and displayed when both the country and the name of a record is the same


--HAVING: this can be only used after groupby 
select country, sum(score) as total from customers group by country having sum(score) > 800; 

select country, sum(score) as total from customers where score > 400 group by country having sum(score) > 800; 

where basically tells you what to select before and group by is applied on whats finally selected, after that having is applied to filter rows based on some condition after the aggregation/group by


select country, avg(score) as average from customers where score != 0 group by country having avg(score) > 430; 

select distinct country from customers; 

--TOP: restrcits the number of rows that are returned, you can use it right after the keyword top

select top 3 * from customers order by score desc; 
-- the above query will sort the customers based on descending order and then select the top 3

select top 2 * from customers order by score asc; 
-- the above query will sort the customers based on ascending order and then return the bottom 2


-- task: get the two most recent orders 

select top 2 * from orders order by order_date desc; 


select 123 as my_num;   -- here we simply selected a value that we gave

select first_name, country, 123 as random_number from customers;   -- an example of us giving a random value

-- if you dont wanna execute the full query just highlight what u wanna execute  with your mouse 
-- if something is highlighted on a page then only that highlighted query will be executed if at all 

select * from customers where score > 400; 

--CREATE TABLE
create table persons(id int not null, person_name varchar(50), birth_date date, phone varchar(15) not null, constraint pk_persons primary key(id)); 
select * from persons; 
--in the above statement the constraint named pk_persons is only visible to the database and says that id is our primary key 


--alter table persons add email varchar(50) not null; 
--select * from persons; 

--alter table persons drop column phone; 
--select * from persons; 

--drop table persons; 
--select * from persons;   -- this will show error as the table persons has now been dropped


--insert into customers (id, first_name, country, score) values (6, 'Anna', 'USA', NULL), (7, 'Sam', NULL, 100);  

--insert into customers values (9, 'Andreas', 'Germany', NULL);
insert into customers (id, first_name) values (10, 'Sahra'); 
select * from customers;


--lets say you wanna select values from the table but hide the last two columns with some keyword but have the columsn display 

--select  id, first_name, 'hidden', 'hidden' from customers; 
--create table persons (id int, namee varchar(30), birth_date date, phone int); 
--select * from persons; 

--we can also select some values from a table and directly insert them into another table

--insert into persons(id, namee, birth_date, phone) select id, first_name, NULL, NULL from customers

--select * from customers; 
--update customers set score = 0 where id = 6;
--select * from customers; 

--update customers set score = 0, country = 'UK' where id = 10; 
--select * from customers; 
--update customers set score = 0 where score is NULL; 
--select * from customers; 

--delete from customers where id > 5; 
--select * from customers

--if you wanna delete all rows from a table: truncate tale persons

--select * from customers where country <> 'Germany';   -- this <> works same as !=

--LOGICAL OPERATORS
--the AND operator
select * from customers where country = 'USA' and score > 500; 
--the OR operator
select * from customers where country = 'USA' or score > 500; 
--the NOT operaotr
select * from customers where not score > 600; 


select * from customers where score between 100 and 500; 
select * from customers where score >= 100 and score <= 500; 

--IN
select * from customers where country in ('Germany', 'USA'); 
select * from customers where country not in ('Germany', 'USA'); 

--LIKE OPERATOR
select * from customers where first_name like 'M%'; 
select * from customers where first_name like '%n';  
select * from customers where first_name like '%r%'; 
select * from customers where first_name like '__r%';


-- NO JOIN
-- this will simply return data from the tables without joining them 
-- here for this no join we can simlly write two select all queries

--THE INNER JOIN
--this will join the tables based on some sort of condition and return the common values

select * from customers; 
select * from orders;

--question: select all customers along with their orders who have placed an order

select * from customers inner join orders on id = customer_id; 
select id, first_name, order_id, sales from customers inner join orders on id = customer_id; 

select customers.id, customers.first_name, orders.order_id, orders.sales from 
customers inner join orders on customers.id = orders.customer_id; 

--we can also fetch the tables through aliasing and then use that alias in our join query to avoid typing 
--the whole table name multiple times in the jojn query 

select c.id, c.first_name, o.order_id, o.sales from 
customers as c inner join orders as o on c.id = o.customer_id; 

--for inner join the order in which u state the tables dosent matter, customers inner join orders is same as
--orders inner join customers

--theta join with 1 cdn
select * from customers inner join orders on customers.id = orders.customer_id 
where orders.sales > 15; 
--theta join with 2 cdn 
select * from customers inner join orders on customers.id = orders.customer_id 
where orders.sales > 15 and customers.score > 400; 


--natrual join will automatically join tables on columns with the same name, means it uses the 
-- = comparison only and then remove the duplicate rows in the result

--Natural join is an equi join that automatically joins tables on all attributes having the same name
--and eliminates duplicate columns in the result.

--question: get all customers along with their orders, including those without orders
--we do an outer left join here 

select * from customers; 
select * from orders; 
select * from customers left join orders on customers.id = orders.customer_id; 

--Right join: keep everything from the right table and only matching from the left, if left has 
--no matching records replace with null
--question: get all customers along with their orders, including orders without matching customers
select * from customers right join orders on customers.id = orders.customer_id; 

--question: get all orders and customers, even if there is no match 
select * from customers; 
select * from orders; 
select * from customers full join orders on customers.id = orders.customer_id; 

-- now lets say that you wanna get values where left join yielded null values on the right side
--means now we can do a left anti join like this: 

select * from customers left join orders on customers.id = orders.customer_id 
where orders.customer_id is null; 

select * from customers right join orders on customers.id = orders.customer_id where 
customers.id is null; 

--FULL ANTI JOIN 
-- here we find such that to return the results of full join where you got null values on both the sides
--question: find customers without orders and orderd without customers

select * from customers full join orders on customers.id = orders.customer_id 
where orders.customer_id is null and customers.id is null;

-- the above is wrong because you wont get both sides as null ofc
select * from customers full join orders on customers.id = orders.customer_id 
where orders.customer_id is null or customers.id is null; 


--CROSS JOIN: combines every row from left with every row from right 
--the result is bascially nothing but cartesian product
--select * from customers cross join orders;

select * from customers; 
select * from employees; 
select FirstName, LastName from customers union select FirstName, LastName from employees; 

--to perform set union the no of columns must be the same and the coulumns must be type compatible, 
--the order of the types of the columns must also be the same, the alias of the union column will be determined
--by the first select query 

select FirstName as F, LastName as L from customers union select FirstName, LastName from employees
order by F;

-- regular union wont give you duplicates, union all will give u the duplicates too
select firstname, lastname from customers union all select firstname, lastname from employees; 


--except: its like set A - set B, eles from set A that are not in set B 

select firstname, lastname from employees except select firstname, lastname from customers
order by firstname; 
select firstname, lastname from customers except select firstname, lastname from employees
order by firstname; 


--intersect: returns common tuples, works somewhat like inner join and does not return duplicates 
select firstname, lastname from customers intersect select firstname, lastname from employees; 

select concat(first_name, country) as name_country from customers; 
select concat(first_name, ' ', country) as name_country from customers;
select concat(first_name, '-', country) as name_country from customers;


select lower(first_name) from customers; 
select upper(first_name) from customers; 

--TIRM: removes the leading and trailing spaces in a string value
select * from customers where first_name != trim(first_name); 

select first_name, len(first_name), len(trim(first_name)) as space_removed_len from customers; 

select first_name, len(first_name), len(trim(first_name)) as space_removed_len,
len(first_name) - len(trim(first_name)) as no_of_spaces from customers; 


select '1234-567-890' as phone, replace('1234-567-890', '-', '') as clean_phone; 
select 'file.txt' as file_name, replace('file.txt', 'txt', 'csv') as new_file; 
--in replace we gave the attribute and then followed it with what needs to be replaced and by what
select first_name, len(first_name) as lengthh from customers; 

--LEFT AND RIGHT
select left(trim(first_name), 2) as first_2_char from customers; 
select right(trim(first_name), 2) as last_2_char from customers; 

--substring(value, start pos, length) 
select first_name, substring(first_name, 2, 4) as display_val from customers;
select first_name, substring(first_name, 2, len(first_name)) as display_val from customers;
select first_name, substring(first_name, 2, 99) as display_val from customers;


--ROUND: this can round a number up, for example if we have round 2, means we only wanna see 2 numbers after the deciamal 
--place, means keep 2 digits after the decimal place and use the 3rd digit after the decimal to have rounding, round if this digit
--more or equal to 5
--round(number, no_of_digits_u_wanna_have_after_decimal)

select round(3.516, 2); 
select round(3.234, 0); 
select round(3.89990, 3)
select round(3.55, 1); 
select abs(-10); 
select abs(10); 
select abs(-9493); 


--DATE TIME AND YEAR FUNCS

select orderid, creationtime, year(creationtime) as yr, month(creationtime) as monthh, 
day(creationtime) as dayy from orders;


--DATEPART: datepart(part, date_var)
select creationtime, datepart(year, creationtime) as year_dp, 
datepart(month, creationtime) as month_dp,
datepart(day, creationtime) as day_dp, 
datepart(week, creationtime) as week_dp, 
datepart(quarter, creationtime) as quarter_dp, 
datepart(hour, creationtime) as hour_dp, 
datepart(minute, creationtime) as minute_dp, 
datepart(second, creationtime) as second_dp, 
datepart(weekday, creationtime) as weekday_dp from orders; 


--datename: returns name of a part of a date 

select creationtime, datename(year, creationtime) as year_dn, 
datename(month, creationtime) as month_dn,
datename(day, creationtime) as day_dn, 
datename(week, creationtime) as week_dn, 
datename(quarter, creationtime) as quarter_dn, 
datename(hour, creationtime) as hour_dn, 
datename(minute, creationtime) as minute_dn, 
datename(second, creationtime) as second_dn, 
datename(weekday, creationtime) as weekday_dn  from orders; 


--datetrunc: resets teh column that has not been specified, means, if u say datetrunc(date, minutes)
--you will have the seconds reset to 00. 
--and if you say datetrunc hour, then the minutes and seconds will be reset to 00

select orderid, creationtime, datetrunc(year, creationtime) as yr_dt, 
datetrunc(day, creationtime) day_dt, datetrunc(minute, creationtime) as minute_dt, 
datetrunc(hour, creationtime) from orders; 

--eomonth() will give you the end of the month 
select orderid, creationtime, eomonth(creationtime) as eo_month from orders; 


select year(orderdate), count(orderdate) as cnt from orders group by year(orderdate); 
select datename(month, orderdate), count(orderdate) as cnt from orders 
group by datename(month, orderdate); 
select day(orderdate), count(orderdate) as cnt from orders group by day(orderdate); 

select * from orders where datepart(month, orderdate) = 2; 

-- dd gives numeric day of the month while ddd gives string day of the week 
--dddd give full weekday name 
--mm: minutes, MM: months
select orderid, creationtime, format(creationtime, 'dd') as day, 
format(creationtime, 'ddd' ) as weekday, 
format(creationtime, 'dddd') as full_weekday from orders; 

select orderid, creationtime, format(creationtime, 'MM') as day, 
format(creationtime, 'MMM' ) as weekday, 
format(creationtime, 'MMMM') as full_weekday from orders; 

select orderid, creationtime, format(creationtime, 'MM-dd-yyyy') as usa, 
format(creationtime, 'yyyy-MM-dd' ) as ISO, 
format(creationtime, 'dd-MM-yyyy') as european from orders; 
 

 select orderid,creationtime, format(creationtime, 'hh:mm:ss tt') as time from orders; 
 select format(orderdate, 'MMMM yyyy') as ord, count(*) as cnt from orders 
 group by format(orderdate, 'MMMM yyyy'); 
 

 --convert(type to be converted to, variable to be conv, style example)

--the 2nd arg is what needs to be converted and the 3rd arg is whats the style 
--defualt style is 0

 select convert(int, '124');    --here u have converted the var '124'
 select convert(date, '2025-08-20'); 
 select format(1234.56, 'N'); 
 select format(1234.56, 'P');
 select format(1234.56, 'C');
 select format(1234.56, 'E');
 select format(1234.56, 'F');
 select format(1234.56, 'N0');
 select format(1234.56, 'N1');
 select format(1234.56, 'N2');
 select format(1234.56, 'N3');
 
 -- style 32 is a form of style
 --our creation time shows time too, show me only date. we can do this by converting it to date 

 select convert(date, creationtime) as creation_date, 
 convert(varchar, creationtime, 32) as us_std_style32 
 from orders;
 

 --cast(): converts a value to a specific data type
 select cast('123' as int), cast(123 as varchar), 
 cast('2025-08-20' as date), 
 cast('2025-08-20' as datetime), 
 cast('2025-08-20' as datetime2); 

 select creationtime, cast(creationtime as date) as cast_datetime_to_date from orders; 
 

--dateadd(): allows us to add or subtract a specific tiem interval from a date 
--dateadd(part, interval, date)
--ex: dateadd(year, 2, orderdate), means, add 2 years to the date orderdate 

select orderid, orderdate, dateadd(year, 2, orderdate) as twoyrslater, 
dateadd(month, -3, orderdate) as threemonthsago, 
dateadd(day, 10, orderdate) as tendayslater from orders; 


--datediff: find the difference between two dates  
--datediff(part, start_date, end_date)

--datediff(month, orderdate, shipdate): find the difference in months between orderdate and shipdate
--getdate(): gives u the current date 

select * from employees; 
select getdate(); 

--find the age of each employee

select employeeid, birthdate, datediff(year, birthdate, getdate()) as age from employees; 


select month(orderdate) as ord, avg(datediff(day, orderdate, shipdate)) as time2ship from orders
group by month(orderdate); 

--accessing previous order date: 

select orderdate, lag(orderdate) over(order by orderdate asc) from orders; 
--that lag will select the first order date right before our current orderdate thats smaller than our current order

select orderdate, lag(orderdate) over(order by orderdate desc) from orders; 
--that lag will select the first order date right after our current orderdate thats smaller than our current order


--isdate(): checks if a value is a date

select isdate(123);
select isdate('123')
select isdate('2026-07-07');


--select a bunch of random orderdates and cast them to a date format only if that random data value is eligibile 
-- to be casted

select orderdate, isdate(orderdate), 
CASE 
	when isdate(orderdate) = 1 
		then cast(orderdate as date)
	else  '9999-01-01'
END as newcasted
from(
	select '2025-08-20' as orderdate union 
	select '2022' union
	select '2022-09-09' union
	select '2025-12-31' union 
	select 'ajjsj' union 
	select '2025-08' union
	select '2022-099'
) as subqu; 

--overhere we declared a case to check and cast only those strings from the subquery subqu 
--that are in a valid dateformat, the case block used CASE and END the case has a name too. 
--the name of the caseblock is newcasted and the case block shows an o/p too which is nothing but the 
--casted new date
--the case block also has an else statement that simply shows some default date, be aware that the else block 
--should also display some date, you cant display some error message since that wont be of the date format

--isnull(value, replacement): check if the value is null, if not then show the value itself, 
--if yes then show me replacement

--coalesce(): returns the first not null value from a list 

--isnull() is faster than coalesce and isnull only allows for 2 values while coalesce allows for unlimited


select customerid, score, avg(score) over() avgscores, 
avg(coalesce(score, 0)) over() avgscore2 from customers; 

--It returns each customer’s score along with the overall average score (ignoring NULLs) 
--and a second average where NULL scores are treated as 0.

select customerid, firstname, lastname, 
firstname + ' ' + coalesce(lastname, '')  as fullname, score from customers;


--sort customers from lowest to highest scores in customers with nulls appearing last 
-- in regular sorting, nulls appear first 

select customerid, score from customers order by score asc; 

select customerid, score,
case 
	when score is null then 0 else 1
end as flag 
from customers order by coalesce(score, 99999); 

select customerid, score,
case 
	when score is null then 0 else 1
end as flag 
from customers order by case when score is null then 1 else 0 end, score; 


--nullif(val1, val2): it compares two expressions and returns null if they are equal and 
--first value if they are not equal
--this avoids the divide by zero error: 
select orderid, sales, quantity, sales/nullif(quantity, 0) as price
from orders; 


select c.*, o.orderid from customers c left join orders o 
on c.customerid = o.customerid where o.customerid is null; 

--data policy: a set of rules that define how data should be handled 

--Policy1: only use null and empty strings but avoid blank spaces 

--trim(): removes leading and trailing spaces from a string 

with orders as(
select 101 Id, 'A' category union 
select 102, NULL union
select 103, '' union 
select 104, '  '
)
--the above creates a table called orders that u can use for one query 

--datalength: gives length duh 

select *, trim(category) as Policy1, datalength(category), 
datalength(trim(category)) from orders; 


--Policy2: use only nulls and no empty strings or blank spaces
select *, trim(category) as Policy1, 
nullif(trim(category), '') as Policy2 from orders; 

--Policy3: use some default value called 'unknown' and avoid using nulls
--empty strings and blank spaces

select *, trim(category) as Policy1, 
nullif(trim(category), '') as Policy2, 
coalesce(nullif(trim(category), ''), 'unknown') as Policy3 from orders; 


--case statements: the main idea of case statements is creating new columns based on existing data and 
--categorization 

select category, sum(sales) as totalsales 
from(
	select orderid, sales, 
	case 
		when sales > 50 then 'high' 
		when sales > 20 then 'medium'
		else 'low'
	end category 
	from orders
) mytempquerytable
group by category; 

--tat inner query behaves like a temporary table tat we have given tat long ahh name to 
--the case statment must return outputs of equal or same type

select employeeid, 
case 
	when gender = 'F' then 'female'
	when gender = 'M' then 'male'
	else 'not given'
end full_gender
from employees;

select customerid, firstname, lastname, country,
case 
	when country = 'germany' then 'DE' 
	when country = 'USA' then 'US'
	else 'not abbreviated'
end countryAbbr
from customers;

--another much shorter way of writing:
select customerid, firstname, lastname, country,
case country
	when 'germany' then 'DE' 
	when 'USA' then 'US'
	else 'not abbreviated'
end countryAbbr
from customers;

--over(): over can help in aggregation but allows us to apply a partition and perform aggregation for 
--for a group of rows in the table rather than the whole table, over() without any specification 
--still takes the whole table as the window

--in the below query we treat null as 0 

select customerid, lastname, score,
case 
	when score is null then 0
	else score
end scoreclean,
avg(score) over() averageCustomer
from customers; 

--task: count how mant times a customer has made an order with sales more than 30
--here we mark every order with a flag, those orders that had a sales more than 30 will get marked as 1
--and the rest as 0. after that we perform a sum(flag) and aggregate based on customer id 
--now the result shows the no of orders each customer placed tht had a slaes of more than 30 
 
select customerid, 
sum(case when sales > 30 then 1
    else 0
	end) flag 
from orders group by customerid; 


--groupby function gives results back based on the item on which the group by is performed
--over() performs the same function but retunrs the result for each row, if the avg salary of cops is 70k 
-- then the over() will show that 70k avg for avg() for every person that is a cop in the table

select orderid, orderdate, productid
from orders group by orderid, orderdate, productid; 

--in the above grouping is performed on each unique combo of the 3


select orderid, orderdate, sum(sales) over() totalsales from orders;

select orderid, productid, orderdate, sum(sales) over() totalsales, 
sum(sales) over(partition by productid) totalsalesprod, 
avg(sales) over(partition by orderdate) totalorderdate from orders; 


select productid, sum(sales) as sumprod, 
rank() over(order by sum(sales) desc) as rankedsales from orders group by productid; 

select orderid, orderdate, sales, rank() over(order by sales desc) from orders;

select orderid, orderdate, sales, rank() over(order by sales) from orders;


select orderid, orderdate, orderstatus, sales, sum(sales) 
over (partition by orderstatus order by orderdate rows between current row and 2 following) ts
from orders; 

select orderid, orderdate, orderstatus, sales, sum(sales) 
over (partition by orderstatus order by orderdate rows between unbounded preceding and current row) ts
from orders; 

select orderid, orderdate, orderstatus, sales, sum(sales) 
over (partition by orderstatus order by orderdate rows between current row and unbounded following) ts
from orders;

select orderid, orderdate, orderstatus, sales, sum(sales) 
over (partition by orderstatus order by orderdate rows between 3 preceding and current row) ts
from orders;


select orderid, orderdate, orderstatus, productid, sales, 
sum(sales) over (partition by orderstatus) as totalsales from orders where productid in (101,102);


select customerid, sum(sales) as totalsales, rank() over(order by sum(sales) desc) as
rankedcustomers from orders group by customerid; 


select count(*) totalorders from orders; 
select orderid, orderdate, count(*) over() as totalorders from orders; 
select orderid, orderdate, count(*) over() as totalorders, count(*) over(partition by customerid)
ordersbycustomers from orders; 


select *, count(*) over() as totalcusts from customers; 
select *, count(*) over() as totalcustomers, count(score) over() as totalscores from customers; 
select count(1) from customers;  
/* * and 1 work in the same way*/


select * from(
	select orderid, count(*) over(partition by orderid) as checkPK
	from OrdersArchive
) as subq where checkPK > 1; 


--here we have made a subquery to display the count of all rows with that order id and declared an external query
--to make sure and give us the queries that do have checkPK as more than 1. 

select orderid, orderdate, sum(sales) over(partition by orderid) as totalsalesorder, 
sum(sales) over(partition by productid) as totalsalesprod from orders; 


--find the percentage contribution of each product's sales to the total sales
--dividing two integers will give u an int and not a decimal, means it will be floor division
--so do cast one of the values as float

select orderid, productid, sales, sum(sales) over() totalsales, 
round((cast(sales as float)/sum(sales) over()) * 100, 2) as percentage_contri from orders;  


select orderid, orderdate, avg(sales) over(partition by productid) as avgprod, 
avg(sales) over(partition by orderid) as avgorder from orders; 

select orderid, orderdate, avg(coalesce(sales,0)) over(partition by productid) as avgprod, 
avg(coalesce(sales,0)) over(partition by orderid) as avgorder from orders; 

--coalesce will treat null as 0 up there

select orderid, orderdate, avg(coalesce(sales, 0)) over(partition by productid) as avgprod, 
avg(coalesce(sales,0)) over() as avgorder from orders;


select customerid, lastname, score, avg(score) over() as avgscore from customers; 

select * from(
	select orderid, productid, sales, avg(sales) over() as avgsales from orders
) as subq where sales > avgsales; 


select orderid, orderdate, productid, max(sales) over() as maxsales, min(sales) over() as minsales, 
max(sales) over(partition by productid) as maxsalesprod, min(sales) over(partition by productid) as
minsalesprod from orders; 


select * from(
	select *, max(salary) over() as maxemp from employees 
) as subq where salary = maxemp; 

select *, (max(salary) over() - salary) as maxdev, 
(salary - min(salary) over()) as mindev from employees; 


select *, (max(sales) over() - sales) as maxdev, 
(sales - min(sales) over()) as mindev from orders; 


--DEFAULT RANGE IS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW, we get the window when 
--we use the order by keyword 

select orderid, productid, orderdate, sales, avg(sales) over(partition by productid) as avgbyproduct, 
avg(sales) over(partition by productid order by orderdate) as movingavg, 
avg(sales) over(partition by productid order by orderdate rows between current row and 1 following)
as rollingavg	from orders; 


--RANK FUNCTIONS:
--rank(): assigns a rank to each row, handles the ties and leaves the gaps
--dense rank: assigns a rank to each row while handling the ties, but it does not leave any gap in ranking

select orderid, productid, sales, row_number() over(order by sales desc) as salesrank_row from orders;
select orderid, productid, sales, rank() over(order by sales desc) as salesrank from orders; 
select orderid, productid, sales, dense_rank() over(order by sales desc) as salesrank from orders;


select *, concat(ranks*100, '%') as perc from(
	select product, price, cume_dist() over(order by price desc) as ranks from products
) as subq where ranks <= 0.4; 

select *, concat(ranks*100, '%') as perc from(
	select product, price, percent_rank() over(order by price desc) as ranks from products
) as subq where ranks <= 0.4; 


select orderid, sales, ntile(1) over(order by sales desc) as buckets	from orders; 
select orderid, sales, ntile(2) over(order by sales desc) as buckets from orders; 

select orderid, sales, ntile(3) over(order by sales desc) as buckets from orders;
select orderid, sales, ntile(4) over(order by sales desc) as buckets from orders; 
--if number not perfectly divisible then ntile() makes the first or first few buckets large, means if no of rows divided
--by no of buckets yields a decimal like 3.33, then for 10 rows, put 4 rows in first bucket and then 3 each in the following 2 buckets 


select *, 
case when buckets = 1 then 'high' when buckets = 2 then 'medium' when buckets = 3 then 'low' 
end cases
from(
	select orderid, sales, ntile(3) over(order by sales desc) as buckets from orders
) as subq; 


--lead(attr, offset, default), the default value is if null is seen while accessing

select month(orderdate) ordermonth, sum(sales) currrentmonthsales, lag(sum(sales)) 
over(order by month(orderdate)) prevmonthsales from orders group by month(orderdate);


select *, cast((currrentmonthsales - prevmonthsales) as float)/prevmonthsales * 100 as 
MoM_perc from(
	select month(orderdate) ordermonth, sum(sales) as currrentmonthsales, lag(sum(sales)) 
	over(order by month(orderdate)) as prevmonthsales from orders group by month(orderdate)
) as subq; 


select customerid, avg(daysuntilnextorder) as avgdays, rank() over(order by avg(daysuntilnextorder)) as rankavg from(
	select orderid, customerid, orderdate currentorder, lead(orderdate) over(partition by customerid order by 
	orderdate) as nextorder, datediff(day, orderdate,lead(orderdate) over(partition by customerid order by orderdate))
	as daysuntilnextorder from orders
) as subq group by customerid; 


select month(orderdate) as monn, avg(datediff(day, orderdate, shipdate)) as avgday2ship 
from orders group by month(orderdate); 

select orderid, orderdate, datediff(day, orderdate, lead(orderdate) over(order by orderdate asc)) as diff from orders;

select orderid, orderdate, datediff(day, lag(orderdate) over(order by orderdate asc), orderdate) as diff from orders; 


select orderid, productid, sales, first_value(sales) over(partition by productid order by sales asc) as
lowest_sale, last_value(sales) over(partition by productid order by sales asc rows between current row and unbounded following) as 
highest_sales from orders;	


select * from information_schema.columns; 
select distinct table_name from information_schema.columns; 


select x+5 as result from(
	select avg(sales) as x from orders 
) as subq; 

select * from(
	select productid, price, avg(price) over() as prod_avg from products
) as subq where price > prod_avg; 

select *, rank() over(order by summ desc) as ranks  from(
	select customerid, sum(sales) as summ from orders group by customerid
) as subq; 


--WAQ to show the productIDs, product names, prices and the total number of orders; 

select productid, product, price, (select count(orderid) from orders) as total_no_of_orders from products; 


select * from customers o
left join(
	select customerid, count(*) as total_orders from orders group by customerid
) as i on o.customerid = i.customerid; 

select * from customers o
right join(
	select customerid, count(*) as total_orders from orders group by customerid
) as i on o.customerid = i.customerid; 

select productid, price from products where price > (select avg(price) from products); 

select * from orders where customerid in (select customerid from customers where country != 'germany'); 
select * from orders where customerid in (select customerid from customers where country = 'germany');
select * from orders where	customerid not in (select customerid from customers where country = 'germany');


select employeeid, firstname, gender, salary from employees where gender = 'F' and 
salary > any(select salary from employees where gender = 'M'); 

select employeeid, firstname, gender, salary from employees where gender = 'F' and 
salary > all(select salary from employees where gender = 'M'); 


select *, (select count(*) from orders o where o.customerid = c.customerid) as totalsales from customers c; 

select * from orders o where exists(select * from customers c where country = 'germany' and o.customerid  = c.customerid); 
select * from orders o where not exists(select * from customers c where country = 'germany' and o.customerid  = c.customerid); 

--Make a CTE to find the total sales per customer 

with cte as(
	select customerid, sum(sales) as totalsales from orders group by customerid
)
select s.customerid, firstname, lastname, totalsales from customers s left join cte c on s.customerid = c.customerid;

--two standalone cte's: 

with cte1 as(
	select customerid, sum(sales) as totalsales from orders group by customerid
)
,cte2 as(
	select customerid, max(orderdate) as lastorder from orders group by customerid
)
select c1.customerid,c.firstname, c.lastname, c1.totalsales, c2.lastorder from cte1 c1 left join cte2 c2 on 
c1.customerid = c2.customerid left join customers c on c.customerid = c1.customerid; 

--write a nested cte3 and cte4 that can rank the customers based on total sales per customer and segment them based on 
--their total sales respectively


with cte1 as(
	select customerid, sum(sales) as totalsales from orders group by customerid
)
,cte2 as(
	select customerid, max(orderdate) as lastorder from orders group by customerid
)
,cte3 as(
	select c.customerid, c1.totalsales, rank() over(order by c1.totalsales desc) as ranks from cte1 c1 left join customers c 
	on c1.customerid = c.customerid
)
,cte4 as( 
	select c.customerid, 
	case 
		when c1.totalsales > 100 then 'high'
		when c1.totalsales > 60 then 'medium'
		else 'low'
	end segment_comment from cte1 c1 left join customers c on c1.customerid = c.customerid
)
select c1.customerid,c.firstname, c.lastname, c1.totalsales, c2.lastorder, c3.ranks, c4.segment_comment from cte1 c1 left join cte2 c2 on 
c1.customerid = c2.customerid left join customers c on c.customerid = c1.customerid left join cte3 c3 on c1.customerid = c3.customerid
left join cte4 c4 on c1.customerid = c4.customerid;

--cte1 and 2 are standalone while cte3 and cte4 are nested ones


--write a recursive cte for generating a sequence of numbers from 1 to 20

with series as(
	select 1 as mynum
	union all
	select mynum + 1 from series where mynum < 20
)
select * from series; 

with maxrecur as(
	select 1 as mynum
	union all
	select mynum + 1 from maxrecur where mynum < 20
)
select * from maxrecur option (maxrecursion 10);


--show the employee hierarchy by displaying each employees level with the organization 
--in the table the top level will have manager id as null, consider him as the boss, then see who works under the boss or is managed by the boss and then 
--see who works under those working directly under the boss and so on 

with emphier as( 
	select employeeid, firstname,managerid, 1 as m from employees where managerid is null
	union all
	select e.employeeid, e.firstname, e.managerid, m+1 from employees e inner join emphier em on e.managerid = em.employeeid 
)
select * from emphier; 

--on first iter u store the boss in cte and in recursives step search for those who are managed by the people currently in cte, means only the boss, 
--after that u store kevin and mary for 2nd level in the cte too and now look for people managed by kevin or mary to get ur 3rd level of employees
--here recursion breaks when a recursion step adds 0 new rows to cte


with cte_month as(
	select datetrunc(month, orderdate) as ordermonth, sum(sales) as totalsales, 
	count(orderid) as totalorders, sum(quantity) as totalquantities from orders group by datetrunc(month, orderdate)
)
select ordermonth, sum(totalsales) over(order by ordermonth) as runningtotal from cte_month


create view myview as(
	select datetrunc(month, orderdate) as ordermonth, sum(sales) as totalsales, 
	count(orderid) as totalorders, sum(quantity) as totalquantities from orders group by datetrunc(month, orderdate)
)

--we can use a view in mutliple main queries
select * from myview; 
select * from myview; 
drop view myview;      


--provide a view that combines details from orders, products, customers and employees

create view details_view as(
	select o.orderid, o.orderdate, p.product, p.category, o.sales, o.quantity, coalesce(c.firstname, '') + ' ' + coalesce(c.lastname, '') as cname, 
	c.country, coalesce(e.firstname, '') + ' ' + coalesce(e.lastname, '') as ename, e.Department from orders o left join products p on p.productid = o.productid left join customers c 
	on c.customerid = o.customerid left join employees e on e.employeeid = o.salespersonid
)

select * from details_view; 

--provide a view for EU sales team that combines details from all the tables and excludes data related to the usa

create view details_view2 as(
	select o.orderid, o.orderdate, p.product, p.category, o.sales, o.quantity, coalesce(c.firstname, '') + ' ' + coalesce(c.lastname, '') as cname, 
	c.country, coalesce(e.firstname, '') + ' ' + coalesce(e.lastname, '') as ename, e.Department from orders o left join products p on p.productid = o.productid left join customers c 
	on c.customerid = o.customerid left join employees e on e.employeeid = o.salespersonid where c.country != 'usa'
)

select * from details_view2; 

--make a CTAS to show the total number of orders for each month 

select datename(month, orderdate) as ordermonth, count(orderid) as totalorders into salesmonthly
from orders group by datename(month, orderdate); 

--the above query makes a CTAS

select * from salesmonthly; 
select totalorders from salesmonthly; 
drop table salesmonthly; 

--CTAS can make a snapshot of the data, we basically store the reult of a query in a new table 

--temporary tables: they store intermediate results in temporary storage within the database during the session, 
--the database will drop all temp tables once the session ends, so same as CTAS but the lifetime varies 

--session: the time between connecting and disconnecting from the database

select * into #temporders from orders;

select * from #temporders; 

delete from #temporders where orderstatus = 'delivered'; 
select * from #temporders; 

select * into ordersctas from #temporders; 

select * from ordersctas; 

--STORED PROCEDURES 
--write a query to find the total number of customers and the avg score for US customers and turn it into a stored procedure

select count(*) totalcustomers, avg(score) avgscore from customers where country = 'usa';

create procedure p as
begin 
	select count(*) totalcustomers, avg(score) avgscore from customers where country = 'usa';
end
exec p; 

--u can define a parameter for example like '@x int' 

create procedure p2 @country nvarchar(20) as 
begin
	select count(*) totalcustomers,	avg(score) avgscore from customers where country = @country
end

alter procedure pp @country nvarchar(20) as 
begin
	select count(*) totalcustomers,	avg(score) avgscore from customers where country = @country
end

create procedure pp @country nvarchar(20) as 
begin
	select count(*) totalcustomers,	avg(score) avgscore from customers where country = @country
end

create procedure pp @coun nvarchar(20) as 
begin
	select count(*) totalcustomers,	avg(score) avgscore from customers where country = @coun
end

exec pp @coun = 'germany'; 
exec pp @coun = 'usa';


create procedure pp @coun nvarchar(20) = 'usa' as 
begin
	select count(*) totalcustomers,	avg(score) avgscore from customers where country = @coun
end

create procedure pp @cou nvarchar(20) = 'usa' as 
begin
	select count(*) totalcustomers,	avg(score) avgscore from customers where country = @cou
end

create procedure pp @cou nvarchar(20) = 'usa' as 
begin
	select count(*) totalcustomers,	avg(score) avgscore from customers where country = @cou
end

exec pp; 
exec pp @cou = 'germany';


create procedure ppp @count nvarchar(30) = 'usa' as
begin 
	select count(*) totalcustomers, avg(score) avgscore from customers where country = @count
end 

exec ppp @count = 'germany'; 

exec ppp; 

--find the total number of orders and total sales 

select count(orderid) totalorders, sum(sales) totalsales from orders o join customers c on
c.customerid = o.customerid where c.country = 'usa'; 

create procedure myproc @country nvarchar(50) = 'usa' as 
begin 
	select count(*) totalcustomers, avg(score) avgscore from customers where country = @country 
	select count(orderid) totalorders, sum(sales) totalsales from orders o join customers c on
	c.customerid = o.customerid where c.country = @country; 
end

exec myproc; 
exce myproc @country = 'germany'; 
drop procedure myproc;

create procedure myproc @country nvarchar(50) = 'usa' as 
begin 
	declare @x int, @y float;

	select @x = count(*), @y = avg(score) from customers where country = @country 
	
	print 'total customers from country ' + @country + ' are ' + ':' + cast(@x as nvarchar); 
	print 'average score from ' + @country + ' is ' + ':' + cast(@y as nvarchar); 

	select count(orderid) totalorders, sum(sales) totalsales from orders o join customers c on
	c.customerid = o.customerid where c.country = @country; 
end

exec myproc; 
exec myproc @country= 'germany'; 


create procedure myproc @country nvarchar(50) = 'usa' as 
begin 
	declare @x int, @y float;

	if exists(select 1 from customers where score is null and country = @country)
	begin 
		update customers set score = 0 where score is null and country = @country
		print('updating null scores to 0')
	end

	else 
	begin 
		print('no null scores found for')
	end

	select @x = count(*), @y = avg(score) from customers where country = @country 
	
	print 'total customers from country ' + @country + ' are ' + ':' + cast(@x as nvarchar); 
	print 'average score from ' + @country + ' is ' + ':' + cast(@y as nvarchar); 

	select count(orderid) totalorders, sum(sales) totalsales from orders o join customers c on
	c.customerid = o.customerid where c.country = @country; 
end

--THE TRY AND CATCH BLOCK 

create procedure mytries as 
begin 
	begin try 
		select 1/0 from customers where score is null
	end try

	begin catch
		print('there was an error')
	end catch
end 

exec mytries; 

create table emplogs(
	logid int identity(1,1) primary key, 
	employeeid int, 
	logmessage varchar(255), 
	logdate date
)


create trigger tigg on employees after insert as 
begin 
	insert into emplogs(employeeid, logmessage, logdate) 
	select employeeid, 
		   'new employee added: '+ cast(employeeid as varchar),
		   getdate()
	from inserted
end

--inserted is a virtual table that stores or holds a copy of the rows that are being inserted into the target table

select * from employees; 
insert into employees values(6, 'maria', 'doe', 'HR', '1998-01-12','F', 80000, 3)

select * from emplogs; 
select * from emplogs; 

select * into dbcustomrs from customers; 

select * into dbcustomers from customers; 

select * from dbcustomers; 
create clustered index ind on dbcustomers(customerid); 

drop index ind on dbcustomers; 

--you can only make one clusteredt index on a table
--you can make multiple nonclustered ondex on the same table 

create nonclustered index ind on dbcustomers(lastname); 
create nonclustered index ind2 on dbcustomers(firstname); 

select * from dbcustomers where lastname = 'brown';
select * from dbcustomers where firstname = 'anna';		

create index ind3 on dbcustomers(country, score)

create nonclustered index ind3 on dbcustomers(score, country); 
create clustered columnstore index inde on dbcustomers;

--you can only make one columnstore index for each table

drop index inde on dbcustomers; 
create nonclustered index inde on dbcustomers(firstname); 

--u can only choose which columns to cluster in the nonclustered column index 

create unique nonclustered index inp on products(product); --will give an error since category column has repeated values 


select * from products; 
insert into products (productid, product) values (106, 'caps'); 
--wont let u insert because u have applied a unique index on products

--filtered index: an index that includes only rows meeting the specified conditions
--the index is meant to arrange the rows, if nothing is mentioned then the default method is rowstore and 
--if u wanna do cilumn store then u need to mention it tooo
--u cannot create a filtered index on clustered index and columnstore index 

create nonclustered index inde4 on customers(country) where country = 'usa'; 

sp_helpindex 'dbcustomers';

create partition function paryear(date) as
range left for values('2023-12-31', '2024-12-31', '2025-12-31'); 
alter database salesdb add filegroup fg1; 
alter database salesdb remove filegroup fg1;
alter database salesdb add filegroup fg1; 

select * from sys.filegroups; 
select * from sys.filegroups where type = 'FG'; 

--a .ndf file is used my ms server as database storage file

alter database salesdb add file(
	name = myfile,  -- logical name
	filename = 'C:\Users\DeLL\Desktop\cc.ndf'  --physical name or path
) to filegroup fg1; 

select top 10 orderid, sales from orders; 
