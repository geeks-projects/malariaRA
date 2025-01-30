
################ Planning ######################

district_planning_activities_3m <- c("1_1", "1_2", "1_3", "1_4", "1_5", "1_6")

district_planning_activities_2m <-  c("1_2", "1_3", "1_4", "1_5", "1_6")

district_planning_activities_1m <- c("1_3", "1_5", "1_6")

district_planning_activities_2wk <- c()

district_planning_activities_1wk <- c()

################ Training ######################

district_training_activities_3m <- c()

district_training_activities_2m <- c("2_1", "2_2", "2_3")

district_training_activities_1m <- c("2_1", "2_2", "2_3")

district_training_activities_2wk <- c("2_1", "2_2", "2_3")

district_training_activities_1wk <- c()


################ M & E ######################

district_m_e_activities_3m <- c("3_1", "3_2")

district_m_e_activities_2m <- c("3_1", "3_2", "3_3")

district_m_e_activities_1m <- c("3_1", "3_3")

district_m_e_activities_2wk <- c()

district_m_e_activities_1wk <- c()



################ Cold Chain and Logistics ######################

district_cold_chain_and_logistics_activities_3m <- c( "4_1", "4_2")

district_cold_chain_and_logistics_activities_2m <- c("4_2")

district_cold_chain_and_logistics_activities_1m <- c("4_4a", "4_4b", "4_4c", "4_4d", "4_4e" )

district_cold_chain_and_logistics_activities_2wk <- c()

district_cold_chain_and_logistics_activities_1wk <- c()
################ Advocacy and communication ######################


district_advocacy_communication_activities_3m <- c("5_1", "5_2")

district_advocacy_communication_activities_2m <- c("5_1", "5_2")

district_advocacy_communication_activities_1m <-  c("5_1", "5_2", "5_3")

district_advocacy_communication_activities_2wk <- c()

district_advocacy_communication_activities_1wk <- c()


##############
district_activities_3m <- c(district_planning_activities_3m,
                   district_training_activities_3m,
                   district_m_e_activities_3m,
                   district_cold_chain_and_logistics_activities_3m,
                   district_advocacy_communication_activities_3m )

district_activities_2m <- c(district_planning_activities_2m,
                   district_training_activities_2m,
                   district_m_e_activities_2m,
                   district_cold_chain_and_logistics_activities_2m,
                   district_advocacy_communication_activities_2m )

district_activities_1m <- c(district_planning_activities_1m,
                   district_training_activities_1m,
                   district_m_e_activities_1m,
                   district_cold_chain_and_logistics_activities_1m,
                   district_advocacy_communication_activities_1m )

district_activities_2wk <- c(district_planning_activities_2wk,
                    district_training_activities_2wk,
                    district_m_e_activities_2wk,
                    district_cold_chain_and_logistics_activities_2wk,
                    district_advocacy_communication_activities_2wk )

district_activities_1wk <- c(district_planning_activities_1wk,
                    district_training_activities_1wk,
                    district_m_e_activities_1wk,
                    district_cold_chain_and_logistics_activities_1wk,
                    district_advocacy_communication_activities_1wk )

########### data cleaning

data(ODKtoDB_district)
data(questions_district)
data(district_placeholder)
data(period_selectors_district)
data(district_summary_denominator)

assessment_period_district <- ODKtoDB_district$time_of_assessment[1]

last_updated_district <- as.Date(ODKtoDB_district$endtime[1])


#' district_data_cleaner
#'
#' @description A fct function to clean ODK data district data
#'
#' @return The return value, if any, from executing the function.
#'
#' @noRd
#'
#'

#uuid:c8124cce-1332-4b87-b2e5-7e2e08a83a74
district_data_cleaner <- function(data, district_selected_pra){
  data |>
    filter(district == district_selected_pra) |>
    select(-c(region, district)) |>
    tidyr::pivot_longer(operational_plan_develop_1_1:community_awareness_verified_5_3,
                        names_to = "critical_activities",
                        values_to = "status") |>
    mutate(status = str_to_title(status)) |>
    right_join(y = questions_district, by = c("critical_activities" = "name")) |>
    select(-critical_activities)
}


#' district_summary_fn
#'
#' @import dplyr
#' @description A fct function to summaries detial district data
#'
#' @return The return value, if any, from executing the function.
#'
#' @noRd
#'
#'

district_summary_fn <- function(district_data_clean, assessment_period =  c( "3m", "2m", "1m", "2wk", "1wk")) {

  columns_needed <-  period_selectors_district  |>
    filter(selected == assessment_period) |> dplyr::pull(needed)

  district_data_clean |>
    filter(time_of_assessment %in% columns_needed) |>
    mutate(status = case_when(status == "Yes" ~ TRUE,
                              status == "No" ~ FALSE,
                              .default = FALSE)) |>
    group_by(time_of_assessment, pillar) |>
    summarise(n = sum(status)) |>
    filter(!(pillar == "others" | is.na(time_of_assessment ))) |>
    tidyr::pivot_wider(names_from = time_of_assessment, values_from = n) |>
    left_join(y = district_summary_denominator |> select(all_of(c("pillar", columns_needed))),
              by = c("pillar" = "pillar"), suffix = c("", "_den"))
}

#' district_summary_last_part
#'
#' @import dplyr
#' @importFrom dplyr select
#' @description A fct function to organses district data
#'
#' @return The return value, if any, from executing the function.
#'
#' @noRd
#'
#'



