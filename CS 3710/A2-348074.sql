-- CHANGES
-- The following changes are grouped by question. If no change 
-- was needed to conform to the question it is listed with NO CHANGE.
--
-- 1. NO CHANGE

-- 2. NO CHANGE

-- 3. DayOfWeek changed to INT type which is what csv uses and is a better 
    -- data type since there is seven days of the week

-- 4. FORMAT changed to ROUND to retain numerical type DOUBLE and not VARCHAR
    -- allows for numerical comparison instead of string comparison

-- 5. FORMAT changed to ROUND to retain numerical type DOUBLE and not VARCHAR (see above reasoning)
    -- IFNULL used to set a default of 0 for no change on initial trade date

-- 6. FORMAT changed to ROUND to retain numerical type DOUBLE and not VARCHAR
    -- therefore max and min will work now comparing doubles not strings (also see above reasoning)

-- 7. NO CHANGE

-- 8. FORMAT changed to ROUND to retain numerical type DOUBLE and not VARCHAR (see above reasoning)

-- 9. FORMAT changed to ROUND to retain numerical type DOUBLE and not VARCHAR (see above reasoning)

-- 10. FORMAT changed to ROUND to retain numerical type DOUBLE and not VARCHAR (see above reasoning)
    -- Remove concat of Year and Month, better to keep Year and Month columns instead for readability
    -- and organization of data overall


-- Drop existing database if it exists
DROP DATABASE IF EXISTS DB3710;

-- Create DB3710 database
CREATE DATABASE DB3710;

-- Use DB3710 database
USE DB3710;

-- Create GBP table and load data from NASDAQ-GBP.csv
CREATE TABLE GBP (
    ID INT PRIMARY KEY,
    TradeDate DATE,

    -- Day of the week should be stored as a int like csv
    DayOfWeek INT,
    
    Day INT,
    Month INT,
    Year INT,
    IndexValue FLOAT,
    High FLOAT,
    Low FLOAT,
    TotalMarketValue FLOAT
);

LOAD DATA LOCAL INFILE 'NASDAQ-GBP.csv'
INTO TABLE GBP
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Create Summary view
CREATE VIEW Summary AS
SELECT
    COUNT(*) AS TotalRows,

    -- ROUND is a better choice since it returns double instead of string
    ROUND(AVG(IndexValue), 2) AS AvgIndexValue,
    
    MAX(IndexValue) AS MaxIndexValue,
    MIN(IndexValue) AS MinIndexValue
FROM GBP;

-- Create GBPPlus view
CREATE VIEW GBPPlus AS
SELECT
    *,

    -- ROUND is a better choice since it returns double instead of string
    -- IFNULL will set a default of 0 for no change on initial trade date
    IFNULL(ROUND(IndexValue - LAG(IndexValue) OVER (ORDER BY TradeDate), 2), 0) AS IndexChange

FROM GBP;

-- Create PlusSummary view
CREATE VIEW PlusSummary AS
SELECT
    
    -- ROUND is a better choice since it returns double instead of string
    -- therefore max and min will work now comparing doubles not strings
    ROUND(AVG(IndexChange), 2) AS AvgChange,
    
    MAX(IndexChange) AS MaxGain,
    MIN(IndexChange) AS MaxLoss
FROM GBPPlus;

-- Create ExtremeDays view
CREATE VIEW ExtremeDays AS
SELECT
    TradeDate,
    IndexChange
FROM GBPPlus
WHERE IndexChange = (SELECT MAX(IndexChange) FROM GBPPlus)
   OR IndexChange = (SELECT MIN(IndexChange) FROM GBPPlus);

-- Create WeekPattern view
CREATE VIEW WeekPattern AS
SELECT
    DayOfWeek,
    
    -- ROUND is a better choice since it returns double instead of string
    ROUND(AVG(IndexChange), 2) AS AvgChangePerWeekday

FROM GBPPlus
GROUP BY DayOfWeek;

-- Create WeekPatternByYear view
CREATE VIEW WeekPatternByYear AS
SELECT
    Year,
    DayOfWeek,

    -- ROUND is a better choice since it returns double instead of string
    ROUND(AVG(IndexChange), 2) AS AvgChangePerWeekday

FROM GBPPlus
GROUP BY Year, DayOfWeek;

-- "What is the average change for each month?"
-- Answer the question by creating a view
CREATE VIEW AvgChangePerMonth AS
SELECT
    -- Remove concat of Year and Month,
    -- better to keep Year and Month columns instead for readability
    -- and organization of data overall
    Year,
    Month,
    -- CONCAT(Year, '-', LPAD(Month, 2, '0')) AS YearMonth,

    -- ROUND is a better choice since it returns double instead of string
    ROUND(AVG(IndexChange), 2) AS AvgChange

FROM GBPPlus
GROUP BY Year, Month;
