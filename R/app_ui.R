#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @import shiny bslib bsicons ggplot2 dplyr stringr forcats
#' @noRd
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # Your application UI logic
    fluidPage(
      mod_dashboard_heading_ui("dashboard_heading_1"),
      navset_card_underline(
        nav_panel("National", mod_national_tab_ui("national_tab_1")),

        nav_panel("District", tableOutput("summary")),

      )
    )
  )
}

#' Add external Resources to the Application
#'
#' This function is internally used to add external
#' resources inside the Shiny application.
#'
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function() {
  add_resource_path(
    "www",
    app_sys("app/www")
  )

  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys("app/www"),
      app_title = "malariaRA"

    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert()
  )
}
