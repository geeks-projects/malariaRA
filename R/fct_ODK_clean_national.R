
################ Planning ######################
national_planning_activities_12_10m <- c("1_1", "1_2", "1_3", "1_4", "1_5", "1_6", "1_7", "1_8", "1_9", "1_10", "1_13", "1_14")

national_planning_activities_9_7m <- c("1_1", "1_3", "1_4", "1_5", "1_6", "1_7", "1_8", "1_9", "1_10", "1_12",  "1_13", "1_14")

national_planning_activities_6_4m <- c("1_1", "1_4", "1_6", "1_7", "1_8", "1_11", "1_12", "1_14")

national_planning_activities_3m <- c("1_11", "1_12",  "1_14", "1_15")

national_planning_activities_2m <-  c("1_11", "1_12", "1_14",  "1_15", "1_16")

national_planning_activities_1m <- c("1_11", "1_12", "1_14",  "1_15", "1_16")

national_planning_activities_2wk <- c("1_14", "1_16")

national_planning_activities_1wk <- c("1_14", "1_16")

################ Training ######################
national_training_activities_12_10m <- c()

national_training_activities_9_7m <- c("2_1")

national_training_activities_6_4m <- c("2_1", "2_2", "2_3")

national_training_activities_3m <- c("2_3", "2_4")

national_training_activities_2m <- c("2_3", "2_4")

national_training_activities_1m <- c("2_3", "2_4")

national_training_activities_2wk <- c("2_4")

national_training_activities_1wk <- c()


################ M & E ######################
national_m_e_activities_12_10m <- c()

national_m_e_activities_9_7m<- c("3_1", "3_2")

national_m_e_activities_6_4m <- c("3_1", "3_2")

national_m_e_activities_3m <- c("3_2", "3_3", "3_4")

national_m_e_activities_2m <- c("3_2", "3_3", "3_4")

national_m_e_activities_1m <- c("3_2", "3_3", "3_4")

national_m_e_activities_2wk <- c()

national_m_e_activities_1wk <- c()



################ Cold Chain and Logistics ######################
national_cold_chain_and_logistics_activities_12_10m <- c("4_1", "4_2", "4_3")

national_cold_chain_and_logistics_activities_9_7m <- c("4_1", "4_2", "4_3", "4_4", "4_5")

national_cold_chain_and_logistics_activities_6_4m <- c("4_1", "4_2", "4_3", "4_4", "4_5")

national_cold_chain_and_logistics_activities_3m <- c( "4_6", "4_7")

national_cold_chain_and_logistics_activities_2m <- c( "4_6", "4_7")

national_cold_chain_and_logistics_activities_1m <- c( "4_6", "4_7")

national_cold_chain_and_logistics_activities_2wk <- c()

national_cold_chain_and_logistics_activities_1wk <- c()
################ Advocacy and communication ######################

national_advocacy_communication_activities_12_10m <- c()

national_advocacy_communication_activities_9_7m <- c("5_1", "5_2", "5_3", "5_4")

national_advocacy_communication_activities_6_4m <- c("5_3", "5_4", "5_5", "5_6")

national_advocacy_communication_activities_3m <- c("5_4", "5_5", "5_6")

national_advocacy_communication_activities_2m <- c("5_4", "5_5", "5_6")

national_advocacy_communication_activities_1m <-  c("5_4", "5_5", "5_6")

national_advocacy_communication_activities_2wk <- c()

national_advocacy_communication_activities_1wk <- c()


################ All 6 months ######################


activities_12_10m <- c(national_planning_activities_12_10m,
                       national_training_activities_12_10m,
                       national_m_e_activities_12_10m,
                       national_cold_chain_and_logistics_activities_12_10m,
                       national_advocacy_communication_activities_12_10m )


activities_9_7m <- c(national_planning_activities_9_7m,
                     national_training_activities_9_7m,
                     national_m_e_activities_9_7m,
                     national_cold_chain_and_logistics_activities_9_7m,
                     national_advocacy_communication_activities_9_7m )

