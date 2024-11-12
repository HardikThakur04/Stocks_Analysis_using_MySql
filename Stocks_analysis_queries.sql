use mysql_project;

CREATE TABLE STOCKS(
symbol varchar(30),
date date,
open double,
high double,
low double,
close double,
volume double
);

desc stocks;

select * from stocks;

select monthname(date) from stocks;

#Which date saw the largest total trading volume across all S&P 500 companies, Which two stocks had the highest individual volumes on that day?

SELECT date, sum(volume) as Total_Volume
FROM stocks
GROUP BY date
ORDER BY SUM(volume) desc LIMIT 1;

SELECT symbol,volume
FROM stocks
WHERE date = '2015-08-24'
ORDER BY volume desc limit 2;

#On which day of the week does trading volume tend to be the highest? Which day sees the lowest trading volume?

SELECT dayname(date) as Day_Name, 
avg(volume) as Avg_Volume
FROM stocks
GROUP BY dayname(date)
ORDER BY avg(volume) desc limit 1;

SELECT dayname(date) as Day_Name, 
avg(volume) as Avg_Volume
FROM stocks
GROUP BY dayname(date)
ORDER BY avg(volume) asc limit 1;

#On which date did Amazon (AMZN) experience the highest volatility, as measured by the difference between its high and low prices?

SELECT date, (high-low) as Volatility
FROM stocks
WHERE symbol='AMZN'
ORDER BY Volatility DESC LIMIT 1;

#Which stock showed the highest percentage gain from the opening price on 1/2/2014 to the closing price on 12/29/2017, 
#and what would that percentage gain be?

WITH price_changes AS (
    SELECT symbol,
           MAX(CASE WHEN date = '2014-01-02' THEN open END) AS open,
           MAX(CASE WHEN date = '2017-12-29' THEN close END) AS close
    FROM stocks
    GROUP BY symbol
)

SELECT symbol, ((open-close)/open)*100 as Perc_gain
FROM price_changes
ORDER BY Perc_gain desc limit 1;

#Which five stocks experienced the highest average daily volatility from 2014 to 2017?

SELECT symbol, avg(high-low) as volatility 
FROM stocks
GROUP BY symbol 
ORDER BY volatility DESC 
LIMIT 5;

#Which stocks had the smallest variance in daily trading volume, indicating consistent trading activity?

SELECT symbol, variance(volume) as variance
FROM stocks 
GROUP BY symbol 
ORDER BY variance asc
LIMIT 1;

#How does trading volume vary across different months? Which month tends to have the highest and lowest average trading volume?

--highest
SELECT monthname(date) as months, sum(volume)
FROM stocks
GROUP BY months
ORDER BY sum(volume) desc
LIMIT 10;

---lowest
SELECT monthname(date) as month, avg(volume) as avg_volume
FROM stocks
GROUP BY month
ORDER BY avg(volume) desc
LIMIT 1;

SELECT monthname(date) as month, avg(volume) as avg_volume
FROM stocks
GROUP BY month
ORDER BY avg(volume) asc
LIMIT 1;

#Which stock experienced the largest single-day price increase, measured by the percentage change from open to close?

SELECT symbol, date, ((close - open) / open) * 100 AS daily_percentage_gain
FROM stocks
ORDER BY daily_percentage_gain DESC
LIMIT 1;


#Are there any patterns in daily closing prices based on 
#the day of the week? For example, does any specific day of 
#the week tend to have higher or lower closing prices on average?

SELECT dayname(date) as DayName,avg(close) 
FROM stocks
GROUP BY date
ORDER BY avg(close) DESC 
LIMIT 1;

SELECT dayname(date) as DayName,avg(close) 
FROM stocks
GROUP BY date
ORDER BY avg(close) ASC
LIMIT 1;

#Which stock had the highest average closing price over the entire period (2014-2017)?

SELECT symbol, avg(close) as Avg_close_Price
FROM stocks 
GROUP BY symbol
ORDER BY Avg_close_Price DESC
LIMIT 1;

#How did the average opening and closing prices change for each year from 2014 to 2017?

SELECT year(date) as year, avg(open) as Open, avg(close) as Close
FROM stocks
GROUP BY year
ORDER BY year;

#Which stocks had the highest number of days where the 
#close price was higher than the open price, indicating consistent positive performance?

SELECT symbol, count(*) as "No of Days"
FROM stocks
WHERE close>open 
GROUP BY symbol
ORDER BY "No of Days" DESC
LIMIT 1;

#Is there a correlation between daily trading volume and volatility? 
#Do stocks with higher volumes experience higher volatility.

SELECT Symbol, avg(volume) as Avg_volume,avg(high-low) as volatility
FROM stocks
GROUP BY symbol
ORDER BY volatility DESC;

#On the last trading day in the dataset, which five stocks closed at the highest prices?


SELECT MAX(DATE) FROM stocks;

SELECT symbol,close
FROM stocks
WHERE date="2016-07-14"
ORDER BY close desc
LIMIT 5;





















