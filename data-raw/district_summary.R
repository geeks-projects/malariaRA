## code to prepare `district_summary` dataset goes here
district_summary <- read_xlsx("data-raw/district_summary.xlsx")

usethis::use_data(district_summary, overwrite = TRUE)
