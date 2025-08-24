--1.Select all the data
SELECT * FROM HR_Analytics;

--2.What is the total number of employees?
SELECT COUNT(*) AS Employee_Count 
FROM HR_Analytics;

--3.How many employees have left the company (Attrition = 'Yes')?
SELECT COUNT(*) AS Employee_Count FROM HR_Analytics
WHERE Attrition = 1;

--4.What is the attrition rate (%)?
SELECT 
   ROUND(
        CAST(SUM(CASE WHEN Attrition = 1 THEN 1 ELSE 0 END) AS FLOAT) / COUNT(*) * 100,2
    ) AS Attrition_Rate
FROM HR_Analytics;

--5.What is the attrition rate by department?
   SELECT 
    Department,
    ROUND(
        CAST(SUM(CASE WHEN Attrition = 1 THEN 1 ELSE 0 END) AS FLOAT) / COUNT(*) * 100,2
    ) AS Attrition_Rate
FROM HR_Analytics
GROUP BY Department;

--6.What are the top 3 job roles with highest attrition rate?
SELECT TOP 3 
    JobRole,
    ROUND(
        CAST(SUM(CASE WHEN Attrition =1 THEN 1 ELSE 0 END) AS FLOAT) / COUNT(*) * 100, 2
    ) AS Attrition_Rate
FROM HR_Analytics
GROUP BY JobRole
ORDER BY Attrition_Rate DESC;

--7.What is the average income by attrition status?
SELECT  Attrition,
    CASE 
        WHEN Attrition =1 THEN 'Left' 
        ELSE 'Stayed' 
    END AS Status,
    AVG(MonthlyIncome) AS Avg_Income
FROM HR_Analytics
GROUP BY Attrition;

--8.What is the average monthly income by department?
SELECT Department, AVG(MonthlyIncome) Average_Monthly_Income
FROM HR_Analytics
GROUP BY Department;

--9.Which job role has the highest attrition count?
SELECT JobRole, COUNT(*) AS Attrition_Count
FROM HR_Analytics
GROUP BY JobRole
ORDER BY Attrition_Count DESC;

--10.List employees who have more than 10 years at the company.
SELECT  EmployeeID,  YearsAtCompany AS Experience 
FROM  HR_Analytics
WHERE YearsAtCompany > 10
ORDER BY EmployeeID;

--11.What is the average job satisfaction level by gender?
SELECT Gender, AVG(JobSatisfaction) AS Average_Job_Satisfaction
FROM HR_Analytics
GROUP BY Gender;

--12.Show attrition count grouped by marital status
SELECT MaritalStatus,
    COUNT(CASE WHEN Attrition = 1 THEN 1 END) AS Left_Count,
    COUNT(CASE WHEN Attrition = 0 THEN 1 END) AS Stayed_Count
FROM HR_Analytics
GROUP BY MaritalStatus;

--13.Get the top 5 departments with highest average income
SELECT TOP 5 Department,AVG(MonthlyIncome) AS Average_Monthly_Income
FROM HR_Analytics
GROUP BY Department
ORDER BY Average_Monthly_Income DESC;

--14.Find the count of employees who work overtime and left the company
SELECT COUNT(*) AS Overtime_Attrition_Count
FROM HR_Analytics
WHERE Overtime = 1 AND Attrition = 1;

--15.What is the gender ratio in each department?
SELECT 
    Department,
    COUNT(CASE WHEN Gender = 'Male' THEN 1 END) AS Male_Count,
    COUNT(CASE WHEN Gender = 'Female' THEN 1 END) AS Female_Count
FROM HR_Analytics
GROUP BY Department;

--16.List employees with age > 45 and income > 20,000
SELECT EmployeeID,Age,MonthlyIncome
FROM HR_Analytics
WHERE Age>45 AND MonthlyIncome>20000
ORDER BY Age, MonthlyIncome;

--17.Show average years at company for employees who stayed vs left
SELECT AVG(YearsAtCompany) AS Average_Experience,Attrition,
CASE WHEN Attrition =1 THEN 'Left' ELSE 'Stayed' END AS Status
FROM HR_Analytics
GROUP BY Attrition;

--18.What is the average age by education field?
SELECT EducationField,AVG(Age) AS Average_Age
FROM HR_Analytics
GROUP BY EducationField;

