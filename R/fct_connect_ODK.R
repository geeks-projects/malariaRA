#' connect_ODK
#'
#' @import ruODK
#' @description A fct function to connect to connect the ODK server
#'
#' @return The return value, if any, from executing the function.
#'
#' @noRd
#'
#'

# connect_ODK <- function(svc_url_level = c("District", "National")) {
#
#   if(svc_url_level == "National") {
#
#     ruODK::ru_setup(
#       svc = Sys.getenv("SVC_URL_National"),
#       un = Sys.getenv("ODKC_UN"),
#       pw = Sys.getenv("ODKC_PW"),
#       tz = "Africa/Kampala",
#       verbose = F # great for demo or debugging
#       )
#
#   }else if(svc_url_level == "District"){
#
#     ruODK::ru_setup(
#       svc = Sys.getenv("SVC_URL_District"),
#       un = Sys.getenv("ODKC_UN"),
#       pw = Sys.getenv("ODKC_PW"),
#       tz = "Africa/Kampala",
#       verbose = F # great for demo or debugging
#     )
#
#
#   }
#
#   client<-  ruODK::odata_submission_get()
#   tibble::as_tibble(client)
# }
#
# #connect_ODK(svc_url_level = "District")
#
# national_data <- connect_ODK(svc_url_level = "National")
#
# ################ Planning ######################
#
# national_planning_activities <- c( "political_commitment", "operational_plan_develop", "intro_budget_reviewed", "additional_funds_mobilized",
#                                           "malaria_vaccine_deli_strategy", "ntwg_established", "twg_has_tor", "gavi_vaccine_intro_grant_rec",
#                                           "briefing_with_twg_moh_partners_held", "gavi_additional_ta_confirm", "funds_available_to_district","micro_plan_developed" )
#
# national_planning_activities_6months <- c( "political_commitment", "additional_funds_mobilized", "ntwg_established", "twg_has_tor", "gavi_vaccine_intro_grant_rec",
#                                     "funds_available_to_district","micro_plan_developed" )
#
# ################ Training ######################
# national_training_activities <- c("training_plan_and_materials_developed", "training_materials_distributed",
#                                          "training_trainers_carried_out_at_national_subnational_level", "training_of_hw_chv_supervisors_carried_out" )
#
# national_training_activities_6months <- c("training_plan_and_materials_developed", "training_materials_distributed",
#                                   "training_trainers_carried_out_at_national_subnational_level" )
#
# ################ M & E ######################
# national_m_e_activities <- c("monitoring_indicators_dev_reviewed",
#                                     "monitoring_tools_updated_with_malaria",
#                                     "monitoring_tools_printed_distributed_to_hf",
#                                     "pre_intro_supervisory_visits_conducted"  )
# national_m_e_activities_6months <- c("monitoring_indicators_dev_reviewed",
#                              "monitoring_tools_updated_with_malaria" )
#
#
# ################ Cold Chain and Logistics ######################
# national_cold_chain_and_logistics_activities <- c("vaccine_licensure_granted_by_nra",
#                                                          "confirmation_of_vacc_delivery_date_received",
#                                                           "integration_available",
#                                                           "coldchain_assessment_completed",
#                                                           "waste_mgt_assessment_completed",
#                                                           "tracking_vaccine_supply_mgt_in_place",
#                                                           "vaccine_injection_supply_rec_distributed" )
#
# national_cold_chain_and_logistics_activities_6months <- c("vaccine_licensure_granted_by_nra",
#                                                   "confirmation_of_vacc_delivery_date_received",
#                                                   "integration_available",
#                                                   "coldchain_assessment_completed",
#                                                   "waste_mgt_assessment_completed")
#
# ################ Advocacy and communication ######################
# national_advocacy_communication_activities <- c("budgeted_national_plan_4_acsm_developed_and_finalized",
#                                                        "acsm_materials_developed_validated_and_translated",
#                                                        "risk_comm_mgt_plan_developed",
#                                                        "comm_plan_implemented",
#                                                        "acsm_materials_distributed_to_hf_comm",
#                                                        "launch_ceremony_planned")
#
# national_advocacy_communication_activities_6months <- c("risk_comm_mgt_plan_developed",
#                                                          "comm_plan_implemented",
#                                                          "acsm_materials_distributed_to_hf_comm",
#                                                          "launch_ceremony_planned" )
#
#
#
# ################ All 6 months ######################
# activities_6months <- c(national_planning_activities_6months,
#                         national_training_activities_6months,
#                         national_m_e_activities_6months,
#                         national_cold_chain_and_logistics_activities_6months,
#                         national_advocacy_communication_activities_6months )
#
#
#
#
# national_data_summary <- national_data |>
#   filter(time_of_assessment == "6 Months") |>
#   select(-c(c(starttime:start_date_activity), c(level_supervision:planning_coordination),
#             c(training,m_e,cold_chain_and_logistics, advocacy_communication, thank_you),
#             c(meta_instance_id:odata_context )) ) |>
#   select(all_of(activities_6months)) |>
#   tidyr::pivot_longer(political_commitment:launch_ceremony_planned,
#                       names_to = "critical_activities",
#                       values_to = "status"
#                       ) |>
#   mutate(pillar = case_when(critical_activities %in% national_planning_activities ~ "planning",
#                             critical_activities %in% national_training_activities ~ "training",
#                             critical_activities %in% national_m_e_activities ~ "m_e",
#                             critical_activities %in% national_cold_chain_and_logistics_activities ~ "cold_chain_and_logistics",
#                             critical_activities %in% national_advocacy_communication_activities ~ "advocacy_communication",
#                             .default = NULL)) |>
#    mutate(status = case_when(status == "yes" ~ TRUE,
#                              status == "no" ~ FALSE,
#                              .default = FALSE)) |>
#    group_by(pillar) |>
#    summarise(n = sum(status)) |>
#    mutate(score_denominator_6months = case_when(pillar == "planning" ~ 7,
#                                                 pillar == "training" ~ 3,
#                                                 pillar == "m_e" ~ 2,
#                                                 pillar == "cold_chain_and_logistics" ~ 5,
#                                                 pillar == "advocacy_communication" ~ 4,
#                                                 .default = NULL
#                                                 )) |>
#    mutate(score = round((n/score_denominator_6months)*100, 1))
#
# national_data_summary




