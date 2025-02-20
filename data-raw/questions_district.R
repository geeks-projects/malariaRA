## code to prepare `questions_district` dataset goes here

library(readxl)
library(dplyr)
library(stringr)

questions_district <- read_xlsx("data-raw/Malaria Readiness Assessment_District.xlsx") |>
  select(name, label) |>
  slice(-(1:18)) |>
  filter(!(name  %in% c("starttime","endtime","today","readiness_assessment_checklist",
                        "malaria_intro","gps1", "level_supervision", "planning_coordination", "training","m_e",
                        "cold_chain_and_logistics","vaccines_mgt_supplied", "advocacy_communication", "thank_you"))) |>
  mutate(name = str_replace(name , "\\.", "_")) |>
  mutate(pillar = case_when(str_starts(label, pattern = "1") ~ "1. PLANNING",
                            str_starts(label, pattern = "2") ~ "2. TRAINING",
                            str_starts(label, pattern = "3") ~ "3. MONITORING & SUPERVISION",
                            str_starts(label, pattern = "4") ~ "4. VACCINE, COLD CHAIN & LOGISTICS",
                            str_starts(label, pattern = "5") ~ "5. ADVOCACY, SOCIAL MOBILIZATION & COMMUNICATION",
                            .default = "others"
  ))


usethis::use_data(questions_district, overwrite = TRUE)
