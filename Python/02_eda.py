from pathlib import Path
import pandas as pd
import matplotlib.pyplot as plt

ROOT = Path(__file__).resolve().parents[1]
df = pd.read_csv(ROOT / "data" / "HR_Synthetic_Dataset.csv")

df["AttritionFlag"] = df["Attrition"].eq("Yes").astype(int)
df["IncomeGroup"] = pd.qcut(
    df["MonthlyIncome"], 4,
    labels=["Q1 - Low", "Q2", "Q3", "Q4 - High"]
)
df["FarFromHome"] = df["DistanceFromHome"] > 20

print("Shape:", df.shape)
print("Missing values:\n", df.isna().sum())
print("Overall attrition:", f"{df['AttritionFlag'].mean():.2%}")

for col in ["OverTime", "Department", "JobRole", "IncomeGroup", "FarFromHome"]:
    print(f"\nAttrition by {col}:")
    print((df.groupby(col, observed=True)["AttritionFlag"].mean() * 100).round(2))

# Simple portfolio chart
dept = (df.groupby("Department")["AttritionFlag"].mean()*100).sort_values(ascending=False)
plt.figure(figsize=(9,5))
dept.plot(kind="bar")
plt.title("Attrition Rate by Department")
plt.ylabel("Attrition Rate (%)")
plt.xlabel("")
plt.xticks(rotation=0)
plt.tight_layout()
plt.savefig(ROOT/"reports"/"attrition_by_department.png", dpi=180)
plt.close()
