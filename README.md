## Project Overview

**Project Title**: Stocks Analysis  
**Level**: Intermediate  
**Database**: `mysql_project`
![Stocks_Analysis_project](https://github.com/HardikThakur04/Stocks_Analysis_using_MySql/blob/ff4b9f8565f594df86dcefe1a5cd9c8a6f11abc2/stocks%20image.jpg)

This project demonstrates SQL skills and techniques for exploring, analyzing, and gaining insights from historical stock market data. Using MySQL, this analysis includes setting up a stocks database, performing exploratory data analysis (EDA), and answering key business questions through SQL queries. This project is ideal for data enthusiasts aiming to build strong SQL skills through practical financial data analysis.

## Objectives

1. **Database Setup**: Created and populated a stock market database using historical S&P 500 data.
2. **Data Cleaning**: Identified and removed records with missing or null values to ensure data accuracy.
3. **Exploratory Data Analysis (EDA)**: Conducted initial data exploration to uncover trading patterns and stock performance insights.
4. **Business Insights**: Leveraged SQL queries to answer business-specific questions and generate actionable insights about trading volume, stock volatility, and historical returns.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `stocks_db`.
- **Table Creation**: A table named `stocks` is created to store daily trading data for S&P 500 companies. The table structure includes columns for ticker, trade date, volume, high, low, open, and close prices.

```sql
CREATE DATABASE stocks_db;

CREATE TABLE stocks (
    symbol VARCHAR(10),
    date DATE,
    volume BIGINT,
    high FLOAT,
    low FLOAT,
    open FLOAT,
    close FLOAT,
    PRIMARY KEY symbol
);
```

### Recommended MySQL Analysis Questions

1. **Largest Overall Trading Volume Date and Top-Traded Stocks**
   - *Question*: "Which date saw the largest total trading volume across all S&P 500 companies, and which two stocks had the highest individual volumes on that day?"

   ```sql
   -- Find the date with the highest total trading volume
   SELECT date, sum(volume) as Total_Volume
   FROM stocks
   GROUP BY date
   ORDER BY SUM(volume) desc LIMIT 1;

   -- Find the two stocks with the highest volumes on that date
   SELECT symbol,volume
   FROM stocks
   WHERE date = '2015-08-24'
   ORDER BY volume desc limit 2;

   ```

2. **Volume by Day of the Week**
   - *Question*: "On which day of the week does trading volume tend to be the highest? Which day sees the lowest trading volume?"

   ```sql
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
   ```

3. **Amazon's Most Volatile Trading Day**
   - *Question*: "On which date did Amazon (AMZN) experience the highest volatility, as measured by the difference between its high and low prices?"

   ```sql
   SELECT date, (high-low) as Volatility
   FROM stocks
   WHERE symbol='AMZN'
   ORDER BY Volatility DESC LIMIT 1;
   ```

4. **Best Investment Opportunity**
   - *Question*: "Which stock showed the highest percentage gain from the opening price on 1/2/2014 to the closing price on 12/29/2017, and what would that percentage gain be?"

   ```sql
   -- First, get the opening price on 1/2/2014 and closing price on 12/29/2017 for each stock
   WITH price_changes AS (
       SELECT ticker,
              MAX(CASE WHEN trade_date = '2014-01-02' THEN open END) AS open_price,
              MAX(CASE WHEN trade_date = '2017-12-29' THEN close END) AS close_price
       FROM stocks
       GROUP BY ticker
   )
   SELECT ticker, ((close_price - open_price) / open_price) * 100 AS percentage_gain
   FROM price_changes
   ORDER BY percentage_gain DESC
   LIMIT 1;
   ```

5. **Top 5 Most Volatile Stocks (Overall)**
   - *Question*: "Which five stocks experienced the highest average daily volatility from 2014 to 2017?"

   ```sql
   SELECT symbol, avg(high-low) as volatility 
   FROM stocks
   GROUP BY symbol 
   ORDER BY volatility DESC 
   LIMIT 5;
   ```

6. **Most Consistently Traded Stocks**
   - *Question*: "Which stocks had the smallest variance in daily trading volume, indicating consistent trading activity?"

   ```sql
   SELECT symbol, variance(volume) as variance
   FROM stocks 
   GROUP BY symbol 
   ORDER BY variance asc
   LIMIT 1;
   ```

7. **Monthly Trading Volume Patterns**
   - *Question*: "How does trading volume vary across different months? Which month tends to have the highest and lowest average trading volume?"

   ```sql
   SELECT MONTHNAME(trade_date) AS month, AVG(volume) AS avg_volume
   FROM stocks
   GROUP BY month
   ORDER BY avg_volume DESC;
   ```

8. **Biggest Single-Day Price Increase**
   - *Question*: "Which stock experienced the largest single-day price increase, measured by the percentage change from open to close?"

   ```sql
   SELECT symbol, date, ((close - open) / open) * 100 AS daily_percentage_gain
   FROM stocks
   ORDER BY daily_percentage_gain DESC
   LIMIT 1;
   ```

9. **Weekly Stock Performance Patterns**
   - *Question*: "Are there any patterns in daily closing prices based on the day of the week? For example, does any specific day of the week tend to have higher or lower closing prices on average?"

   ```sql
   SELECT DAYNAME(trade_date) AS day_of_week, AVG(close) AS avg_close_price
   FROM stocks
   GROUP BY day_of_week
   ORDER BY avg_close_price DESC;
   ```

10. **Stock with the Highest Average Close Price Over Time**
    - *Question*: "Which stock had the highest average closing price over the entire period (2014-2017)?"

    ```sql
    SELECT symbol, avg(close) as Avg_close_Price
    FROM stocks 
    GROUP BY symbol
    ORDER BY Avg_close_Price DESC
    LIMIT 1;
    ```

11. **Average Opening and Closing Prices by Year**
    - *Question*: "How did the average opening and closing prices change for each year from 2014 to 2017?"

    ```sql
    SELECT year(date) as year, avg(open) as Open, avg(close) as Close
    FROM stocks
    GROUP BY year
    ORDER BY year;
    ```

12. **Stocks with Most Days of Positive Gains**
    - *Question*: "Which stocks had the highest number of days where the close price was higher than the open price, indicating consistent positive performance?"

    ```sql
    SELECT symbol, count(*) as "No of Days"
    FROM stocks
    WHERE close>open 
    GROUP BY symbol
    ORDER BY "No of Days" DESC
    LIMIT 1;
    ```

13. **Correlation Between Volume and Volatility**
    - *Question*: "Is there a correlation between daily trading volume and volatility? Do stocks with higher volumes experience higher volatility?"
      
    ```sql
    SELECT Symbol, avg(volume) as Avg_volume,avg(high-low) as volatility
    FROM stocks
    GROUP BY symbol
    ORDER BY volatility DESC;
    ```

14. **Top 5 Stocks with the Highest Closing Prices on the Last Day**
    - *Question*: "On the last trading day in the dataset, which five stocks closed at the highest prices?"

    ```sql
    SELECT MAX(DATE) FROM stocks;

    SELECT symbol,close
    FROM stocks
    WHERE date="2016-07-14"
    ORDER BY close desc
    LIMIT 5;
    ```
    
## Findings

- **Highest Trading Volume Date**: Identified the day with the largest trading volume and the top two traded stocks.
- **Weekly Volume Patterns**: Determined which day of the week generally has the highest and lowest trading volume.
- **Amazon's Volatility**: Found the date of highest volatility for Amazon (AMZN), indicating significant price fluctuation.
- **Top Investment Opportunity**: Analyzed the stock with the highest percentage gain from 2014 to 2017, useful for retrospective investment insights.
- **Stock Volatility**: Identified the most volatile stocks over the given period, providing insights into risk levels.

## Reports

- **Trading Volume Summary**: Reports on highest-volume days, day-of-week patterns, and month-wise trends.
- **Stock Performance**: Analysis of stocks with the highest historical returns and volatility.
- **Investment Insights**: A summary of stocks with potential for gains based on historical performance.

## Conclusion

This project serves as a comprehensive exploration of stock market data using SQL, covering database setup, data cleaning, exploratory analysis, and advanced business queries. The insights generated from this project can support investment strategies and provide valuable trading insights based on historical data.

Analyzed by: Hardik Thakur  
Date: 11, November 2024