activities_6_4m <- c(national_planning_activities_6_4m,
                     national_training_activities_6_4m,
                     national_m_e_activities_6_4m,
                     national_cold_chain_and_logistics_activities_6_4m,
                     national_advocacy_communication_activities_6_4m )

activities_3m <- c(national_planning_activities_3m,
                   national_training_activities_3m,
                   national_m_e_activities_3m,
                   national_cold_chain_and_logistics_activities_3m,
                   national_advocacy_communication_activities_3m )

activities_2m <- c(national_planning_activities_2m,
                   national_training_activities_2m,
                   national_m_e_activities_2m,
                   national_cold_chain_and_logistics_activities_2m,
                   national_advocacy_communication_activities_2m )

activities_1m <- c(national_planning_activities_1m,
                   national_training_activities_1m,
                   national_m_e_activities_1m,
                   national_cold_chain_and_logistics_activities_1m,
                   national_advocacy_communication_activities_1m )
activities_2wk <- c(national_planning_activities_2wk,
                    national_training_activities_2wk,
                    national_m_e_activities_2wk,
                    national_cold_chain_and_logistics_activities_2wk,
                    national_advocacy_communication_activities_2wk )

activities_1wk <- c(national_planning_activities_1wk,
                    national_training_activities_1wk,
                    national_m_e_activities_1wk,
                    national_cold_chain_and_logistics_activities_1wk,
                    national_advocacy_communication_activities_1wk )


data(ODKtoDB_national)
data(questions_national)
data(national_placeholder)
data(period_selectors)
data(national_summary_denominator)

#assessment_period <- ODKtoDB_national$time_of_assessment[1]
assessment_period <- "1m"

last_updated <- as.Date(ODKtoDB_national$endtime[1])


#' national_data_cleaner
#'
#' @description A fct function to clean ODK data national data
#'
#' @return The return value, if any, from executing the function.
#'
#' @noRd
#'
#'


national_data_cleaner <- function(data){
    data |>
    tidyr::pivot_longer(political_commitment_1_1:launch_ceremony_planned_5_6,
                        names_to = "critical_activities",
                        values_to = "status") |>
    mutate(status = str_to_title(status)) |>
    right_join(y = questions_national, by = c("critical_activities" = "name")) |>
    select(-critical_activities)
}


#' national_summary_fn
#'
#' @import dplyr
#' @description A fct function to summaries detial national data
#'
#' @return The return value, if any, from executing the function.
#'
#' @noRd
#'
#'

national_summary_fn <- function(assessment_period = c("12-10m", "9-7m", "6-4m", "3m", "2m", "1m", "2wk", "1wk")) {

  columns_needed <-  period_selectors |>
    filter(selected == assessment_period) |> dplyr::pull(needed)

  national_data_clean |>
    filter(time_of_assessment %in% columns_needed) |>
    mutate(status = case_when(status == "Yes" ~ TRUE,
                              status == "No" ~ FALSE,
                              .default = FALSE)) |>
    group_by(time_of_assessment, pillar) |>
    summarise(n = sum(status)) |>
    filter(!(pillar == "others" | is.na(time_of_assessment ))) |>
    tidyr::pivot_wider(names_from = time_of_assessment, values_from = n) |>
    left_join(y = national_summary_denominator |> select(all_of(c("pillar", columns_needed))),
              by = c("pillar" = "pillar"), suffix = c("", "_den"))
}

#' national_summary_last_part
#'
#' @import dplyr
#' @importFrom dplyr select
#' @description A fct function to organses national data
#'
#' @return The return value, if any, from executing the function.
#'
#' @noRd
#'
#'



national_summary_last_part <- function(data){
  data |>
    left_join(y = national_placeholder) |>
    dplyr::select(c(pillar, `12-10m`,`9-7m`, `6-4m`, `3m`, `2m`, `1m`, `2wk`, `1wk`))
}
##### Essential data ###########

