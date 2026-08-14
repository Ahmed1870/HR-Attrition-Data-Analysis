# Power BI Dashboard Specification

Source: `data/HR_Synthetic_Dataset.csv`

## Core measures

```DAX
Total Employees = COUNTROWS(employee_attrition)

Attrited Employees =
CALCULATE([Total Employees], employee_attrition[attrition] = "Yes")

Attrition Rate =
DIVIDE([Attrited Employees], [Total Employees], 0)

Average Monthly Income =
AVERAGE(employee_attrition[monthly_income])

Average Years At Company =
AVERAGE(employee_attrition[years_at_company])
```

## Recommended visuals

KPI cards:
- Total Employees
- Attrited Employees
- Attrition Rate
- Average Monthly Income
- Average Years At Company

Charts:
- Attrition Rate by Department
- Attrition Rate by OverTime
- Attrition Rate by JobRole
- Attrition Rate by Income Quartile
- Attrition Rate by Distance Group
- Attrition Rate by Age Group
- Attrition by Gender

Slicers:
Department, JobRole, Gender, OverTime, Age Group.

The `.pbix` binary is intentionally not fabricated. This folder contains the exact build specification so the dashboard can be recreated in Power BI Desktop from the supplied dataset.
