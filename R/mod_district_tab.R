#' district_tab UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_district_tab_ui <- function(id){
  ns <- NS(id)
  tagList(
 
  )
}
    
#' district_tab Server Functions
#'
#' @noRd 
mod_district_tab_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
 
  })
}
    
## To be copied in the UI
# mod_district_tab_ui("district_tab_1")
    
## To be copied in the server
# mod_district_tab_server("district_tab_1")
