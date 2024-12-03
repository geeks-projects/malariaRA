#' district_tab UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
#' @importFrom shinyWidgets pickerInput
mod_district_tab_ui <- function(id){
  ns <- NS(id)
  tagList(


    div(class = "card districtselect",
        pickerInput( ns("district"), label = NULL, width = "100%",
                     choices = c("All Districts", ugandan_map |> sf::st_drop_geometry() |> dplyr::pull(District), multiple = F, selected = "All Districts",
                                 options = list(title = "districts",`actions-box` = TRUE,size = 10,`selected-text-format` = "count > 2")))

        #    )
    ),
    div(class = "card districtselect",
        HTML(

          '<div>
            <div class="poor-status-cricle"></div> <span class = "status" > Below 80%</span>
            <div class="good-status-cricle"></div> <span class = "status" > Above 80%</span>
        </div> '

        ),
    ),


    layout_columns(
      mod_valuebox_ui(id = "valuebox_1",  title = "Over all preparedness" ,
                      icon = "clipboard-data",  value = "60%"),

      mod_valuebox_ui(id = "valuebox_2",   title = "Number of districts ready",
                      icon = "hospital",  value = "70"),

      mod_valuebox_ui(id = "valuebox_3",  title = "Days left to the introduction",
                      icon = "calendar-event",
                      value = difftime(ymd('20250425'), today(), units="days",tz = "Africa/Kampala"))),
    ## Row select-district

     # card(class = "carddistrict",
     #      full_screen = F,
     #      card_header("Select a district"),

       # selectInput(inputId = "district", label = NULL,width = "100%",
       #              choices = c("All districts", ugandan_map |> sf::st_drop_geometry() |> dplyr::pull(District), multiple = F, selected = "All districts")),



                                ## Row 2

    layout_column_wrap(
      width = 1/2,
      full_screen = F,
      card(class = "cardrow2",
           full_screen = TRUE, card_header("Map of Uganda"),
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

#' district_tab Server Functions
#'
#' @noRd
mod_district_tab_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    output$plot <- renderPlot({
      # district_summary |>
      #   mutate(Pillar = str_to_sentence(Pillar) |>
     # ggplot(ugandan_map)

      district_selected <- reactive({input$district})

      if(district_selected() == "All Districts"){

        ggplot() +
          geom_sf(data = ugandan_map, fill = "#e6e3e3",
                  #aes(group = District),
                  color = "white",
                  linetype = 1)+
          theme_void()
        # geom_sf(data = ug_geodata |> filter(District == "Kampala"), aes(group = District),
        #         color = "black",
        #         linetype = 1) +
        #   #scale_fill_gradient(low = "#e6e3e3", high = "#D83F31")+
        #   geom_sf_text( data = ug_geodata |> filter(District == "Kampala"),
        #                 aes(label = District, NULL),
        #                 size = 3.3, colour = "black")+
        #   theme_void()
      }else{


        ggplot() +
          geom_sf(data = ugandan_map, fill = "#e6e3e3", color = "white",linetype = 1)+
          geom_sf(data =  ugandan_map[ugandan_map$District == district_selected(), ], fill = "#e6e3e3",
                  color = "black", linetype = 1)+
          geom_sf_text(data =  ugandan_map[ugandan_map$District == district_selected(), ],
                       aes(label = District), size = 3.3, colour = "black", hjust = -0.3)+
          theme_void()
        }


    })

    output$table <- renderReactable({

      district_summary |>
        reactable(
          pagination = FALSE,
          bordered = T,
          showSortIcon = FALSE,
          compact = TRUE,
          columns = list(
            Pillar = pillar_style_district,
            `3m` = pct_col_summary_district,
            `2m` = pct_col_summary_district,
            `1m` = pct_col_summary_district,
            `2wk` = pct_col_summary_district,
            `1wk` = pct_col_summary_district
          )
        )
    })

    output$table1 <- renderReactable({

      district_detail |>
        reactable(
          pagination = FALSE,
          bordered = T,
          showSortIcon = FALSE,
          compact = TRUE,
          columns = list(
            Pillar = pillar_style_district,
            `3m` = pct_col_detial,
            `2m` = pct_col_detial,
            `1m` = pct_col_detial,
            `2wk` = pct_col_detial,
            `1wk` = pct_col_detial
          ),
          filterable = T,
          elementId = "district_detail_table"
        )
    })

  })
}

## To be copied in the UI
# mod_district_tab_ui("district_tab_1")

## To be copied in the server
# mod_district_tab_server("district_tab_1")
