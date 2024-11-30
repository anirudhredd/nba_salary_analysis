library(readr)
library(dplyr)

# Loading the dataset
data <- read.csv("D:/UCD/BANA - Stats/Final Project/Book_Hypothesis.csv")

# List of columns to normalize
impact_columns <- c('Age', 'GP', 'GS', 'MP', 'FG', 'FGA', 'FG%', '3P', '3PA', '3P%', '2P', '2PA', '2P%', 
                    'eFG%', 'FT', 'FTA', 'FT%', 'ORB', 'DRB', 'TRB', 'AST', 'STL', 'BLK', 'TOV', 
                    'PF', 'PTS', 'Total Minutes', 'PER', 'TS%', '3PAr', 'FTr', 'ORB%', 'DRB%', 
                    'TRB%', 'AST%', 'STL%', 'BLK%', 'TOV%', 'USG%', 'OWS', 'DWS', 'WS', 'WS/48', 
                    'OBPM', 'DBPM', 'BPM', 'VORP')

# Normalizing the columns
data_normalized <- data
for (col in impact_columns) {
  # Check if the column is numeric
  if (is.numeric(data[[col]])) {
    max_value <- max(data[[col]], na.rm = TRUE)
    min_value <- min(data[[col]], na.rm = TRUE)
    range_value <- max_value - min_value
    # Prevent division by zero in case all values in a column are the same
    if (range_value > 0) {
      normalized_col_name <- paste0(col, "_norm")
      data_normalized[[normalized_col_name]] <- (data[[col]] - min_value) / range_value
    } else {
      warning(paste("Column", col, "has zero range. Normalization skipped."))
    }
  } else {
    warning(paste("Column", col, "is not numeric. Normalization skipped."))
  }
}

# Calculate 'Impact in Game'
normalized_columns <- paste0(impact_columns, "_norm")
existing_normalized_columns <- normalized_columns[normalized_columns %in% names(data_normalized)]

data_normalized$ImpactInGame <- rowMeans(data_normalized[existing_normalized_columns], na.rm = TRUE)

# View the normalized data
head(data_normalized)

# Save the updated dataset
write.csv(data_normalized, "D:/UCD/BANA - Stats/Final Project/Updated_Book_Hypothesis.csv", row.names = FALSE)
