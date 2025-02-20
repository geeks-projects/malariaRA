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
                     choices = c(target_districts),
                     multiple = F, selected = "All Districts",
                     options = list(title = "districts",`actions-box` = TRUE,size = 10,`selected-text-format` = "count > 2", `live-search` = TRUE)
                     )

        #    )
    ),
    div(class = "card districtselect",
        HTML(

          '<div>
            <div class="poor-status-cricle"></div> <span class = "status" > Below 80%</span>
            <div class="good-status-cricle"></div> <span class = "status" > Above 80%</span>
        </div> '

        ),

        div(class = "last_updated_div",
            glue::glue("Last Updated: {last_updated_district }")
        )
    ),


    layout_columns(
      mod_valuebox_ui(id = "valuebox_1",  title = "Over all preparedness" ,
                      icon = "clipboard-data",
                      value = textOutput(outputId = ns("district_preparedness_value"))
                        #glue::glue("{round(district_summary_score()[1,assessment_period_district])}%")
                      ),

      mod_valuebox_ui(id = "valuebox_2",   title = "Number of districts ready",
                      icon = "hospital",  value = textOutput(outputId = ns("districts_ready"))),

      mod_valuebox_ui(id = "valuebox_3",  title = "Days left to the introduction",
                      icon = "calendar-event",
                      value = difftime(ymd('20250401'), today(), units="days",tz = "Africa/Kampala"))),
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
    ),
    card(class = "cardrow4",
         full_screen = FALSE,
         card_header("Credits"),
         mod_footer_information_ui("footer_information_1")
    )
  )
}

