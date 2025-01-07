-- Segmentation Analysis
-- Identifying the high risk groups (churn) by segmenting the demographics given in the data

-- For future reference
SELECT *
FROM customerchurn;

-- Segmentation by Contract Type
SELECT 
    Contract,
    COUNT(*) AS TotalCustomers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS ChurnedCustomers,
    ROUND((SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0) / COUNT(*), 1) AS ChurnRate
FROM CustomerChurn
GROUP BY Contract
ORDER BY ChurnRate DESC;

-- Segmentation by Tenure Ranges
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

-- Segmentation by Monthly Charges
SELECT 
    CASE
        WHEN MonthlyCharges BETWEEN 0 AND 50 THEN '0-50'
        WHEN MonthlyCharges BETWEEN 51 AND 100 THEN '51-100'
        WHEN MonthlyCharges BETWEEN 101 AND 150 THEN '101-150'
        ELSE '151+'
    END AS ChargeRange,
    COUNT(*) AS TotalCustomers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS ChurnedCustomers,
    ROUND((SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0) / COUNT(*), 1) AS ChurnRate
FROM CustomerChurn
GROUP BY ChargeRange
ORDER BY ChargeRange;

-- Segmentation by MCustomer Demographics
SELECT 
    Gender,
    COUNT(*) AS TotalCustomers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS ChurnedCustomers,
    ROUND((SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0) / COUNT(*), 1) AS ChurnRate
FROM CustomerChurn
GROUP BY Gender
ORDER BY Gender;

SELECT 
    SeniorCitizen,
    COUNT(*) AS TotalCustomers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS ChurnedCustomers,
    ROUND((SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0) / COUNT(*), 1) AS ChurnRate
FROM CustomerChurn
GROUP BY SeniorCitizen
ORDER BY SeniorCitizen;

SELECT 
    Partner,
    COUNT(*) AS TotalCustomers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS ChurnedCustomers,
    ROUND((SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0) / COUNT(*), 1) AS ChurnRate
FROM CustomerChurn
GROUP BY Partner
ORDER BY Partner;

-- Identifying the HIgh-Risk Segments
SELECT 
    Contract,
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
GROUP BY Contract, TenureRange
ORDER BY ChurnRate DESC;

SELECT 
    InternetService,
    PaymentMethod,
    COUNT(*) AS TotalCustomers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS ChurnedCustomers,
    ROUND((SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0) / COUNT(*), 1) AS ChurnRate
FROM CustomerChurn
GROUP BY InternetService, PaymentMethod
ORDER BY ChurnRate DESC;
