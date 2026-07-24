-- =====================================
-- 🛒 HR Attrition Analysis SQL PROJECT
-- =====================================
-- Author: Gunjan Rana
-- =====================================
-- 1. DATABASE SETUP & INITIAL EXPLORATION
-- =====================================

USE hr_attrition_analysis;

SHOW Tables;

DESC employees;

-- Preview dataset
SELECT * FROM employees;

-- =====================================
-- 2. DATA CLEANING & PREPARATION
-- =====================================

-- Fix column name encoding issues 

ALTER TABLE employees
RENAME COLUMN ï»¿Age TO Age;

-- Check total records

SELECT COUNT(*) FROM employees;

-- ====================================================
-- EMPLOYMENT ATTRITION ANALYSIS
-- ====================================================

-- Total Employees Left
SELECT 
COUNT(*) AS Total_Employees,
SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS Employees_Left
FROM employees;

-- Total Attrition Rate
SELECT 
COUNT(*) AS Total_Employees,
SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS Employees_Left,
ROUND(SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*100.0 / COUNT(*),2) AS Attrition_Rate
FROM employees
ORDER BY Attrition_Rate DESC;

-- Department-wise Attrition Analysis
SELECT Department,
COUNT(*) AS Total_Employees,
SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS Employees_Left,
ROUND(SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*100.0 / COUNT(*),2) AS Attrition_Rate
FROM employees
GROUP BY Department
ORDER BY Attrition_Rate DESC;

-- JobRole-wise Attrition Analysis
SELECT JobRole,
COUNT(*) AS Total_Employees,
SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS Employees_Left,
ROUND(SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*100.0 / COUNT(*),2) AS Attrition_Rate
FROM employees
GROUP BY JobRole
ORDER BY Attrition_Rate DESC;

-- Impact of Overtime on Employee Attrition
SELECT COUNT(*) AS Total_Overtime_Employees,
COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) AS Employees_Left,
ROUND(COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) * 100.0 / COUNT(*),2) AS Attrition_Rate_Percentage
FROM Employees
WHERE OverTime = 'Yes';

-- Age Group Analysis of Employee Turnover
SELECT CASE
WHEN Age BETWEEN 18 AND 30 THEN '18-30'
WHEN Age BETWEEN 31 AND 40 THEN '31-40'
WHEN Age BETWEEN 41 AND 50 THEN '41-50'
ELSE '51+'
END AS Age_Group,
COUNT(*) AS total_employees,
COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) AS Employees_Left,
ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 END)*100.0 / COUNT(*),2) AS Attrition_Rate
FROM Employees
GROUP BY CASE
WHEN Age BETWEEN 18 AND 30 THEN '18-30'
WHEN Age BETWEEN 31 AND 40 THEN '31-40'
WHEN Age BETWEEN 41 AND 50 THEN '41-50'
ELSE '51+'
END
ORDER BY Attrition_Rate DESC; 

-- What is the relationship between salary and attrition?
SELECT CASE 
WHEN MonthlyIncome BETWEEN 1000 AND 5000 THEN "Low"
WHEN MonthlyIncome BETWEEN 5000 AND 10000 THEN "Medium"
ELSE "High"
END AS Salary_Group,
COUNT(*) AS Total_Employees,
COUNT(CASE WHEN Attrition="Yes" THEN 1 END) AS Employees_Left,
ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 END)*100.0 / COUNT(*),2) AS Attrition_Rate
FROM employees
GROUP BY CASE 
WHEN MonthlyIncome BETWEEN 1000 AND 5000 THEN "Low"
WHEN MonthlyIncome BETWEEN 5000 AND 10000 THEN "Medium"
ELSE "High"
END
ORDER BY Attrition_Rate DESC;

