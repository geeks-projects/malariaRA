#' national_tab UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_national_tab_ui <- function(id){
  ns <- NS(id)
  tagList(

    layout_columns(
      value_box(class = "singlevaluebox",
        title = "Over all preparedness", value = "60%", theme = value_box_theme(
          bg = "#FFFFFF",
          fg = "#191919"
        ), showcase = bsicons::bs_icon("clipboard-data"),
        showcase_layout = "left center", full_screen = FALSE, fill = TRUE,
        height = NULL
      ),
      value_box(class = "singlevaluebox",
        title = "Number of districts ready", value = "60",
        theme = value_box_theme(bg = "#FFFFFF", fg = "#191919"),
        showcase = bsicons::bs_icon("hospital"), showcase_layout = "left center",
        full_screen = FALSE, fill = TRUE, height = NULL
      ),
      value_box(class = "singlevaluebox",
        title = "Days left to the introduction", value = "120",
        theme = value_box_theme(bg = "#FFFFFF", fg = "#191919"),
        showcase = bsicons::bs_icon("calendar-event"), showcase_layout = "left center",
        full_screen = FALSE, fill = TRUE, height = NULL
      )
    ),

    ## Row 2

    layout_column_wrap(
      width = 1/2,
      height = 350,
      full_screen = F,
      card(class = "cardrow2",
        full_screen = TRUE, card_header("Overall Score (%) for Current timeline :"),
           plotOutput(ns("plot"))),
      card(class = "cardrow2",
        full_screen = TRUE, card_header("Score for over the timeline"),
           tableOutput(ns("table")))
        #shiny::icon("circle-info"),
    ),

    ## Row 3

    card(class = "cardrow3",
      height = 300,
      full_screen = TRUE,
      card_header("More details questions"),
      layout_sidebar(
        fillable = TRUE,
        sidebar = sidebar(
          shiny::selectInput(ns("pillar"), label = "Select Pillar",
                             choices = str_to_sentence(national_summary$Pillar) |>
                               str_wrap(width = 15), selected = "1. Planning")
        ),
        tableOutput(ns("table1"))
      )
    )



  )
}

#' national_tab Server Functions
#'
#' @noRd
mod_national_tab_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    output$plot <- renderPlot({
      national_summary |>
        mutate(Pillar = str_to_sentence(Pillar) |>
                 str_wrap(width = 15)) |>
        ggplot() +
        geom_col(aes(x = Pillar, y = `9-7m`), fill = "#00b4d8") +
        theme_classic() +
        #scale_x_reverse()+
        coord_flip()

    })

    output$table <- renderTable({

      national_summary
    })

    output$table1 <- renderTable({

      national_detail
    })

  })
}

## To be copied in the UI
# mod_national_tab_ui("national_tab_1")

## To be copied in the server
# mod_national_tab_server("national_tab_1")
