## code to prepare `district_placeholder` dataset goes here

library(readxl)

district_placeholder <- read_xlsx("data-raw/district_placeholder.xlsx")

usethis::use_data(district_placeholder, overwrite = TRUE)
