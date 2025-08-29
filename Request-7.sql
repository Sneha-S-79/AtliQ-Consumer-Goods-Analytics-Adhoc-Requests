/*7. Get the complete report of the Gross sales amount for the customer “Atliq
Exclusive” for each month. This analysis helps to get an idea of low and
high-performing months and take strategic decisions.
The final report contains these columns:
Month
Year
Gross sales Amount*/

-- Solution:- 
-- method1
select 
	date_format(fm.date, '%M (%Y)')as Month, fiscal_year,
	round(sum(sold_quantity*gross_price) ,2)as gross_sales_amount
from fact_sales_monthly fm
join fact_gross_price fp using(fiscal_year, product_code)
where customer_code in (select customer_code from dim_customer where customer='Atliq Exclusive')
group by Month,fiscal_year
order by fiscal_year;

-- method 2(cleaner)
select 
	date_format(fm.date, '%M (%Y)')as Month, 
    fm.fiscal_year as Year,
	round(sum(fm.sold_quantity*fp.gross_price) ,2)as gross_sales_amount
from fact_sales_monthly fm
join fact_gross_price fp 
	on fm.fiscal_year=fp.fiscal_year and 
	   fm.product_code=fp.product_code
join dim_customer c 
	on c.customer_code=fm.customer_code
where c.customer='Atliq Exclusive'
group by Month,fm.fiscal_year
order by fm.fiscal_year;