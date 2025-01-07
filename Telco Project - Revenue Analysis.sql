-- Revenue Analysis Outline
-- Calculating the revnue lost from churn
-- By analyzing the customer demographic(s) that is/are at risk, the potential revenue that can be gained by retaining these customers can be identified

-- For future reference
SELECT *
FROM customerchurn;

-- Calculating the Revenue That Has been Lost Due to Churn
SELECT Churn, SUM(MonthlyCharges) AS TotalMonthlyRevenueLost, SUM(TotalCharges) AS TotalRevenueLost
FROM CustomerChurn
WHERE Churn = 'Yes'
Order BY Churn;

-- Approximating the revenue that can be gained from retaining at-risk customers
-- Based on the Segementation Analysis, customers with a tenure of 0-12 months have the highest churn rates (there is also a correlation with age).
-- Due to this, customers in thi range fall into the 'at-risk' category.
SELECT 
    Contract,
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


-- Analyzing the Average Revenue Per User
SELECT Churn, ROUND(AVG(MonthlyCharges), 2) AS AvgMonthlyCharges, ROUND(AVG(TotalCharges), 2) AS AvgTotalCharges
FROM CustomerChurn
GROUP BY Churn
ORDER BY Churn;
