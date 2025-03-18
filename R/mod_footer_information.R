#' footer_information UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
#' @importFrom htmltools HTML
mod_footer_information_ui <- function(id){
  ns <- NS(id)
  tagList(

    div(class="footer",
        #img(class = "logo-img", src = "www/Gavi-logo.svg", height = 80, width = 100, alt="Gavi logo", role="img"),
        img(class = "logo-img", src = "www/Gavi-logo.png", height = 35, width = 100, alt="Gavi logo", role="img"),
        img(class = "logo-img", src = "www/WHO-logo.svg", height = 45, width = 100, alt="AFENET logo", role="img"),
        img(class = "logo-img", src = "www/PATH-logo.png", height = 30, width = 100, alt="AFENET logo", role="img"),
        img(class = "logo-img", src = "www/Coat_of_arms_of_Uganda.svg", height = 45, width = 100, alt="ncdc logo", role="img"),
        img(class = "logo-img", src = "www/AFENET-Logo.png", height = 42, width = 100, alt="AFENET logo", role="img"),
        img(class = "logo-img", src = "www/Malaria_Consortium-logo.svg", height = 42, width = 100, alt="Malaria Consortium logo", role="img"),
        img(class = "logo-img", src = "www/UNICEF-logo.svg", height = 42, width = 100, alt="UNICEF logo", role="img"),
        img(class = "logo-img", src = "www/CDC-logo.svg", height = 45, width = 100, alt="AFENET logo", role="img")
    )

  )
}

#' footer_information Server Functions
#'
#' @noRd
mod_footer_information_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

  })
}

## To be copied in the UI
# mod_footer_information_ui("footer_information_1")

## To be copied in the server
# mod_footer_information_server("footer_information_1")
