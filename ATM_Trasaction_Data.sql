create database atm_db;
use atm_db;

select * from cleaned_transactions limit 10;


# Total withdrawals per ATM per month
select `ATM Name`, date_format(`Transaction Date`, '%Y-%M') as Yearmonth,
CONCAT('€', FORMAT(SUM(`Total amount Withdrawn`), 0))
 as  Total_withdrawn
from cleaned_transactions
group by `ATM Name`, date_format(`Transaction Date`, '%Y-%M')
order by `ATM Name`;

#  Top 5 ATMs by total amount withdrawn

SELECT `ATM Name`, sum(`Total amount Withdrawn`) as Total_amount
from cleaned_transactions
group by `ATM Name`
order by Total_amount DESC limit 5;

# Average withdrawal amount per transaction
select 
concat('€',format(AVG(`Total amount Withdrawn`/ nullif(`no of withdrawals`,0)),0)) as AVG_withdrwal_amount
from cleaned_transactions;

# Daily withdrawals trend for XYZ Card


SELECT  
    DATE(`Transaction Date`) AS DAY,
    SUM(`no of xyz card withdrawals`) AS total_withdrawals
FROM cleaned_transactions
GROUP BY DAY
ORDER BY DAY;

SHOW COLUMNS FROM cleaned_transactions;


# Compare total withdrawals on working days vs weekends
Select
	case
		when `weekday`(`Transaction Date`) < 5 Then 'Weekday'
        else 'weekend'
     End as Day_type,
     concat('€',format(sum(`Total amount Withdrawn`),2)) as total_withdrawls
     from cleaned_transactions
     group by Day_type;