-- Does a lack of promotion increase employee attrition?
SELECT CASE
WHEN YearsSinceLastPromotion BETWEEN 0 AND 3 THEN "0-3 Years"
WHEN YearsSinceLastPromotion BETWEEN 4 AND 7 THEN "4-7 Years"
WHEN YearsSinceLastPromotion BETWEEN 8 AND 11 THEN "8-11 Years"
ELSE "12+ Years"
END AS Promotion_Group,
COUNT(*) AS Total_Employees,
COUNT(CASE WHEN Attrition="Yes" THEN 1 END) AS Employees_Left,
ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 END)*100.0 / COUNT(*),2) AS Attrition_Rate
FROM employees
GROUP BY CASE
WHEN YearsSinceLastPromotion BETWEEN 0 AND 3 THEN "0-3 Years"
WHEN YearsSinceLastPromotion BETWEEN 4 AND 7 THEN "4-7 Years"
WHEN YearsSinceLastPromotion BETWEEN 8 AND 11 THEN "8-11 Years"
ELSE "12+ Years"
END
ORDER BY Attrition_Rate DESC;

-- Which group has higher attrition: Single or Married employees?
SELECT MaritalStatus,
COUNT(*) AS Total_Employees,
COUNT(CASE WHEN Attrition="Yes" THEN 1 END) AS Employees_Left,
ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 END)*100.0 / COUNT(*),2) AS Attrition_Rate
FROM employees
GROUP BY MaritalStatus
ORDER BY Attrition_Rate DESC;

-- Does Work-Life Balance affect employee attrition?
SELECT WorkLifeBalance,
COUNT(*) AS Total_Employees,
COUNT(CASE WHEN Attrition="Yes" THEN 1 END) AS Employees_Left,
ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 END)*100.0 / COUNT(*),2) AS Attrition_Rate
FROM employees
GROUP BY WorkLifeBalance
ORDER BY Attrition_Rate DESC;

-- ===================================================================
-- WORK FORCE ANALYSIS
-- ===================================================================

-- What is the employee distribution in each department?
SELECT Department,
COUNT(*) AS Total_Employees
FROM employees
GROUP BY Department
ORDER BY Total_Employees DESC;

-- What is the gender distribution of the employees?
SELECT GENDER,
COUNT(*) AS Total_Employees
FROM employees
GROUP BY Gender
ORDER BY Total_Employees DESC;

-- Which education field has the highest nu,mber of employees?
SELECT EducationField,
COUNT(*) AS Total_Employees
FROM employees
GROUP BY EducationField
ORDER BY Total_Employees DESC;

-- ================================================================
-- COMPENSATION ANALYSIS
-- ================================================================

-- Which department offer the highest average salary?
SELECT Department,
ROUND(AVG(MonthlyIncome),2) AS Avg_salary
FROM employees
GROUP BY Department
ORDER BY Avg_salary DESC;

-- Which jobrole offer the highest avergae salary?
SELECT JobRole,
ROUND(AVG(MonthlyIncome),2) AS Avg_salary
FROM employees
GROUP BY JobRole
ORDER BY Avg_salary DESC;

-- Does education influence salary?
SELECT Education, 
ROUND(AVG(MonthlyIncome),2) AS Avg_salary
FROM employees
GROUP BY Education
ORDER BY Avg_salary DESC;

-- ===============================================================
-- EMPLOYEE SATISFACTION ANALYSIS
-- ================================================================

-- Which department has the highest jobsatisfaction?
SELECT Department,
ROUND(AVG(JobSatisfaction),2) AS avg_jobsatisfaction
FROM employees
GROUP BY Department
ORDER BY avg_jobsatisfaction DESC;

-- Which department has the highest work life balance?
SELECT Department,
ROUND(AVG(WorkLifeBalance),2) AS avg_WorkLifeBalance
FROM employees
GROUP BY Department
ORDER BY avg_WorkLifeBalance DESC;

-- =================================================
-- EXPERIENCE AND ANALYSIS
-- ==================================================

-- Which department has the most experience employees?
SELECT Department,
ROUND(AVG(TotalWorkingYears),2) AS Avg_TotalWorkingYears
FROM employees
GROUP BY Department
ORDER BY Avg_TotalWorkingYears DESC;

-- What is the average tenure of employees in the company?
SELECT Department,
ROUND(AVG(YearsAtCompany),2) AS Avg_YearsAtCompany
FROM employees
GROUP BY Department
ORDER BY Avg_YearsAtCompany DESC;

-- Which job role has the highest average tenure?
SELECT JobRole,
ROUND(AVG(YearsAtCompany),2) AS Avg_YearsAtCompany
FROM employees
GROUP BY JobRole
ORDER BY Avg_YearsAtCompany DESC;

-- ==============================================================================
-- ==============================================================================