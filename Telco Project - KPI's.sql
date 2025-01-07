-- Key Performace Indicator (KPI) Calculations
-- Defining and calculating the metrics that can be used as a measure for success
-- A few of the queries from the EDA can be reused as KPI's

-- For future reference
SELECT *
FROM customerchurn;

-- Calculating Churn Rate
SELECT Churn, COUNT(*) AS ChurnCount, ROUND((COUNT(*) * 100.0 / (SELECT COUNT(*) FROM CustomerChurn)), 1) AS Percent
FROM CustomerChurn 
GROUP BY Churn
ORDER BY Churn;

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

-- Calculating Average Revenue Metrics
SELECT DISTINCT Churn, ROUND(AVG(MonthlyCharges), 2) AS AvgMonthlyCharges, ROUND(AVG(TotalCharges), 2) AS AvgTotalCharges
FROM CustomerChurn
GROUP BY Churn
ORDER BY Churn