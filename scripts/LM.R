# Loading necessary libraries
library(readxl)
library(ggplot2)
library(car)# for VIF
library(lmtest)
# Loading the data
data <- read_excel("D:/UCD/BANA - Stats/Final Project/Regression_Book.xlsx")

#Full model
full_model <- lm(Salary ~ Age + `FG` + `FGA` + `2P` + `2PA` + `FT` + `FTA` + `TOV` + `PTS` + `USG%` + `Total Minutes` +`DWS`, data = data)
summary(full_model)

# Check for multicollinearity
vif(full_model)


# Reduced Model
vif_model <- vif(full_model)
high_vif <- names(vif_model[vif_model > 5])
high_vif

reduced_model <- lm(Salary ~ Age + `TOV` + `USG%` + `DWS`, data = data)

summary(reduced_model)

# Diagnostic Plots
par(mfrow = c(2, 2))
plot(full_model)
dw_result <- dwtest(full_model); dw_result
#for reduced model
par(mfrow = c(2, 2))
plot(reduced_model)
dw1_result <- dwtest(reduced_model); dw1_result

# Alternatively, create a Q-Q plot for residuals using ggplot2
residuals <- resid(full_model)
qqplot <- ggplot(data.frame(residuals), aes(sample = residuals)) +
  stat_qq() +
  stat_qq_line() +
  ggtitle("Q-Q Plot of Model Residuals")
print(qqplot)

# Residual vs Fitted

model_data <- data.frame(
  Fitted = fitted(full_model),
  Residuals = resid(full_model)
)

# Create the residuals vs fitted plot
ggplot(model_data, aes(x = Fitted, y = Residuals)) +
  geom_point() +
  geom_hline(yintercept = 0, linetype = "dashed", color = "red") +
  labs(x = "Fitted Values", y = "Residuals", title = "Residuals vs Fitted Plot") +
  theme_minimal()


# Create the Residuals vs Fitted plot for the log-transformed model
plot(fitted_values_log, residuals_log,
     xlab = "Fitted values",
     ylab = "Residuals",
     main = "Residuals vs Fitted for Log-Transformed Model")

abline(h = 0, col = "red")


#Log model
independent_vars <- c('Age', 'FG', 'FGA', '2P', '2PA', 'FT', 'FTA', 'TOV', 'PTS', 'USG%', 'Total Minutes', 'DWS')

# Log-transform the independent variables
# We add a small constant to each variable to avoid taking the log of zero or negative values
log_transformed_vars <- sapply(data[independent_vars], function(x) log(x + 1e-6))

# Replace the original columns with the log-transformed columns in the data
data[independent_vars] <- log_transformed_vars

# Transform 'Salary' with log for the model
data$Log_Salary <- log(data$Salary + 1e-6)

linear_model_log <- lm(Log_Salary ~ Age + `FG` + `FGA` + `2P` + `2PA` + `FT` + `FTA` + `TOV` + `PTS` + `USG%` + `Total Minutes` + `DWS`, data = data)
summary(linear_model_log)
vif(linear_model_log)

#Reduced log Model
vif_Logmodel <- vif(linear_model_log)
high_Logvif <- names(vif_Logmodel[vif_Logmodel > 5])
high_Logvif
reduced_linear_model_log <- lm(Log_Salary ~Age + `FGA` + `2P` + `2PA` + `TOV` + `USG%` + `DWS`, data = data)

summary(reduced_linear_model_log)

# Diagnostic Plots
par(mfrow = c(2, 2))
plot(linear_model_log)
dw_log_result <- dwtest(linear_model_log); dw_log_result
#for reduced model
par(mfrow = c(2, 2))
plot(reduced_linear_model_log)
dw1_log_result <- dwtest(reduced_linear_model_log); dw1_log_result
