## code to prepare `ODKtoDB_district` dataset goes here

library(ruODK)
library(tidyverse)
connect_ODK <- function(svc_url_level = c("District", "District")) {

  if(svc_url_level == "District") {

    ruODK::ru_setup(
      svc = Sys.getenv("SVC_URL_District"),
      un = Sys.getenv("ODKC_UN"),
      pw = Sys.getenv("ODKC_PW"),
      tz = "Africa/Kampala",
      verbose = F # great for demo or debugging
    )

  }else if(svc_url_level == "District"){

    ruODK::ru_setup(
      svc = Sys.getenv("SVC_URL_District"),
      un = Sys.getenv("ODKC_UN"),
      pw = Sys.getenv("ODKC_PW"),
      tz = "Africa/Kampala",
      verbose = F # great for demo or debugging
    )


  }

  client<-  ruODK::odata_submission_get()
  tibble::as_tibble(client)
}

#connect_ODK(svc_url_level = "District")

ODKtoDB_district_1m <- connect_ODK(svc_url_level = "District") |>
  filter(system_form_version != "V9") |>
  filter(!(district =="Kayunga" & name_supervisor == "Albert")) |>
  filter(!(district =="Bundibugyo" & date_of_visits == "2025-03-07 03:00:00")) |>
  mutate(district = ifelse(name_supervisor == "R.Mugaba Frank", "Napak", district)) |>
  #filter(!(district =="Moroto" & name_supervisor == "Dr.Mugabe Frank")) |>
  mutate(district = case_when(district == "Jinja_City" ~ "Jinja City",
                              district == "Lira_City" ~ "Lira City",
                              district == "Soroti_City" ~ "Soroti City",
                              district == "Gulu_City" ~ "Gulu City",
                              district == "Madi_Okollo" ~ "Madi-Okollo",
                              district == "Arua_City" ~ "Arua City",
                              district == "Mbale_City" ~ "Mbale City",
                              district == "Masaka_City" ~ "Masaka City",
                              .default = as.character(district)))



ODKtoDB_district_1m |>
  group_by(district) %>%
  filter(n()>1) |>
  select(district, name_supervisor, date_of_visits)
#
# ODKtoDB_district_1m |>
#   group_by(district) |>
#   summarise(district, name_supervisor, n = n()) |>
#   filter(n >1) |>
#   select(district, name_supervisor, date_of_visits)


ODKtoDB_district_3m <-  ODKtoDB_district_1m |> mutate(time_of_assessment = "3m")
ODKtoDB_district_2m <-  ODKtoDB_district_1m |> mutate(time_of_assessment = "2m")

ODKtoDB_district <- bind_rows(ODKtoDB_district_1m, ODKtoDB_district_2m, ODKtoDB_district_3m)

# ODKtoDB_district_names <- names(ODKtoDB_district_1m)
#
# ODKtoDB_district_2m <- rep(NA, 65)
# ODKtoDB_district_3m <- rep(NA, 65)
#
# #names(ODKtoDB_district_2m)  <-  ODKtoDB_district_names
#
#  data.frame(ODKtoDB_district_names,
#             ODKtoDB_district_2m,
#             ODKtoDB_district_3m) |>
#    as.tibble() |> View()
#    mutate(ODKtoDB_district_2m= if_else(ODKtoDB_district_names == ))
#
#
# colnames(ODKtoDB_district_2m) <- c("cols", "ODKtoDB_district_2m")

usethis::use_data(ODKtoDB_district, overwrite = TRUE)
