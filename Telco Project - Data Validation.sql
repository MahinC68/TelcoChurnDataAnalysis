-- Data Validation
-- This step is important to ensure that data is of high quality.
-- By making sure that there are no duplicates, null values, and other descrepincies, it provides more accurracy within the insight obtained.
-- Also ensure that the data was imported correctly, amongst other important factors.
-- By running the queries individually and comparing to the intuition of the expected results, the validity of the overall data can be ensured


-- Checking the total number of rows. Will often refer back to this in future code to assure validity
SELECT COUNT(*) AS TotalRows
FROM CustomerChurn;
-- Ensuring that there are no duplicate customerIDs. After running the code, there are no duplicate customerIDs
SELECT COUNT(DISTINCT customerID) AS NumberOfCustomerIDs 
FROM CustomerChurn; 
-- Verifying column names and data types
DESCRIBE CustomerChurn;


-- Identify Missing Values

-- Checking for NULL values in key columns. Expected result is 0.
SELECT 
    COUNT(*) AS MissingTotalCharges 
    FROM CustomerChurn 
    WHERE TotalCharges IS NULL;
SELECT 
    COUNT(*) AS MissingMonthlyCharges 
    FROM CustomerChurn 
    WHERE MonthlyCharges IS NULL;
SELECT 
    COUNT(*) AS MissingTenure 
    FROM CustomerChurn 
    WHERE tenure IS NULL;
-- Verifies the number of rows with missing values. Should be 0 to ensure that data is valid.
SELECT 
    COUNT(*) AS RowsWithMissingValues 
FROM CustomerChurn
WHERE TotalCharges IS NULL OR MonthlyCharges IS NULL OR tenure IS NULL;


-- Checking if there are duplicate values
SELECT 
    customerID, COUNT(*) AS DuplicateCount
FROM CustomerChurn
GROUP BY customerID
HAVING DuplicateCount > 1;


-- Validating the data types. Expecting 0 for the outputs.
SELECT 
    COUNT(*) AS InvalidMonthlyCharges 
FROM CustomerChurn 
WHERE MonthlyCharges < 0;
SELECT 
    COUNT(*) AS InvalidTotalCharges 
FROM CustomerChurn 
WHERE TotalCharges < 0;
SELECT 
    COUNT(*) AS InvalidTenure 
FROM CustomerChurn 
WHERE tenure < 0;


-- Verifying that the categorical data is consistent with the correct values

-- Listing all distinct values in the Churn, Contract, and PaymentMethod columns
SELECT DISTINCT Churn 
FROM CustomerChurn;
SELECT DISTINCT Contract 
FROM CustomerChurn;
SELECT DISTINCT PaymentMethod 
FROM CustomerChurn;

-- Counting the number of occurrences for each unique value in the Churn and contract column
-- Sum of yes and no's should be equal to 7032
SELECT 
    Churn, COUNT(*) AS Count 
FROM CustomerChurn 
GROUP BY Churn;
SELECT 
    Contract, COUNT(*) AS Count 
FROM CustomerChurn 
GROUP BY Contract;


-- A summary for the validity of the result
-- Shows the total rows with no missing values in columns that may be important to the insights
SELECT 
    COUNT(*) AS ValidRows 
FROM CustomerChurn
WHERE TotalCharges IS NOT NULL AND MonthlyCharges IS NOT NULL AND tenure IS NOT NULL;
