/*8. In which quarter of 2020, got the maximum total_sold_quantity? The final
output contains these fields sorted by the total_sold_quantity,
Quarter
total_sold_quantity*/

-- Solution:-
-- method!:-
select 
	concat('Q',ceil(month(date_add(date, interval 4 month))/3)) as Quarter,
    sum(sold_quantity) as total_sold_quantity
from fact_sales_monthly
where fiscal_year=2020
group by Quarter
order by total_sold_quantity desc
limit 1;

-- method1:-
select 
	concat('Q',ceil(month(date_add(date, interval 4 month))/3)) as Quarter,
    sum(sold_quantity) as total_sold_quantity
from fact_sales_monthly
where fiscal_year=2020
group by Quarter
order by total_sold_quantity desc;

-- method2:-
SELECT 
CASE
 WHEN month(date) in (9,10,11) THEN 'Q1'
 WHEN month(date) in (12,1,2) THEN 'Q2'
 WHEN month(date) in (3,4,5) THEN 'Q3'
 WHEN month(date) in (6,7,8) THEN 'Q4'
 END AS Quarter_month,
 SUM(sold_quantity) AS total_sold_quantity
FROM fact_Sales_monthly AS quater_table
 WHERE fiscal_year=2020
 GROUP BY Quarter_month
 ORDER BY  total_sold_quantity DESC;