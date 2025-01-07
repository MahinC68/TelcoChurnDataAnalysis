-- Data Summary 
-- A summary of the data and insights obtained from the previous work done
-- Divided by queries that may be useful for analysis. Not all queries will be used in the dashboard.


-- Summary of Churn Rates by Key Segments
-- Summary of Contract Type 
SELECT Contract,
    COUNT(*) AS TotalCustomers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS ChurnedCustomers,
    ROUND((SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0) / COUNT(*), 1) AS ChurnRate
FROM CustomerChurn
GROUP BY Contract
ORDER BY ChurnRate DESC;

-- Summary of Internet Service
SELECT InternetService,
    COUNT(*) AS TotalCustomers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS ChurnedCustomers,
    ROUND((SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0) / COUNT(*), 1) AS ChurnRate
FROM CustomerChurn
GROUP BY InternetService
ORDER BY ChurnRate DESC;

-- Summary of Payment Methods
SELECT PaymentMethod,
    COUNT(*) AS TotalCustomers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS ChurnedCustomers,
    ROUND((SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0) / COUNT(*), 1) AS ChurnRate
FROM CustomerChurn
GROUP BY PaymentMethod
ORDER BY ChurnRate DESC;

-- Tenure Range Summary
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
ORDER BY ChurnRate DESC;

-- Summary of Revenue Impact
-- Total Revenue Lost Due to Churn
SELECT SUM(MonthlyCharges) AS TotalMonthlyRevenueLost, SUM(TotalCharges) AS TotalRevenueLost
FROM CustomerChurn
WHERE Churn = 'Yes';

-- Potential Revenue from At-Risk Customers
SELECT Contract,
    CASE
        WHEN tenure BETWEEN 0 AND 12 THEN '0-12 Months'
        ELSE 'Other'
    END AS TenureRange,
    COUNT(*) AS TotalHighRiskCustomers,
    SUM(MonthlyCharges) AS PotentialMonthlyRevenue,
    SUM(TotalCharges) AS PotentialTotalRevenue
FROM CustomerChurn
WHERE Contract = 'Month-to-month' AND tenure BETWEEN 0 AND 12
GROUP BY Contract, TenureRange
ORDER BY PotentialMonthlyRevenue DESC;

-- Average Revenue Per User for Churned vs. Retained
SELECT Churn, ROUND(AVG(MonthlyCharges), 2) AS AvgMonthlyCharges, ROUND(AVG(TotalCharges), 2) AS AvgTotalCharges
FROM CustomerChurn
GROUP BY Churn
ORDER BY Churn;