ODKtoDB_national_essential_clean <- ODKtoDB_national |>
  dplyr::select(-c(c(starttime:start_date_activity), c(level_supervision:planning_coordination),
            c(training,m_e,cold_chain_and_logistics, national_level_on_track_intro_malaria,overall_comments, advocacy_communication, thank_you),
            c(meta_instance_id:odata_context )) )


national_essential_12_10m <- ODKtoDB_national_essential_clean |>
  filter( time_of_assessment == "12-10m" ) |>
  mutate(case_when(
    time_of_assessment == "12-10m" ~ across(!c(time_of_assessment, ends_with(activities_12_10m)), ~ NA)
  ))


national_essential_9_7m <- ODKtoDB_national_essential_clean |>
  filter( time_of_assessment == "9-7m" ) |>
  mutate(case_when(
    time_of_assessment == "9-7m" ~ across(!c(time_of_assessment, ends_with(activities_9_7m)), ~ NA)
  ))

national_essential_6_4m <- ODKtoDB_national_essential_clean |>
  filter( time_of_assessment == "6-4m" ) |>
  mutate(case_when(
    time_of_assessment == "6-4m" ~ across(!c(time_of_assessment, ends_with(activities_6_4m)), ~ NA)
  ))


national_essential_3m <- ODKtoDB_national_essential_clean |>
  filter( time_of_assessment == "3m" ) |>
  mutate(case_when(
    time_of_assessment == "3m" ~ across(!c(time_of_assessment, ends_with(activities_3m)), ~ NA)
  ))


national_essential_2m <- ODKtoDB_national_essential_clean |>
  filter( time_of_assessment == "2m" ) |>
  mutate(case_when(
    time_of_assessment == "2m" ~ across(!c(time_of_assessment, ends_with(activities_2m)), ~ NA)
  ))

national_essential_1m <- ODKtoDB_national_essential_clean |>
  filter( time_of_assessment == "1m" ) |>
  mutate(case_when(
    time_of_assessment == "1m" ~ across(!c(time_of_assessment, ends_with(activities_1m)), ~ NA)
  ))

national_essential_2wk <- ODKtoDB_national_essential_clean |>
  filter( time_of_assessment == "2wk" ) |>
  mutate(case_when(
    time_of_assessment == "2wk" ~ across(!c(time_of_assessment, ends_with(activities_2wk)), ~ NA)
  ))

# national_essential_1wk <- ODKtoDB_national_essential_clean |>
#   filter( time_of_assessment == "1wk" ) |>
#   mutate(case_when(
#      time_of_assessment == "1wk" ~ across(!c(time_of_assessment, ends_with(activities_1wk)), ~ NA)
#   ))


national_essential <- bind_rows(national_essential_12_10m |> mutate(across(everything(), as.character)),
                                 national_essential_9_7m |> mutate(across(everything(), as.character)),
                                 national_essential_6_4m |> mutate(across(everything(), as.character)),
                                 national_essential_3m|> mutate(across(everything(), as.character)),
                                 national_essential_2m |> mutate(across(everything(), as.character)),
                                 national_essential_1m|> mutate(across(everything(), as.character)),
                                 national_essential_2wk|> mutate(across(everything(), as.character)))


### National detail. ##########
national_detail <- national_essential |>
  national_data_cleaner() |>
  pivot_wider(names_from = time_of_assessment, values_from = status) |>
  left_join(y = national_placeholder |> mutate(across(`12-10m`: `1wk`, ~ "Zero"))
            ) |>
  select(c(pillar, label, `12-10m`,`9-7m`, `6-4m`, `3m`, `2m`, `1m`, `2wk`, `1wk`)) |>
  rename("Pillar" = pillar,
         "Critical activities (desired timeframe for completion shaded light yellow)" = label) |>
  #mutate(across(`12-10m`: `1wk`, str_to_title)) |>
  filter(Pillar != "others")



####



### National Summary #######


national_data_clean <-  national_essential |>
  national_data_cleaner()

