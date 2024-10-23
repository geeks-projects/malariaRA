## code to prepare `national_summary_denominator` dataset goes here

library(readxl)
national_summary_denominator <- read_xlsx("data-raw/national_denominator.xlsx")

usethis::use_data(national_summary_denominator, overwrite = TRUE)

