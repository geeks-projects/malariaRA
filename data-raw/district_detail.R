## code to prepare `district_detail` dataset goes here

district_detail <- read_xlsx("data-raw/district_detail.xlsx")

usethis::use_data(district_detail, overwrite = TRUE)
