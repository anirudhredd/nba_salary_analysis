library(readxl)
library(dplyr)
library(corrplot)

# Loading the dataset
data <- read.csv("D:/UCD/BANA - Stats/Final Project/Updated_Book_Hypothesis.csv")

# Selecting relevant columns
data_analysis <- select(data, Salary, ImpactInGame)

# Correlation test
correlation_test <- cor.test(data_analysis$Salary, data_analysis$ImpactInGame)

# Output the results
print(correlation_test)


