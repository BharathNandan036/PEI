select count(*) as shipping_rows , 
-- checking uniqness by comparing count and distinct count
count(distinct (shipping_ID)) as distinct_shipping , 
-- checking for null values in every column 
sum( case when shipping_ID is null then 1 else 0 end ) as null_order_ID,
sum( case when `status` is null then 1 else 0 end ) as null_status,
sum(case when customer_id is null then 1 else 0 end ) as null_customer_id,
-- checking for incorrect data  in each column 
sum(case when shipping_ID not regexp '^[0-9]+$' then 1 else 0 end) as invalid_shipping_ID,
sum(case when customer_id not regexp '^[0-9]+$' then 1 else 0 end) as invalid_customer_id,
sum(case when `status` regexp '[^a-zA-Z ]' then 1 else 0 end) as invalid_status
 from shipping_data;
 
 
 -- checking the distinct to see any junk values
 select distinct `status` from shipping_Data;
 
 -- similarly checking the context : all customers in shopping table shoulkd be available in customer table
 
 select * from shipping_data where customer_id not in ( select distinct customer_id from customer_Data);