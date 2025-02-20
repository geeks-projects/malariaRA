## code to prepare `district_summary_denominator` dataset goes here

library(readxl)
district_summary_denominator <- read_xlsx("data-raw/district_denominator.xlsx")


usethis::use_data(district_summary_denominator, overwrite = TRUE)
