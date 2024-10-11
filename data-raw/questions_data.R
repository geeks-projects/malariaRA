## code to prepare `questions_data` dataset goes here

library(readxl)

questions_data <- read_xlsx("data-raw/malaria_readiness_assessment_national_level.xlsx") |>
  select(name, label) |>
  slice(-(1:18)) |>
  filter(!(name  %in% c("starttime","endtime","today","readiness_assessment_checklist",
                        "malaria_intro","gps1", "level_supervision", "training","m_e","cold_chain_and_logistics", "advocacy_communication", "thank_you" )))

usethis::use_data(questions_data, overwrite = TRUE)
