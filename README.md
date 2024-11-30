
# NBA Salary Analysis

A data-driven analysis of NBA player salaries using ARIMA for forecasting and Random Forest for predictive modeling. This project explores the relationship between player performance metrics and salaries, providing actionable insights for team management.

---

## **Project Overview**
- **Objective**: Analyze and forecast NBA player salaries based on key performance metrics such as points scored, assists, and age.
- **Tools Used**: R, ARIMA, Random Forest, ggplot2, Tableau.
- **Key Results**:
  - Strong correlation between points scored and salary (r = 0.73).
  - ARIMA models predict future salaries with high accuracy.
  - Random Forest achieves an R² of 0.74, identifying critical salary predictors.

---

## **Features**
- **Exploratory Data Analysis**: Detailed visualizations of salary trends by position, age, and performance metrics.
- **Forecasting**: ARIMA models predicting salaries for top NBA players.
- **Predictive Modeling**: Random Forest analysis highlighting feature importance.
- **Impact Score**: Combined normalized metrics to evaluate player contribution.

---

## **Repository Structure**
```
nba_salary_analysis/
│
├── data/            # Datasets used for analysis
├── scripts/         # R scripts for EDA, modeling, and forecasting
├── visuals/         # PNG/JPEG files of visualizations
├── docs/            # Reports and project documentation
└── README.md        # Overview of the project
```

---

## **Visualizations**
- **Salary vs. Points Scored**:
  ![Scatterplot of Salary vs. Points](visuals/salary_vs_points.png)
- **Salary Forecasts**:
  ![Salary Forecast for Top Players](visuals/salary_forecast.png)

---

## **How to Use**
1. Clone this repository:
   ```
   git clone https://github.com/yourusername/nba_salary_analysis.git
   ```
2. Navigate to the `scripts/` folder and run the R scripts to replicate analyses.
3. View the visualizations in the `visuals/` folder.

---


