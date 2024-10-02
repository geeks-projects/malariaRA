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

connect_ODK(svc_url_level = "District")

connect_ODK(svc_url_level = "National")
