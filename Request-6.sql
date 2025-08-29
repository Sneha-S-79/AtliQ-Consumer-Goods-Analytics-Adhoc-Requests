/*6. Generate a report which contains the top 5 customers who received an
average high pre_invoice_discount_pct for the fiscal year 2021 and in the
Indian market. The final output contains these fields,
customer_code
customer
average_discount_percentage*/

-- Solution:-
select 
	c.customer_code, 
    c.customer,
    round(avg(pre_invoice_discount_pct),4) as avg_discount_pct
from fact_pre_invoice_deductions pid
join dim_customer c using(customer_code)
where fiscal_year=2021 and market='India'
group by c.customer_code,customer
order by avg_discount_pct desc
limit 5;