## code to prepare `national_placeholder` dataset goes here

library(readxl)

national_placeholder <- read_xlsx("data-raw/national_placeholder.xlsx")


usethis::use_data(national_placeholder, overwrite = TRUE)
