DROP TABLE IF EXISTS employee_attrition;

CREATE TABLE employee_attrition (
    employee_id VARCHAR(20) PRIMARY KEY,
    age INT NOT NULL CHECK (age BETWEEN 22 AND 60),
    gender VARCHAR(10) NOT NULL,
    department VARCHAR(50) NOT NULL,
    job_role VARCHAR(50) NOT NULL,
    monthly_income NUMERIC(12,2) NOT NULL,
    overtime VARCHAR(3) NOT NULL,
    distance_from_home INT NOT NULL CHECK (distance_from_home BETWEEN 1 AND 50),
    years_at_company INT NOT NULL CHECK (years_at_company >= 0),
    performance_rating INT NOT NULL CHECK (performance_rating BETWEEN 1 AND 4),
    work_life_balance INT NOT NULL CHECK (work_life_balance BETWEEN 1 AND 4),
    attrition VARCHAR(3) NOT NULL
);

-- Load HR_Synthetic_Dataset.csv with your PostgreSQL client.
-- COPY employee_attrition FROM '/path/HR_Synthetic_Dataset.csv'
-- WITH (FORMAT csv, HEADER true);
