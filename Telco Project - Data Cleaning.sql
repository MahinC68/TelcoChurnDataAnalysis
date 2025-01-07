-- Data Cleaning
-- Although the data passed the validation stage, some cleaning was done to ensure accuracy


-- Remove possible duplicates
DELETE FROM CustomerChurn
WHERE customerID IN (
    SELECT customerID
    FROM (
        SELECT customerID, COUNT(*) AS DuplicateCount
        FROM CustomerChurn
        GROUP BY customerID
        HAVING DuplicateCount > 1
    ) AS temp
);


-- Missing values
UPDATE CustomerChurn
SET TotalCharges = 0
WHERE TotalCharges IS NULL;
UPDATE CustomerChurn
SET MonthlyCharges = 0
WHERE MonthlyCharges IS NULL;
UPDATE CustomerChurn
SET tenure = 0
WHERE tenure IS NULL;


-- This is an important step which ensure that all 'Yes' and 'No' values are handled the same, regardless of capitalizations
UPDATE CustomerChurn
SET Churn = 'Yes'
WHERE Churn = 'yes';
UPDATE CustomerChurn
SET Churn = 'No'
WHERE Churn = 'no';


-- Verification after cleaning is done
SELECT COUNT(*) AS TotalRows FROM CustomerChurn;
SELECT COUNT(DISTINCT customerID) AS UniqueCustomerIDs FROM CustomerChurn;
SELECT COUNT(*) AS MissingTotalCharges FROM CustomerChurn WHERE TotalCharges IS NULL;
SELECT COUNT(*) AS MissingMonthlyCharges FROM CustomerChurn WHERE MonthlyCharges IS NULL;
SELECT COUNT(*) AS MissingTenure FROM CustomerChurn WHERE tenure IS NULL;


