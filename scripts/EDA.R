# Installing necessary packages
install.packages("readxl")
install.packages("psych")
install.packages("ggplot2")
install.packages("dplyr")
install.packages("corrplot")


# Loading necessary libraries
library(corrplot)
library(readxl)
library(psych)
library(ggplot2)
library(dplyr)

# Loading the NBA data from an Excel file
Nba_data <- read_excel("/Users/nikhil/Downloads/Nba_clean.xlsx")

# Checking for missing values across columns
colSums(is.na(Nba_data))

# Summarizing the salary for the 2022/23 season
Sal_23 <- Nba_data$`2022/23`
summary(Sal_23)

# Plotting the salary distribution for the 2022/23 season using a histogram
ggplot(Nba_data, aes(x = `2022/23`)) + 
  geom_histogram(bins = 30, fill = "steelblue", color = "black") +
  scale_x_continuous(labels = scales::comma) + 
  labs(title = "Salary Distribution for 2022/23 Season",
       x = "Salary", y = "Frequency") +
  theme_minimal()

# Plotting the salary distribution for the 2022/23 season using a boxplot
ggplot(Nba_data, aes(y = `2022/23`)) +
  geom_boxplot(fill = "steelblue", color = "black") +
  scale_y_continuous(labels = scales::comma) +
  labs(title = "Salary Distribution for 2022/23 Season",
       y = "Salary") +
  theme_minimal()

# Plotting a scatter plot of Salary against Points for the 2022/23 season
ggplot(Nba_data, aes(x = PTS, y = `2022/23`, color = PTS)) +
  geom_point() +
  geom_smooth(method = "lm", color = "red") +
  scale_color_gradient(low = "blue", high = "red") +
  labs(title = "Scatter Plot of Salary and Points",
       x = "Points", y = "Salary for 2022/23") +
  theme_minimal()

# Plotting Salary by Age for the 2022/23 season
ggplot(Nba_data, aes(x=Age, y=`2022/23`)) +
  geom_point(aes(color=Position), alpha=0.6) +
  geom_smooth(method="lm", se=FALSE, color="red") +
  scale_y_continuous(labels = scales::comma) +
  xlab("Age") +
  ylab("Salary") +
  ggtitle("Salary by Age for 2022/23 Season")

# Calculating and plotting the average salary by team for the 2022/23 season
average_salary_by_team <- aggregate(`2022/23` ~ Team, data = Nba_data, FUN = mean, na.rm = TRUE)
average_salary_by_team$Team <- trimws(average_salary_by_team$Team)  # Removing any leading/trailing whitespace
barplot(average_salary_by_team$`2022/23`, names.arg = average_salary_by_team$Team,
        main = "Average Salary by Team for 2022/23 Season", xlab = "Team", ylab = "Average Salary",
        las = 2, col = "darkgreen", ylim = c(0, max(average_salary_by_team$`2022/23`, na.rm = TRUE)),
        yaxt = 'n')  # Customizing Y axis
axis(2, at = axTicks(2), labels = format(axTicks(2), scientific = FALSE))  # Formatting Y axis labels

# Analyzing the correlation between various performance metrics and salary
performance_data <- Nba_data[, c('2022/23', 'PTS', 'AST', 'TRB', 'Age', 'MP')]
cor_matrix <- cor(performance_data, use = "pairwise.complete.obs")
corrplot(cor_matrix, method = "circle")  # Visualizing the correlation matrix
