-- Duplicate IDs
SELECT employee_id, COUNT(*) AS duplicate_count
FROM employee_attrition
GROUP BY employee_id
HAVING COUNT(*) > 1;

-- Null checks
SELECT
 COUNT(*) FILTER (WHERE employee_id IS NULL) AS employee_id_nulls,
 COUNT(*) FILTER (WHERE age IS NULL) AS age_nulls,
 COUNT(*) FILTER (WHERE monthly_income IS NULL) AS income_nulls,
 COUNT(*) FILTER (WHERE attrition IS NULL) AS attrition_nulls
FROM employee_attrition;

-- Range checks
SELECT *
FROM employee_attrition
WHERE age NOT BETWEEN 22 AND 60
   OR distance_from_home NOT BETWEEN 1 AND 50
   OR performance_rating NOT BETWEEN 1 AND 4
   OR work_life_balance NOT BETWEEN 1 AND 4;

SELECT COUNT(*) AS employee_count FROM employee_attrition;
