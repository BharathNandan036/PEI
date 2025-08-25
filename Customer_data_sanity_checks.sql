CREATE DATABASE pei_assessment;
USE pei_assessment;

-- imported the data to the database using the table import wizard

-- data sanity checks for customer_data 

select count(*) as customer_rows , 
-- checking uniqness by comparing count and distinct count
count(distinct (Customer_ID)) as distinct_customer , 
-- checking for null values in every column 
sum( case when Customer_ID is null then 1 else 0 end ) as null_customer_ids,
sum( case when `first` is null then 1 else 0 end ) as null_first_name,
sum(case when `last` is null then 1 else 0 end ) as null_last_name, 
sum(case when age is null then 1 else 0 end ) as null_age,
sum( case when country is null then 1 else 0 end ) as null_country,
-- checking for incorrect data  in each column 
sum(case when age < 0 or age > 120 then 1 else 0 end) as invalid_age,
sum(case when `first` regexp '[^a-za-z]' then 1 else 0 end) as invalid_firstname,
sum(case when `last` regexp '[^a-za-z]' then 1 else 0 end) as invalid_lastname,
sum(case when customer_id not regexp '^[0-9]+$' then 1 else 0 end) as invalid_customer_id
 from customer_data;
 
 -- checking the error values 
 
 select * from customer_data where `first` regexp '[^a-za-z]'  or `last` regexp '[^a-za-z]' ;
 
 -- we can clearly see that only errors are : number or special character in first or last name 
 
 -- understanding which customer ID needs to modified and what is the error 
 
 select customer_id , case when `first` regexp '[0-9]' then 'first name has a number'
 when `first` regexp '[^a-za-z0-9]' then 'first name has a special character'
 when `last` regexp '[0-9]' then 'last name has a number'
 when `last` regexp '[^a-za-z0-9]' then 'last name has a special character' end as correction_needed,
 case when `first` regexp '[0-9]' then `first` when `first` regexp '[^a-za-z0-9]' then `first`
when `last` regexp '[0-9]' then `last` when `last` regexp '[^a-za-z0-9]' then `last` end as incorrect_value
 from customer_Data where `first` regexp '[^a-za-z]'  or `last` regexp '[^a-za-z]' ;
 
 