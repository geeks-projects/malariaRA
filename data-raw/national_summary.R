## code to prepare `national_summary` dataset goes here
library(readxl)
national_summary <- read_xlsx("data-raw/national_summary.xlsx")

usethis::use_data(national_summary , overwrite = TRUE)
