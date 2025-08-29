/*9. Which channel helped to bring more gross sales in the fiscal year 2021
and the percentage of contribution? The final output contains these fields,
channel
gross_sales_mln
percentage*/

-- Solution:-
-- method1
with cte as (
select
	c.channel,
	round(sum(fp.gross_price*fs.sold_quantity)/1000000,2) as gs_mln,
	round(
		(
         (sum(fp.gross_price*fs.sold_quantity)) /
         (select sum(fp2.gross_price*fs2.sold_quantity)
         from fact_sales_monthly fs2
         join fact_gross_price fp2 
			on fs2.product_code=fp2.product_code and
				fs2.fiscal_year=fp2.fiscal_year
		where fs2.fiscal_year=2021)
	     )*100, 
	 2) as pct
from fact_sales_monthly fs 
join fact_gross_price fp 
	on	fs.product_code=fp.product_code and 
		fs.fiscal_year=fp.fiscal_year
join dim_customer c 
	on fs.customer_code=c.customer_code
where fs.fiscal_year=2021
group by c.channel)
select 
	channel, 
	concat(gs_mln,'M') as gross_sales_mln, 
    concat(pct,'%') as percentage_contribution
from cte
order by pct desc;

-- method2
with cte as (select
	channel,
	sum(gross_price*sold_quantity) as gs
	from fact_sales_monthly fs 
	join fact_gross_price fp 
	on	fs.product_code=fp.product_code and 
		fs.fiscal_year=fp.fiscal_year
	join dim_customer c 
	on fs.customer_code=c.customer_code
	where fs.fiscal_year=2021
	group by c.channel)
select 
	channel,
    concat(round(gs/1000000,2),'M') as gross_sales_mln,
    concat(round(gs*100/sum(gs) over(),2),'%') as percentage_contribution
from cte
order by percentage_contribution desc;