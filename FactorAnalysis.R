# Installing necessary packages
install.packages("GPArotation")
install.packages("factoextra")
install.packages("psych")

# Loading required libraries
library(readr)
library(readxl)
library(factoextra)
library(psych)
library(GPArotation)

# Reading the dataset
data <- read_excel("D:/UCD/BANA - Stats/Final Project/Regression_Book.xlsx")

# Printing column names
print(names(data))

# Exploring the structure of dataset
str(data)

# Selecting variables of interest
variables_of_interest <- data[, c('Salary','Age', 'GP', 'GS', 'MP', 'FG', 'FGA', 'FG%', '3P', '3PA', '3P%', '2P', '2PA', '2P%', 
                                  'eFG%', 'FT', 'FTA', 'FT%', 'ORB', 'DRB', 'TRB', 'AST', 'STL', 'BLK', 'TOV', 
                                  'PF', 'PTS', 'Total Minutes', 'PER', 'TS%', '3PAr', 'FTr', 'ORB%', 'DRB%', 
                                  'TRB%', 'AST%', 'STL%', 'BLK%', 'TOV%', 'USG%', 'OWS', 'DWS', 'WS', 'WS/48', 
                                  'OBPM', 'DBPM', 'BPM', 'VORP')]

# Removing missing values
variables_of_interest <- na.omit(variables_of_interest)

# Ensuring that the data is numeric
variables_of_interest <- as.data.frame(variables_of_interest)

# Converting the data frame to a numeric matrix
variables_of_interest <- as.matrix(variables_of_interest)

# Performing factor analysis using Principal Component Analysis (PCA)
factor_analysis_result <- psych::principal(variables_of_interest, nfactors = 5, rotate = "varimax")

# Printing the results of factor analysis
print(factor_analysis_result)

