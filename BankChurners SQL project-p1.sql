create database bank_churner;
alter table `customer-churn-records`
rename to bankcustomer ;
select * from bankcustomer;

-- Find churn rate by age group
select 
case when age between 18 and 25 then '18-25'
	when age between 26 and 35 then '26-35'
    when age between 36 and 45 then '36-45'
    when age between 46 and 55 then '46-55'
    else '56+'
    end as Age_group, count(*) as total_cust, sum(Exited) as Churners,
    round((sum(Exited)*100)/count(*),2) as churn_rate
    from bankcustomer
    group by Age_group;
    
-- Find Churn rate by country

select Geography, count(*) as tota_cust, sum(Exited) as Churners, Round((sum(Exited)*100)/count(*),2) as Churn_rate 
from bankcustomer
group by Geography
order by Geography desc;

-- Do customers with more products churn less

select NumOfProducts, count(*) as tota_cust, sum(Exited) as Churners, Round((sum(Exited)*100)/count(*),2) as Churn_rate 
from bankcustomer
group by NumOfProducts
order by NumOfProducts desc;

-- Find common factors among churned customers

select Geography, Gender, Age, Numofproducts, Tenure, HasCrCard, count(*) as  Churned_count
from bankcustomer
where Exited=1
group by Geography, Gender, Age, Numofproducts, Tenure, HasCrCard
order by Churned_count desc
limit 10;

-- Identify customers with high salary and balance who churned

select CustomerId, Age, Geography, Balance, EstimatedSalary
from bankcustomer
where Exited =1 
order by Balance desc, EstimatedSalary desc
limit 10;

-- Find persuadable churned customers

alter table bankcustomer
rename column `Satisfaction score` to  Satisfaction_score;

alter table bankcustomer
rename column `Card Type` to  Card_Type;

select CustomerId, Satisfaction_score, Balance, NumOfProducts
from bankcustomer
where Exited = 1 and Satisfaction_score between 3 and 5
order by Satisfaction_score desc, Balance desc;

-- do diamond cardholders churn less

select Card_Type, count(*) as total_cust, sum(Exited) as Churn_cust, round((sum(Exited)*100)/count(*), 2) as Churn_rate
from bankcustomer
group by Card_Type
order by churn_rate;

-- which tenure range has the highest churn

select 
case when Tenure between 0 and 2 then '0-2'
	when Tenure between 3 and 5 then '3-5'
    when Tenure between 6 and 8 then '6-8'
    else '9+'
    end as Age_group, count(*) as total_cust, sum(Exited) as Churners,
    round((sum(Exited)*100)/count(*),2) as churn_rate
    from bankcustomer
    group by Tenure;

-- do complaints increase churn

select complain, count(*) as tot, sum(exited) as cust, round((sum(exited)*100)/count(*),2) as rate
from bankcustomer
group by complain;

-- total balance lost due to churn

select sum(balance) as totallostcust
from bankcustomer
where Exited=1;

-- do high-salary customers hold more products

select round(estimatedsalary, -4) as rang, avg(numofproducts) as avgnum
from bankcustomer
group by rang
order by rang;

-- find customers with churn like characterstics

select CustomerId, age , Geography, NumOfProducts, balance, estimatedsalary from bankcustomer
where NumOfProducts=1 and IsActiveMember=0 and creditscore<600;

-- find the balance point where churn increases

select case
when balance between 0 and 50000 then 'Low balance '
when balance between 50001 and 100000 then 'Mid balance '
else 'High balance'
end as balance_range,
count(*) as tot, sum(Exited)as churnd, round((sum(exited)*100)/count(*),2)as rate 
from bankcustomer
group by balance_range;

-- estimate potential revenue based on product usage

select NumOfProducts, count(*) as cust, round(avg(balance),2) as averg, sum(Balance) as tot
from bankcustomer
group by NumOfProducts
order by NumOfProducts;

-- find the distribution of cardtypes

select Card_Type, count(*) as cust, round(avg(balance),2) as averg, sum(Balance) as tot
from bankcustomer
group by Card_Type
order by cust desc;

-- does having a credit card affect churn

select HasCrCard, count(*) as cust, round(avg(balance),2) as rate
from bankcustomer
group by HasCrCard;

-- which tenure rate has the lowest retention rate


select Tenure, count(*) as cust, sum(exited) AS so , round((sum(exited)*100)/count(*),2) as rate
from bankcustomer
group by tenure
order by rate desc;

-- which products are most commonly held by customers

select NumOfProducts, count(*) as tot
from bankcustomer
group by NumOfProducts
order by tot desc;

-- how many people hold multiple accounts

select count(*) multi
from bankcustomer
where NumOfProducts>1;

-- how much total balance is at risk due to churn

select sum(Balance) as tot
from bankcustomer
where Exited=1;

-- average balance of churned customers vs retained customers

select Exited, round(avg(balance), 2) as aveg
from bankcustomer
group by Exited;

-- average number of products per customer

select round(avg(NumOfProducts), 2) as ppc
from bankcustomer;

-- customers with low tenure have exited

select count(*) as low
from bankcustomer
where tenure<2 and Exited =1;

-- region with high-value customer

select Geography, count(*) as high
from bankcustomer
where balance >100000
group by Geography
order by high desc;

