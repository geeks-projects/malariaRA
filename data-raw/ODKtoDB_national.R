## code to prepare `ODKtoDB_national` dataset goes here
library(ruODK)
library(tidyverse)
connect_ODK <- function(svc_url_level = c("District", "National")) {

  if(svc_url_level == "National") {

    ruODK::ru_setup(
      svc = Sys.getenv("SVC_URL_National"),
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

ODKtoDB_national <- connect_ODK(svc_url_level = "National") |>
  filter(!(time_of_assessment =="6-4m" & start_date_activity == "2024-12-06 03:00:00"))

# ODKtoDB_national  %>%
# filter(!(time_of_assessment =="6-4m" & start_date_activity == "2024-12-06 03:00:00")) |>
#   arrange(time_of_assessment) |>
#   select(time_of_assessment, 	start_date_activity)


usethis::use_data(ODKtoDB_national, overwrite = TRUE)
