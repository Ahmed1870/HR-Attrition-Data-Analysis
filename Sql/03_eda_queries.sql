-- Overall KPI
SELECT COUNT(*) AS total_employees,
       COUNT(*) FILTER (WHERE attrition='Yes') AS attrited_employees,
       ROUND(100.0 * COUNT(*) FILTER (WHERE attrition='Yes') / COUNT(*), 2) AS attrition_rate_pct
FROM employee_attrition;

-- Department
SELECT department,
       COUNT(*) AS employees,
       COUNT(*) FILTER (WHERE attrition='Yes') AS attrited,
       ROUND(100.0 * COUNT(*) FILTER (WHERE attrition='Yes') / COUNT(*), 2) AS attrition_rate_pct
FROM employee_attrition
GROUP BY department
ORDER BY attrition_rate_pct DESC;

-- Overtime
SELECT overtime,
       COUNT(*) AS employees,
       ROUND(100.0 * COUNT(*) FILTER (WHERE attrition='Yes') / COUNT(*), 2) AS attrition_rate_pct
FROM employee_attrition
GROUP BY overtime
ORDER BY attrition_rate_pct DESC;

-- Distance
SELECT CASE
         WHEN distance_from_home <= 10 THEN '0-10 KM'
         WHEN distance_from_home <= 20 THEN '11-20 KM'
         WHEN distance_from_home <= 30 THEN '21-30 KM'
         WHEN distance_from_home <= 40 THEN '31-40 KM'
         ELSE '41-50 KM'
       END AS distance_group,
       COUNT(*) AS employees,
       ROUND(100.0 * COUNT(*) FILTER (WHERE attrition='Yes') / COUNT(*), 2) AS attrition_rate_pct
FROM employee_attrition
GROUP BY 1 ORDER BY 1;

-- Income quartiles
WITH x AS (
    SELECT *, NTILE(4) OVER (ORDER BY monthly_income) AS income_quartile
    FROM employee_attrition
)
SELECT income_quartile,
       COUNT(*) AS employees,
       ROUND(100.0 * COUNT(*) FILTER (WHERE attrition='Yes') / COUNT(*), 2) AS attrition_rate_pct,
       ROUND(AVG(monthly_income), 0) AS avg_income
FROM x GROUP BY income_quartile ORDER BY income_quartile;

-- Job role
SELECT job_role,
       COUNT(*) AS employees,
       ROUND(100.0 * COUNT(*) FILTER (WHERE attrition='Yes') / COUNT(*), 2) AS attrition_rate_pct,
       ROUND(AVG(monthly_income), 0) AS avg_income
FROM employee_attrition
GROUP BY job_role ORDER BY attrition_rate_pct DESC;
