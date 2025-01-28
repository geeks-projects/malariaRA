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
       div(class = "last_updated_div",
           glue::glue("Last Updated: {last_updated}")
       )
    ),

    layout_columns(
      mod_valuebox_ui(id = "valuebox_1",  title = "Over all preparedness" ,
                      icon = "clipboard-data",  value = glue::glue("{round(national_summary_score[1,assessment_period])}%")),

      mod_valuebox_ui(id = "valuebox_2",   title = "Number of targeted districts",
                      icon = "hospital",  value = "106"),

      mod_valuebox_ui(id = "valuebox_3",  title = "Days left to the introduction",
                      icon = "calendar-event",
                      value = difftime(ymd('20250401'), today(), units="days",tz = "Africa/Kampala"))),

    ## Row 2

    layout_column_wrap(
      width = 1/2,
      full_screen = F,
      card(class = "cardrow2",
        full_screen = TRUE, card_header(glue::glue("Overall Score (%) for Current timeline :{assessment_period}")),
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

      national_summary_df <- national_summary |>
        select(pillar, {{assessment_period}})

      colnames(national_summary_df) <- c("pillar", "score")


      plot_data <- national_summary_df |>
                  mutate(pillar = str_to_sentence(pillar)|> str_wrap(width = 15),
                         status = case_when(score >= 95 ~ "good",
                                            score >= 80 ~ "mid",
                                            .default = "poor"))

        ggplot(plot_data,aes(x = pillar, y = score, fill = status)) +
        geom_col(show.legend = F) +
        geom_label(aes(label = glue::glue("{round(score)}%"), fill = status),
                   color = "white", show.legend = F, fontface = "bold")+
        theme_classic() +
        scale_fill_manual(values = c("good" = green_color,
                                     "mid" = orange_color,
                                     "poor" = red_color))+
        scale_x_discrete(limits=rev)+
        coord_flip()+
          labs(x = "Pillar",
               y = "Score")

    })


    output$table <- renderReactable({

      national_summary |>
        reactable(
          pagination = FALSE,
          bordered = T,
          showSortIcon = FALSE,
          compact = TRUE,
          columns = list(
            pillar = pillar_style,
            `12-10m` = pct_col_summary_national,
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
          bordered = T,
          compact = TRUE,
          columns = list(
            Pillar = pillar_style,
            `12-10m` = pct_col_detial,
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
