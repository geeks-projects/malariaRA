#' table_color_palette
#'
#' @description A utils function
#'
#' @return The return value, if any, from executing the utility.
#'
#' @noRd
#'
#'
#'

green_color <- "#0a9396"
red_color <- "#f07167"
orange_color <- "#fcbf49"
grey_colour <- "#777"

## National
pct_col_summary_national <- reactable::colDef(
  maxWidth = 60,
  class = "number",
  footer = function(value){
    if(!is.numeric(value)){paste("")}
    else{ paste0(sprintf("%.0f", mean(value,na.rm = T )),"%")}},

  cell = function(value){
    if(is.na(value)){paste("")}
    else{paste0(format(value, digits = 1, nsmall = 0), "%")}},

  style = function(value) {
    if(is.na(value)){ list(background = "#FFFFFF")}
    else{
      if (value >= 95) {
        color <- green_color
      } else if ( value >= 80 & value < 95) {
        color <- orange_color
      } else if ( value < 80 ) {
        color <- red_color
      } else {
        color <- grey_colour
      }
      list(background = color, color = "#FFFFFF", fontWeight = "bold")
    }
  }
)

## district
pct_col_summary_district <- reactable::colDef(
  maxWidth = 60,
  class = "number",
  footer = function(value){
    if(!is.numeric(value)){paste("")}
    else{ paste0(sprintf("%.0f", mean(value,na.rm = T )),"%")}},

  cell = function(value){
    if(is.na(value)){paste("")}
    else{paste0(format(value, digits = 1, nsmall = 0), "%")}},

  style = function(value) {
    if(is.na(value)){ list(background = "#FFFFFF")}
    else{
      if (value >= 80) {
        color <- green_color
      } else if (value < 80) {
        color <- red_color
      } else {
        color <- grey_colour
      }
      list(background = color, color = "#FFFFFF", fontWeight = "bold")
    }
  }
)


pct_col_detial <- reactable::colDef(
  maxWidth = 60,
  class = "number",
  #footer = function(value){
   # if(!is.character(value)){""}
  #  else{ value }},

  cell = function(value){
    if(is.na(value)){""}
    else{ value }},

  style = function(value) {
    if(is.na(value)){ list(background = "#FFFFFF")}
    else{
      if (value == "Yes") {
        color <- green_color
      } else if (value == "No") {
        color <- red_color
      } else {
        color <- grey_colour
      }
      list(background = color, color = "#FFFFFF", fontWeight = "bold")
    }
  }
)



filter_national_detail <- function(values, name) {
  tags$select(
    tags$option(value = "", "All"),
    purrr::map(unique(values), tags$option),
    onchange = glue::glue(
      "Reactable.setFilter(
        'national_detail_table', // Modify id again
        '{name}',
        event.target.value
      )"
    ),
    style = "width: 100%; height: 28px;" # Add this line
  )
}


filter_district_detail <- function(values, name) {
  tags$select(
    tags$option(value = "", "All"),
    purrr::map(unique(values), tags$option),
    onchange = glue::glue(
      "Reactable.setFilter(
        'district_detail_table', // Modify id again
        '{name}',
        event.target.value
      )"
    ),
    style = "width: 100%; height: 28px;" # Add this line
  )
}

pillar_style <- reactable::colDef(maxWidth = 150,
                                  align = "left",
                                  footer = "Score %",
                                  filterInput = filter_national_detail
)

pillar_style_district <- reactable::colDef(maxWidth = 150,
                                  align = "left",
                                  footer = "Score %",
                                  filterInput = filter_district_detail
)
