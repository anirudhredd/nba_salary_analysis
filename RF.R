# Loading necessary libraries
library(readxl)
library(randomForest)
library(caret)

# Loading the data
data <- read_excel("D:/UCD/BANA - Stats/Final Project/Regression_Book.xlsx")
independent_vars <- c('Age', 'FG', 'FGA', '2P', '2PA', 'FT', 'FTA', 'TOV', 'PTS', 'USG%', 'Total Minutes', 'DWS')
X <- as.matrix(data[independent_vars])
y <- as.numeric(data[['Salary']])  # Ensuring y is a numeric vector
set.seed(42)  # Setting seed for reproducibility
train_index <- createDataPartition(y, p = 0.8, list = FALSE)
X_train <- X[train_index, ]
y_train <- y[train_index]

# Training the Random Forest Regressor
random_forest_model <- randomForest(X_train, y_train, ntree = 500)

# Evaluating the model
print(random_forest_model)
# Determining feature importance
importance(random_forest_model)
# Plotting variable importance
varImpPlot(random_forest_model)

# Comparing regression models graphically
model_names <- c('Linear Full Model', 'Reduced Model', 'Linear Log Model', 'Linear Reduced Log Model', 'Random Forest Model')
r_squared <- c(0.6649, 0.6182, 0.6878, 0.5773, 0.7376)

# Creating a bar plot for R-squared values
barplot(r_squared, names.arg = model_names, las = 2, col = rainbow(length(r_squared)),
        main = "R-squared Values for Different Models",
        xlab = "Model", ylab = "R-squared Value")
