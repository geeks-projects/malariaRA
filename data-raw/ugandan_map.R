## code to prepare `ugandan_map` dataset goes here

library(tidyverse)
library(ggspatial)
library(glue)
library(sf)


ugandan_map <- sf::read_sf("./data-raw/uganda_districts/") |>
  st_as_sf() |>
  mutate(District = str_to_title(District),
         District = str_replace(District, "Madi Okollo", "Madi-Okollo"),
         District = str_replace(District, "Kassnda", "Kassanda"),
         District = str_replace(District, "Ssembabule", "Sembabule"),
         District = str_replace(District, "Namutunmba", "Namutumba"))


usethis::use_data(ugandan_map, overwrite = TRUE)
