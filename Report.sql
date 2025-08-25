select distinct country , `Status`,  sum(amount) as pending_amount 
 from customer_Data cd join order_data od on cd.customer_id = od.customer_id
 join shipping_data sd on sd.Customer_ID
where `status` <> 'Delivered'
group by 1,2;

select distinct cd.customer_id , count(order_id) as number_of_orders , count(item)  as no_of_items , sum(amount) as amount_spent,
group_concat(item separator ',') as items
 from customer_Data cd join order_data od on cd.customer_id = od.customer_id group by 1 order by 4 desc;


with rank_sales as (
select distinct country as country , item , count(item) as qunatity , rank()  over(partition by  country
 order by count(item) desc ) as ran
from customer_data cd join order_data od on cd.Customer_ID = od.Customer_ID group by 1,2)
select country ,item, qunatity from rank_sales where ran = 1 order by 2 desc;

with age_cat as (
select case when age < 30 then 'age<30' else 'age>30' end as age_cat ,  item , count(item) as qunatity 
, rank()  over(partition by  case when age < 30 then 'age<30' else 'age>30' end  order by count(item) desc ) as ran
from customer_data cd join order_data od on cd.Customer_ID = od.Customer_ID group by 1,2)
select age_cat  ,item, qunatity from age_cat where ran = 1 order by 2 desc;


select country , count(order_id) as orders from customer_data cd join order_data od on cd.Customer_ID = od.Customer_ID
group by 1 order by 2 asc limit 1 ; 

select country , sum(amount) as sales from customer_data cd join order_data od on cd.Customer_ID = od.Customer_ID
group by 1 order by 2 asc limit 1 ; 

select country , count(order_id) as orders , sum(amount) as sales 
from customer_data cd join order_data od on cd.Customer_ID = od.Customer_ID
group by 1 order by 2 asc , 3 asc limit 1;

