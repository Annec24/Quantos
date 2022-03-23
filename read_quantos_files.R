# Read and process quantos excel files into a tibble and write to a csv file.


# Load libraries
library(readr)
library(readxl)
library(purrr)
library(dplyr)



# Quantos data directory path
dir_path <- "H:/Quantos/quantos"

files <- dir(path=dir_path, recursive = TRUE, full.names=TRUE, pattern = "*.xls")

# Use possibly() to replace bad files with NULL, then compact() to remove nulls
# This produces a bunch of warnings about data types. Suspect weird data in some spreadsheets
quantos_data <- files |>
  map(possibly(read_xls, otherwise = NULL),
      col_names = c("timestamp", "pos", "mass", "valid"), 
      col_types = c("date", "numeric", "numeric", "text")) |> 
  compact() |>
  reduce(bind_rows)

# write to a csv for later use
write_csv(quantos_data, "data/quantos_data.csv")
