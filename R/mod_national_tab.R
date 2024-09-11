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

    div(class = "card districtselect",
       HTML(

         '<div>
            <div class="poor-status-cricle"></div> <span class = "status" > Below 80%</span>
            <div class="mid-status-cricle"></div> <span class = "status" > 80% - 95%</span>
            <div class="good-status-cricle"></div> <span class = "status" > Above 95%</span>
        </div> '

       ),
    ),

    layout_columns(
      mod_valuebox_ui(id = "valuebox_1",  title = "Over all preparedness" ,
                      icon = "clipboard-data",  value = "60%"),

      mod_valuebox_ui(id = "valuebox_2",   title = "Number of districts ready",
                      icon = "hospital",  value = "70"),

      mod_valuebox_ui(id = "valuebox_3",  title = "Days left to the introduction",
                      icon = "calendar-event",  value = "120")),

    ## Row 2

    layout_column_wrap(
      width = 1/2,
      full_screen = F,
      card(class = "cardrow2",
        full_screen = TRUE, card_header("Overall Score (%) for Current timeline :"),
           plotOutput(ns("plot"))),

      card(class = "cardrow2",
        full_screen = TRUE, card_header("Score for over the timeline"),
           reactableOutput(ns("table")))
        #shiny::icon("circle-info"),
    ),

    ## Row 3

    card(class = "cardrow3",
      full_screen = TRUE,
      card_header("More details questions"),
      reactableOutput(ns("table1"))
      # layout_sidebar(
      #   fillable = TRUE,
      #   sidebar = sidebar(
      #     shiny::selectInput(ns("pillar"), label = "Select Pillar",
      #                        choices = str_to_sentence(national_summary$Pillar) |>
      #                          str_wrap(width = 15), selected = "1. Planning")
      #   ),
      #   reactableOutput(ns("table1"))
      # )
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


      plot_data <- national_summary |>
                  mutate(Pillar = str_to_sentence(Pillar)|> str_wrap(width = 15),
                         status = case_when(`9-7m` >= 95 ~ "good",
                                            `9-7m` >= 80 ~ "mid",
                                            .default = "poor"))

        ggplot(plot_data,aes(x = Pillar, y = `9-7m`, fill = status)) +
        geom_col(show.legend = F) +
        geom_label(aes(label = glue::glue("{`9-7m`}%"), fill = status),
                   color = "white", show.legend = F, fontface = "bold")+
        theme_classic() +
        scale_fill_manual(values = c("good" = green_color,
                                     "mid" = orange_color,
                                     "poor" = red_color))+
        scale_x_discrete(limits=rev)+
        coord_flip()

    })

    output$table <- renderReactable({

      national_summary |>
        reactable(
          pagination = FALSE,
          showSortIcon = FALSE,
          compact = TRUE,
          columns = list(
            Pillar = pillar_style,
            `9-7m` = pct_col_summary_national,
            `6-4m` = pct_col_summary_national,
            `3m` = pct_col_summary_national,
            `2m` = pct_col_summary_national,
            `1m` = pct_col_summary_national,
            `2wk` = pct_col_summary_national,
            `1wk` = pct_col_summary_national
            )
          )
      })

    output$table1 <- renderReactable({

      national_detail |>
        reactable(
          pagination = FALSE,
          showSortIcon = FALSE,
          compact = TRUE,
          columns = list(
            Pillar = pillar_style,
            `9-7m` = pct_col_detial,
            `6-4m` = pct_col_detial,
            `3m` = pct_col_detial,
            `2m` = pct_col_detial,
            `1m` = pct_col_detial,
            `2wk` = pct_col_detial,
            `1wk` = pct_col_detial
          ),
          filterable = T,
          elementId = "national_detail_table"
        )
    })

  })
}

## To be copied in the UI
# mod_national_tab_ui("national_tab_1")

## To be copied in the server
# mod_national_tab_server("national_tab_1")
