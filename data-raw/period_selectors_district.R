## code to prepare `period_selectors_district` dataset goes here


library(readxl)

period_selectors_district <- read_xlsx("data-raw/period_selectors_district.xlsx", col_types = c("text", "text", "text"))

usethis::use_data(period_selectors_district, overwrite = TRUE)
