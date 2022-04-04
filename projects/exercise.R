library(httr)
library(jsonlite)
library(tidyverse)

url <- c("https://api.sheety.co/da1b6ab64e1c23b3399c5cc1bf0d8ec3/weeklyExercise/sheet1")

raw_data <- httr::GET(url)

content <- httr::content(raw_data, as = "text")

list <- fromJSON(content)

exercise <- list$sheet1 %>%
  janitor::clean_names()  %>%
  mutate(across(ends_with("lb") | ends_with("rep"), as.numeric))

ggplot(data = exercise, aes(x = date, y = bb_squat_lb)) +
  geom_point()