national_summary <- switch(
  assessment_period,
  "6-4m"  = {
    national_summary_fn(assessment_period = "6-4m") |>
      mutate(`12-10m` = round((`12-10m` /`12-10m_den`)*100, 1),
             `9-7m` = round((`9-7m` /`9-7m_den`)*100, 1),
             `6-4m` = round((`6-4m` /`6-4m_den`)*100, 1),
             .keep = "unused") |>
      national_summary_last_part()},
  "3m"      = {
    national_summary_fn(assessment_period = "3m") |>
      mutate(`12-10m` = round((`12-10m` /`12-10m_den`)*100, 1),
             `9-7m` = round((`9-7m` /`9-7m_den`)*100, 1),
             `6-4m` = round((`6-4m` /`6-4m_den`)*100, 1),
             `3m` = round((`3m` /`3m_den`)*100, 1),
             .keep = "unused") |>
      national_summary_last_part()},
  "2m"      = {
    national_summary_fn(assessment_period = "2m") |>
      mutate(`12-10m` = round((`12-10m` /`12-10m_den`)*100, 1),
             `9-7m` = round((`9-7m` /`9-7m_den`)*100, 1),
             `6-4m` = round((`6-4m` /`6-4m_den`)*100, 1),
             `3m` = round((`3m` /`3m_den`)*100, 1),
             `2m` = round((`2m` /`2m_den`)*100, 1),
             .keep = "unused") |>
      national_summary_last_part()},
  "1m"      = {
    national_summary_fn(assessment_period = "1m") |>
      mutate(`12-10m` = round((`12-10m` /`12-10m_den`)*100, 1),
             `9-7m` = round((`9-7m` /`9-7m_den`)*100, 1),
             `6-4m` = round((`6-4m` /`6-4m_den`)*100, 1),
             `3m` = round((`3m` /`3m_den`)*100, 1),
             `2m` = round((`2m` /`2m_den`)*100, 1),
             `1m` = round((`1m` /`1m_den`)*100, 1),
             .keep = "unused") |>
      national_summary_last_part()},
  "2wk"      = {
    national_summary_fn(assessment_period = "2wk") |>
      mutate(`12-10m` = round((`12-10m` /`12-10m_den`)*100, 1),
             `9-7m` = round((`9-7m` /`9-7m_den`)*100, 1),
             `6-4m` = round((`6-4m` /`6-4m_den`)*100, 1),
             `3m` = round((`3m` /`3m_den`)*100, 1),
             `2m` = round((`2m` /`2m_den`)*100, 1),
             `1m` = round((`1m` /`1m_den`)*100, 1),
             `2wk` = round((`2wk` /`2wk_den`)*100, 1),
             .keep = "unused") |>
      national_summary_last_part()},
  "1wk"      = {
    national_summary_fn(assessment_period = "1wk") |>
      mutate(`12-10m` = round((`12-10m` /`12-10m_den`)*100, 1),
             `9-7m` = round((`9-7m` /`9-7m_den`)*100, 1),
             `6-4m` = round((`6-4m` /`6-4m_den`)*100, 1),
             `3m` = round((`3m` /`3m_den`)*100, 1),
             `2m` = round((`2m` /`2m_den`)*100, 1),
             `1m` = round((`1m` /`1m_den`)*100, 1),
             `2wk` = round((`2wk` /`2wk_den`)*100, 1),
             `1wk` = round((`1wk` /`1wk_den`)*100, 1),
             .keep = "unused") |>
      national_summary_last_part()},
  {
    national_summary_fn(assessment_period = "6-4m") |>
      mutate(`12-10m` = round((`12-10m` /`12-10m_den`)*100, 1),
             `9-7m` = round((`9-7m` /`9-7m_den`)*100, 1),
             `6-4m` = round((`6-4m` /`6-4m_den`)*100, 1),
             .keep = "unused") |>
      national_summary_last_part()}
)


national_summary_score <- national_summary |>
  summarise(pillar = "Score",
            across(where(is.numeric),\(x) mean(x, na.rm = TRUE)))


