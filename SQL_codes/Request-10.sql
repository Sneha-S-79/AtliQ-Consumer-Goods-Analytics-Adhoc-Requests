/*10. Get the Top 3 products in each division that have a high
total_sold_quantity in the fiscal_year 2021? The final output contains these
fields,
division
product_code
product
total_sold_quantity
rank_order*/ 

-- Solution:-
with cte as(
	select 
		p.division,p.product_code,p.product,sum(fs.sold_quantity) as tq,
        dense_rank() over(partition by division order by sum(fs.sold_quantity) desc) as rnk
	from fact_sales_monthly fs
    join dim_product p using(product_code)
    where fiscal_year=2021
    group by p.division,p.product_code,p.product
)
select division,product_code,product,tq as total_sold_quantity, rnk as rank_order
from cte
where rnk<=3;
