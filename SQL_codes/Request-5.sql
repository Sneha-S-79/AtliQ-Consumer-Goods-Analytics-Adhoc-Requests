/*5. Get the products that have the highest and lowest manufacturing costs.
The final output should contain these fields,
product_code
product
manufacturing_cost*/

-- Solution:-
-- method 1
with maxx as(
	select max(manufacturing_cost) as mc 
    from fact_manufacturing_cost
),
minn as(
	select min(manufacturing_cost) as mc 
    from fact_manufacturing_cost
)
select
	p.product_code,p.product,fm.manufacturing_cost 
from dim_product p
join fact_manufacturing_cost fm using(product_code),maxx,minn
where 
	fm.manufacturing_cost in (maxx.mc,minn.mc)
order by manufacturing_cost;

-- method 2
select p.product_code,product, fm.manufacturing_cost 
from dim_product p
join fact_manufacturing_cost fm using(product_code)
where fm.manufacturing_cost=(select max(manufacturing_cost) from fact_manufacturing_cost)
   or fm.manufacturing_cost=(select min(manufacturing_cost) from fact_manufacturing_cost)
order by manufacturing_cost;

-- method 3
 select p.product_code as product_code,p.product as product, fm.manufacturing_cost
 from dim_product p
 join fact_manufacturing_cost fm using(product_code)
 where fm.manufacturing_cost=(select max(manufacturing_cost) from fact_manufacturing_cost)
 union
 select p.product_code as product_code,p.product as product,fm.manufacturing_cost 
 from dim_product p
 join fact_manufacturing_cost fm using(product_code)
 where fm.manufacturing_cost=(select min(manufacturing_cost) from fact_manufacturing_cost)
 order by manufacturing_cost;
 
 -- method 4 
 select p.product_code,product, fm.manufacturing_cost 
from dim_product p
join fact_manufacturing_cost fm using(product_code)
where fm.manufacturing_cost in (
	select min(manufacturing_cost) from fact_manufacturing_cost
    union
    select max(manufacturing_cost)from fact_manufacturing_cost
)
order by manufacturing_cost;