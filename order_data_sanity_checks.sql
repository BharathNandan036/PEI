select count(*) as order_rows , 
-- checking uniqness by comparing count and distinct count
count(distinct (order_ID)) as distinct_orders , 
-- checking for null values in every column 
sum( case when order_ID is null then 1 else 0 end ) as null_order_ID,
sum( case when item is null then 1 else 0 end ) as null_item,
sum(case when amount is null then 1 else 0 end ) as null_amount, 
sum(case when customer_id is null then 1 else 0 end ) as null_customer_id,
-- checking for incorrect data  in each column 
sum(case when order_ID not regexp '^[0-9]+$' then 1 else 0 end) as invalid_order_id,
sum(case when amount <= 0 then 1 else 0 end) as invalid_amount,
sum(case when item regexp '[^a-zA-Z ]' then 1 else 0 end) as invalid_item_name
 from order_data;
 
 -- checking the distinct to see any junk values
 select distinct item from order_Data;
 
 select distinct amount from order_data;
 
 -- context checking : all the orders have to be placed by my customers only; meaning customer id should be in customer table
 
 select * from order_Data where customer_id not in ( select distinct customer_id from customer_Data);
 