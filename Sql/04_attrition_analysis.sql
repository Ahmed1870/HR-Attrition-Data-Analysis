-- Overtime gap
WITH r AS (
 SELECT overtime,
        100.0 * COUNT(*) FILTER (WHERE attrition='Yes') / COUNT(*) AS rate
 FROM employee_attrition GROUP BY overtime
)
SELECT
 MAX(rate) FILTER (WHERE overtime='Yes') AS overtime_yes_rate,
 MAX(rate) FILTER (WHERE overtime='No') AS overtime_no_rate,
 ROUND(MAX(rate) FILTER (WHERE overtime='Yes') -
       MAX(rate) FILTER (WHERE overtime='No'), 2) AS percentage_point_gap
FROM r;

-- Departments above company average
WITH company AS (
 SELECT 100.0 * COUNT(*) FILTER (WHERE attrition='Yes') / COUNT(*) AS company_rate
 FROM employee_attrition
), dept AS (
 SELECT department,
        100.0 * COUNT(*) FILTER (WHERE attrition='Yes') / COUNT(*) AS dept_rate
 FROM employee_attrition GROUP BY department
)
SELECT d.department, ROUND(d.dept_rate,2) AS dept_rate_pct
FROM dept d CROSS JOIN company c
WHERE d.dept_rate > c.company_rate
ORDER BY d.dept_rate DESC;

-- High-risk segment: overtime + >20 KM + lowest income quartile
WITH x AS (
 SELECT *, NTILE(4) OVER (ORDER BY monthly_income) AS income_quartile
 FROM employee_attrition
)
SELECT COUNT(*) AS employees,
       COUNT(*) FILTER (WHERE attrition='Yes') AS attrited,
       ROUND(100.0 * COUNT(*) FILTER (WHERE attrition='Yes') / COUNT(*),2) AS attrition_rate_pct
FROM x
WHERE overtime='Yes' AND distance_from_home > 20 AND income_quartile=1;
