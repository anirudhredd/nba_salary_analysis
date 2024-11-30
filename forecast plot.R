library(readxl)
library(forecast)
library(dplyr)
library(ggplot2)

# Loading the dataset
data <- read_excel("/Users/nikhil/Downloads/Nba_Forecast.xlsx")

# Identifying the top 10 players by the latest salary
top_players <- data %>%
  arrange(desc(`2022/23`)) %>%
  head(10)

# Initializing an empty data frame for storing combined historical and forecasted salaries
combined_salaries <- data.frame(PlayerName = character(), Year = integer(), Salary = numeric(), Type = character())

# Looping through the top players to perform forecasting
for (player_name in top_players$`Player Name`) {
  # Extracting the salary time series for the player in the correct order
  player_salaries <- data %>%
    filter(`Player Name` == player_name) %>%
    select(`2019/20`, `2020/21`, `2021/22`, `2022/23`) %>%
    unlist(use.names = FALSE) %>%
    as.numeric()
  
  # Converting salaries to a time series object
  player_ts <- ts(player_salaries, start = 2019, frequency = 1)
  
  # Fitting an ARIMA model and forecasting the next year's salary
  model <- auto.arima(player_ts)
  player_forecast <- forecast(model, h = 1)
  
  # Combining actual and forecasted values for plotting
  years <- seq(from = start(player_ts)[1], to = end(player_ts)[1] + 1, by = 1)
  values <- c(player_ts, player_forecast$mean)
  player_data <- data.frame(PlayerName = player_name, Year = years, Salary = values, 
                            Type = c(rep("Actual", length(player_ts)), "Forecast"))
  
  # Merging the individual player's data into the main data frame
  combined_salaries <- rbind(combined_salaries, player_data)
}

# Creating a line plot for historical and forecasted salaries
ggplot(combined_salaries, aes(x = Year, y = Salary, group = PlayerName, color = PlayerName)) +
  geom_line() +
  geom_point() +
  scale_y_continuous(limits = c(25000000, 50000000)) +  # Setting the y-axis limits
  theme_minimal() +
  labs(title = "Historical and Forecasted Salaries for Top NBA Players",
       x = "Year", y = "Salary (USD)") +
  theme(legend.position = "bottom")

