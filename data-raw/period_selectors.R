## code to prepare `period_selectors` dataset goes here

library(readxl)

period_selectors <- read_xlsx("data-raw/period_selectors.xlsx", col_types = c("text", "text", "text"))


usethis::use_data(period_selectors, overwrite = TRUE)