#' district_tab Server Functions
#'
#' @noRd
mod_district_tab_server <- function(id, district){

  moduleServer( id, function(input, output, session){
    ns <- session$ns

    ### Clean district data #####

    district_selected <- reactive({input$district})

    district_data_selected <-  reactive({

      district_data_cleaner(data = district_essential,
                            district_selected_pra = district_selected())

      # district_selected <- district_data_cleaner(data = district_essential,
      #                       district_selected_pra = "Mukono")
      })


##########
    district_summary <- reactive({


      switch( assessment_period_district,
              "3m"      = {
                district_summary_fn(district_data_clean = district_data_selected(), assessment_period = "3m") |>
                  mutate(`3m` = round((`3m` /`3m_den`)*100, 1),
                         .keep = "unused") |>
                  district_summary_last_part()},

              "2m"      = {
                district_summary_fn(district_data_clean = district_data_selected(), assessment_period = "2m") |>
                  mutate(`3m` = round((`3m` /`3m_den`)*100, 1),
                         `2m` = round((`2m` /`2m_den`)*100, 1),
                         .keep = "unused") |>
                  district_summary_last_part()},
              "1m"      = {
                district_summary_fn(district_data_clean = district_data_selected(), assessment_period = "1m") |>
                  mutate(`3m` = round((`3m` /`3m_den`)*100, 1),
                         `2m` = round((`2m` /`2m_den`)*100, 1),
                         `1m` = round((`1m` /`1m_den`)*100, 1),
                         .keep = "unused") |>
                  district_summary_last_part()},
              "2wk"      = {
                district_summary_fn(district_data_clean = district_data_selected(), assessment_period = "2wk") |>
                  mutate(`3m` = round((`3m` /`3m_den`)*100, 1),
                         `2m` = round((`2m` /`2m_den`)*100, 1),
                         `1m` = round((`1m` /`1m_den`)*100, 1),
                         `2wk` = round((`2wk` /`2wk_den`)*100, 1),
                         .keep = "unused") |>
                  district_summary_last_part()},
              "1wk"      = {
                district_summary_fn(district_data_clean = district_data_selected(), assessment_period = "1wk") |>
                  mutate(`3m` = round((`3m` /`3m_den`)*100, 1),
                         `2m` = round((`2m` /`2m_den`)*100, 1),
                         `1m` = round((`1m` /`1m_den`)*100, 1),
                         `2wk` = round((`2wk` /`2wk_den`)*100, 1),
                         `1wk` = round((`1wk` /`1wk_den`)*100, 1),
                         .keep = "unused") |>
                  district_summary_last_part()}
      )
    })

#################
    district_summary_score <- reactive({

      district_summary() |>
        summarise(pillar = "Score",
                  across(where(is.numeric),\(x) mean(x, na.rm = TRUE)))
    })

################

    ugandan_map_selected <- reactive({


      ugandan_map |> left_join(district_summary_score()[,c("district",assessment_period_district)] |>
                                                       mutate(assessment_period_district = district_summary_score()[[assessment_period_district]] ),
                                                     by = c("District" = "district")) |>
      mutate(overall = case_when(assessment_period_district < 80 ~ "Below",
                                 assessment_period_district <= 100 ~ "Above",
                                 .default = "Missing"))
})


    output$districts_ready <- renderText({

      district_summary_score()[,c("district",assessment_period_district)] |>
        mutate(ready = case_when(`3m` < 80 ~ FALSE,
                                 `3m` >= 80 ~ TRUE,
                                 .default = FALSE
        )) |> pull(ready) |> sum()

    })


#############
    output$plot <- renderPlot({
#
#       if(district_selected() == "All Districts"){
#
#         ggplot(ugandan_map_selected()) +
#           geom_sf(data =  ugandan_map_selected(), aes(fill = overall),
#                   color = "white", linetype = 1, show.legend = F)+
#           scale_fill_manual(values = c("Below" = red_color, "Above" = green_color, "Missing" =  "#e6e3e3"))+
#           theme_void()
#
#
#       }else{

        ggplot(ugandan_map_selected()) +
          geom_sf(data = ugandan_map_selected(), aes(fill = overall), color = "white",linetype = 1, show.legend = F)+
          geom_sf(data =  ugandan_map_selected()[ugandan_map$District == district_selected(), ],
                  aes(fill = overall), color = "black", linetype = 1, show.legend = F)+
          scale_fill_manual(values = c("Below" = red_color, "Above" = green_color, "Missing" =  "#e6e3e3"))+
          geom_sf_text(data =  ugandan_map_selected()[ugandan_map$District == district_selected(), ],
                       aes(label = District), size = 3.3, colour = "black", hjust = -0.3)+
          theme_void()
    #    }


    })



    ################
    output$district_preparedness_value <- renderText({

      glue::glue("{round(district_summary_score()[1,assessment_period_district])}%")

    })

    #############

    output$table <- renderReactable({


      ### district Summary ######

####################
      district_summary() |>
        reactable::reactable(
          pagination = FALSE,
          bordered = T,
          showSortIcon = FALSE,
          compact = TRUE,
          columns = list(
            pillar = pillar_style_district,
            `3m` = pct_col_summary_district,
            `2m` = pct_col_summary_district,
            `1m` = pct_col_summary_district,
            `2wk` = pct_col_summary_district,
            `1wk` = pct_col_summary_district
          )
        )
    })

    output$table1 <- renderReactable({


      district_detail <- district_data_selected() |>
        tidyr::pivot_wider(names_from = time_of_assessment, values_from = status) |>
        left_join(y = district_placeholder |> mutate(across(`3m`: `1wk`, ~ "Zero"))) |>
        select(c(district, pillar, label,`3m`, `2m`, `1m`, `2wk`, `1wk`)) |>
        rename("Pillar" = pillar, "District" = district,
               "Critical activities (desired timeframe for completion shaded light yellow)" = label) |>
        #mutate(across(`12-10m`: `1wk`, str_to_title)) |>
        filter(Pillar != "others")


      district_detail |>
        reactable(
          pagination = FALSE,
          bordered = T,
          showSortIcon = FALSE,
          compact = TRUE,
          columns = list(
            District = pillar_style_district,
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