district_summary_last_part <- function(data){
  data |>
    left_join(y = district_placeholder) |>
    dplyr::select(c(pillar, `3m`, `2m`, `1m`, `2wk`, `1wk`))
}
##### Essential data ###########

ODKtoDB_district_essential_clean <- ODKtoDB_district |>
  dplyr::select(-c(c(starttime:gps1) , c(level_supervision:other_agency),,
                   c(planning_coordination, training,m_e,cold_chain_and_logistics, district_level_on_track_intro_malaria,overall_comments, advocacy_communication, thank_you),
                   c(meta_instance_id:odata_context )) ) |>
  mutate(region = str_to_title(region),
         district = str_to_title(district))



district_essential_3m <- ODKtoDB_district_essential_clean |>
  filter( time_of_assessment == "3m" ) |>
  mutate(case_when(
    time_of_assessment == "3m" ~ across(!c(time_of_assessment,region, district, ends_with(district_activities_3m)), ~ NA)
  ))


district_essential_2m <- ODKtoDB_district_essential_clean |>
  filter( time_of_assessment == "2m" ) |>
  mutate(case_when(
    time_of_assessment == "2m" ~ across(!c(time_of_assessment, region, district, ends_with(district_activities_2m)), ~ NA)
  ))

district_essential_1m <- ODKtoDB_district_essential_clean |>
  filter( time_of_assessment == "1m" ) |>
  mutate(case_when(
    time_of_assessment == "1m" ~ across(!c(time_of_assessment, region, district, ends_with(district_activities_1m)), ~ NA)
  ))

district_essential_2wk <- ODKtoDB_district_essential_clean |>
  filter( time_of_assessment == "2wk" ) |>
  mutate(case_when(
    time_of_assessment == "2wk" ~ across(!c(time_of_assessment, region, district, ends_with(district_activities_2wk)), ~ NA)
  ))

# district_essential_1wk <- ODKtoDB_district_essential_clean |>
#   filter( time_of_assessment == "1wk" ) |>
#   mutate(case_when(
#      time_of_assessment == "1wk" ~ across(!c(time_of_assessment, ends_with(district_activities_1wk)), ~ NA)
#   ))


district_essential <- bind_rows(district_essential_3m|> mutate(across(everything(), as.character)),
                                district_essential_2m |> mutate(across(everything(), as.character)),
                                district_essential_1m|> mutate(across(everything(), as.character)),
                                district_essential_2wk|> mutate(across(everything(), as.character)))

### Clean district data #####

# district_data_clean <-  district_essential |>
#   district_data_cleaner(district = "Kampala")

### district detail. ##########
# district_detail <- district_data_clean |>
#   tidyr::pivot_wider(names_from = time_of_assessment, values_from = status) |>
#   left_join(y = district_placeholder |> mutate(across(`3m`: `1wk`, ~ "Zero"))) |>
#   select(c(pillar, label,`3m`, `2m`, `1m`, `2wk`, `1wk`)) |>
#   rename("Pillar" = pillar,
#          "Critical activities (desired timeframe for completion shaded light yellow)" = label) |>
#   #mutate(across(`12-10m`: `1wk`, str_to_title)) |>
#   filter(Pillar != "others")



####



# ### district Summary #######
#
# district_summary <- switch(
#   assessment_period_district,
#   "3m"      = {
#     district_summary_fn(district_data_clean = district_data_clean, assessment_period = "3m") |>
#       mutate(`3m` = round((`3m` /`3m_den`)*100, 1),
#              .keep = "unused") |>
#       district_summary_last_part()},
#
#   "2m"      = {
#     district_summary_fn(district_data_clean = district_data_clean, assessment_period = "2m") |>
#       mutate(`3m` = round((`3m` /`3m_den`)*100, 1),
#              `2m` = round((`2m` /`2m_den`)*100, 1),
#              .keep = "unused") |>
#       district_summary_last_part()},
#   "1m"      = {
#     district_summary_fn(district_data_clean = district_data_clean, assessment_period = "1m") |>
#       mutate(`3m` = round((`3m` /`3m_den`)*100, 1),
#              `2m` = round((`2m` /`2m_den`)*100, 1),
#              `1m` = round((`1m` /`1m_den`)*100, 1),
#              .keep = "unused") |>
#       district_summary_last_part()},
#   "2wk"      = {
#     district_summary_fn(district_data_clean = district_data_clean, assessment_period = "2wk") |>
#       mutate(`3m` = round((`3m` /`3m_den`)*100, 1),
#              `2m` = round((`2m` /`2m_den`)*100, 1),
#              `1m` = round((`1m` /`1m_den`)*100, 1),
#              `2wk` = round((`2wk` /`2wk_den`)*100, 1),
#              .keep = "unused") |>
#       district_summary_last_part()},
#   "1wk"      = {
#     district_summary_fn(district_data_clean = district_data_clean, assessment_period = "3m") |>
#       mutate(`3m` = round((`3m` /`3m_den`)*100, 1),
#              `2m` = round((`2m` /`2m_den`)*100, 1),
#              `1m` = round((`1m` /`1m_den`)*100, 1),
#              `2wk` = round((`2wk` /`2wk_den`)*100, 1),
#              `1wk` = round((`1wk` /`1wk_den`)*100, 1),
#              .keep = "unused") |>
#       district_summary_last_part()}
# )


# district_summary_score <- district_summary |>
#   summarise(pillar = "Score",
#             across(where(is.numeric),\(x) mean(x, na.rm = TRUE)))




