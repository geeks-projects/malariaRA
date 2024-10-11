#' valuebox UI Function
#'
#' @description A shiny Module.
#'
#' @param id,title,icon,value,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_valuebox_ui <- function(id, title , icon, value ){
  ns <- NS(id)
  tagList(

    value_box(class = "singlevaluebox",
              title = title, value = value, theme = value_box_theme(
                bg = "#FFFFFF",
                fg = "#191919"
              ), showcase = bsicons::bs_icon(icon),
              showcase_layout = "left center", full_screen = FALSE, fill = TRUE,
              height = NULL
    )

  )
}

#' valuebox Server Functions
#'
#' @noRd
mod_valuebox_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

  })
}

## To be copied in the UI
# mod_valuebox_ui("valuebox_1", id, title , icon,  value)

## To be copied in the server
# mod_valuebox_server("valuebox_1")
