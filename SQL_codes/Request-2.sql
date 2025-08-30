/*2. What is the percentage of unique product increase in 2021 vs. 2020? The final output contains these fields,
unique_products_2020
unique_products_2021
percentage_chg*/

-- Solution:-
-- method1
with cte as(
	select count(distinct product_code) as unique_products_2020,
    (select count(distinct product_code) 
	from fact_sales_monthly 
    where fiscal_year=2021) unique_products_2021
    from fact_sales_monthly 
    where fiscal_year=2020
)
select *,
	round((unique_products_2021-unique_products_2020)*100/unique_products_2020,2) as percentage_change
from cte;

-- method2
select x.a as unique_products_2020,
	y.b as unique_products_2021,
	round(((y.b-x.a)*100)/x.a,2) as percentage_change
from (
	(select count(distinct product_code) as a from fact_sales_monthly where fiscal_year=2020) x,
    (select count(distinct product_code) as b from fact_sales_monthly where fiscal_year=2021) y
);