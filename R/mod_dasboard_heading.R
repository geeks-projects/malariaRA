#' dashboard_heading UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
#'
mod_dashboard_heading_ui <- function(id){
  ns <- NS(id)
  tagList(

    div(class = "mainHeader",
        img(class = "title-left-img", src = "www/Coat_of_arms_of_Uganda.svg",  height = 40, width = 80, alt="Uganda coat of arms", role="img"),
        div(class = "title-text-div",
            h6(class= "title-text", "Malaria Readiness Assessment"),
            h5(class= "title-text", "Dashboard")),
        img(class = "title-right-img", src = "www/unepi-logo.png",  height = 40, width = 80, alt="UNEPI Logo", role="img", align="center")
    )

  )
}

#' dashboard_heading Server Functions
#'
#' @noRd
mod_dashboard_heading_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

  })
}

## To be copied in the UI
# mod_dashboard_heading_ui("dashboard_heading_1")

## To be copied in the server
# mod_dashboard_heading_server("dashboard_heading_1")
