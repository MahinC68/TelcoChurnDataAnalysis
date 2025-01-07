-- Exploratory Data Analysis
-- By analyzing the specific information given to us in more detail using SQL queries, greater insights can be obtained from the data

-- For future reference
SELECT *
FROM customerchurn;

SELECT COUNT(customerID) AS NumOfCustomers
FROM customerChurn;


-- Calculating the min, max, average, and standard deviation for MonthlyCharges, Tenure, and TotalCharges
SELECT 
    MIN(MonthlyCharges) AS MinMonthlyCharges,
    MAX(MonthlyCharges) AS MaxMonthlyCharges,
    AVG(MonthlyCharges) AS AvgMonthlyCharges,
    STDDEV(MonthlyCharges) AS StdDevMonthlyCharges
FROM CustomerChurn;

SELECT 
    MIN(tenure) AS MinTenure,
    MAX(tenure) AS MaxTenure,
    AVG(tenure) AS AvgTenure,
    STDDEV(tenure) AS StdDevTenure
FROM CustomerChurn;

SELECT 
    MIN(TotalCharges) AS MinTotalCharges,
    MAX(TotalCharges) AS MaxTotalCharges,
    AVG(TotalCharges) AS AvgTotalCharges,
    STDDEV(TotalCharges) AS StdDevTotalCharges
FROM CustomerChurn;

-- Grouping into different ranges
SELECT 
    CASE
        WHEN MonthlyCharges BETWEEN 0 AND 50 THEN '0-50'
        WHEN MonthlyCharges BETWEEN 51 AND 100 THEN '51-100'
        WHEN MonthlyCharges BETWEEN 101 AND 150 THEN '101-150'
        WHEN MonthlyCharges BETWEEN 151 AND 200 THEN '151-200'
        ELSE '201+'
    END AS ChargeRange,
    COUNT(*) AS CustomerCount
FROM CustomerChurn
GROUP BY ChargeRange
ORDER BY ChargeRange;

SELECT 
    CASE
        WHEN tenure BETWEEN 0 AND 12 THEN '0-12 Months'
        WHEN tenure BETWEEN 13 AND 24 THEN '13-24 Months'
        WHEN tenure BETWEEN 25 AND 36 THEN '25-36 Months'
        WHEN tenure BETWEEN 37 AND 48 THEN '37-48 Months'
        WHEN tenure BETWEEN 49 AND 60 THEN '49-60 Months'
        ELSE '61+ Months'
    END AS TenureRange,
    COUNT(*) AS CustomerCount
FROM CustomerChurn
GROUP BY TenureRange
ORDER BY TenureRange;

SELECT 
    CASE
        WHEN TotalCharges BETWEEN 0 AND 1000 THEN '0-1000'
        WHEN TotalCharges BETWEEN 1001 AND 2000 THEN '1001-2000'
        WHEN TotalCharges BETWEEN 2001 AND 3000 THEN '2001-3000'
        WHEN TotalCharges BETWEEN 3001 AND 4000 THEN '3001-4000'
        ELSE '4001+'
    END AS TotalChargeRange,
    COUNT(*) AS CustomerCount
FROM CustomerChurn
GROUP BY TotalChargeRange
ORDER BY TotalChargeRange;

-- Counting the different categoirical values
SELECT Contract, COUNT(*) AS ContractCount
FROM CustomerChurn
GROUP BY Contract
ORDER BY Contract;
SELECT Churn, COUNT(*) AS ChurnCount
FROM CustomerChurn
GROUP BY Churn
ORDER BY Churn;
SELECT InternetService, COUNT(*) AS ServiceCount
FROM CustomerChurn
GROUP BY InternetService
ORDER BY InternetService;


-- Calculating Churn Rate
SELECT Churn, COUNT(*) AS ChurnCount, ROUND((COUNT(*) * 100.0 / (SELECT COUNT(*) FROM CustomerChurn)), 1) AS Percent
FROM CustomerChurn 
GROUP BY Churn
ORDER BY Churn;


-- Segment Analysis
-- Churn Rate by Contract Type
SELECT 
    Contract,
    COUNT(*) AS TotalCustomers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS ChurnedCustomers,
    ROUND((SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0) / COUNT(*), 1) AS ChurnRate
FROM CustomerChurn
GROUP BY Contract;

-- Churn Rate by Internet Service Type
SELECT 
    InternetService,
    COUNT(*) AS TotalCustomers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS ChurnedCustomers,
    ROUND((SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0) / COUNT(*), 1) AS ChurnRate
FROM CustomerChurn
GROUP BY InternetService;

-- Churn Rate by Payment Method
SELECT 
    PaymentMethod,
    COUNT(*) AS TotalCustomers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS ChurnedCustomers,
    ROUND((SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0) / COUNT(*), 1) AS ChurnRate
FROM CustomerChurn
GROUP BY PaymentMethod;



-- Analyzing Customer Tenure
SELECT 
    CASE
        WHEN tenure BETWEEN 0 AND 12 THEN '0-12 Months'
        WHEN tenure BETWEEN 13 AND 24 THEN '13-24 Months'
        WHEN tenure BETWEEN 25 AND 36 THEN '25-36 Months'
        WHEN tenure BETWEEN 37 AND 48 THEN '37-48 Months'
        WHEN tenure BETWEEN 49 AND 60 THEN '49-60 Months'
        ELSE '61+ Months'
    END AS TenureRange,
    COUNT(*) AS TotalCustomers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS ChurnedCustomers,
    ROUND((SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0) / COUNT(*), 1) AS ChurnRate
FROM CustomerChurn
GROUP BY TenureRange
ORDER BY TenureRange;



-- Revenue Analysis
SELECT 
    CASE
        WHEN tenure BETWEEN 0 AND 12 THEN '0-12 Months'
        WHEN tenure BETWEEN 13 AND 24 THEN '13-24 Months'
        WHEN tenure BETWEEN 25 AND 36 THEN '25-36 Months'
        WHEN tenure BETWEEN 37 AND 48 THEN '37-48 Months'
        WHEN tenure BETWEEN 49 AND 60 THEN '49-60 Months'
        ELSE '61+ Months'
    END AS TenureRange,
    COUNT(*) AS TotalCustomers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS ChurnedCustomers,
    ROUND((SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0) / COUNT(*), 1) AS ChurnRate
FROM CustomerChurn
GROUP BY TenureRange
ORDER BY TenureRange;

-- Analyze monthly and total charges based on churn status
SELECT 
    Churn,
    ROUND(AVG(MonthlyCharges), 2) AS AvgMonthlyCharges,
    ROUND(AVG(TotalCharges), 2) AS AvgTotalCharges
FROM CustomerChurn
GROUP BY Churn;

-- Calculate average revenue per user for churned and retained segments
SELECT 
    Churn,
    ROUND(SUM(TotalCharges) / COUNT(*), 2) AS AverageRevenuePerUser
FROM CustomerChurn
GROUP BY Churn;


-- Analyze Option Services
SELECT 
    StreamingTV,
    COUNT(*) AS TotalCustomers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS ChurnedCustomers,
    ROUND((SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0) / COUNT(*), 1) AS ChurnRate
FROM CustomerChurn
GROUP BY StreamingTV
ORDER BY ChurnRate DESC;

SELECT 
    Churn,
    StreamingTV,
    COUNT(*) AS CustomerCount
FROM CustomerChurn
GROUP BY Churn, StreamingTV
ORDER BY StreamingTV, Churn;







