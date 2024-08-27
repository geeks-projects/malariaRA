## code to prepare `national_detail` dataset goes here

national_detail <- read_xlsx("data-raw/national_detail.xlsx")

usethis::use_data(national_detail, overwrite = TRUE)
