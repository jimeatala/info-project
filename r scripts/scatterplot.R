dataset <- read.csv("https://query.data.world/s/x7qrjzoufcjzx6agzg5d6omncpzup7",
  header = TRUE, stringsAsFactors = FALSE
)
library(dplyr)
library(tidyverse)

colnames(dataset)
names(dataset)[names(dataset) == "SOC1"] <-
  "how much do you trust your neighborhood"
names(dataset)[names(dataset) == "SOC2A"] <-
  "talk with neighbor in month"
names(dataset)[names(dataset) == "SOC2B"] <-
  "talk with neighbor in month before covid"
names(dataset)[names(dataset) == "SOC3A"] <-
  "how often did you stay in touch with family/friends"
names(dataset)[names(dataset) == "SOC3B"] <-
  "how often did you stay in touch with family/friend before covid"
names(dataset)[names(dataset) == "SOC4A"] <-
  "did you volunteer this month"
names(dataset)[names(dataset) == "SOC4B"] <-
  "how often did you volunteer per month before covid"
names(dataset)[names(dataset) == "PHYS8"] <-
  "how would you rate your health"
names(dataset)[names(dataset) == "SOC5"] <-
  "in the past 7 days have you felt anxious/depressed/lonely/hopeless"
names(dataset)[names(dataset) == "GENDER"] <- "gender"
names(dataset)[names(dataset) == "RACETH"] <- "race"
names(dataset)[names(dataset) == "HHSIZE1"] <- "household size"

dataset2 <- dataset %>%
  select(
    `how much do you trust your neighborhood`:
    `how would you rate your health`, gender, race, RACE_R2, EDUCATION,
    `household size`, P_GEO
  )
names(dataset2)[names(dataset2) == "household size"] <- "household size"

chart3 <- dataset2 %>%
  filter(`how would you rate your health` != "(98) SKIPPED ON WEB") %>%
  filter(`household size` != "(99) REFUSED") %>%
  filter(`household size` != "(98) SKIPPED ON WEB")

chart3$`how would you rate your health` <-
  as.character(chart3$`how would you rate your health`)
chart3[chart3 == "(1) Excellent"] <- "Excellent"
chart3[chart3 == "(2) Very good"] <- "Very Good"
chart3[chart3 == "(3) Good"] <- "Good"
chart3[chart3 == "(4) Fair"] <- "Fair"
chart3[chart3 == "(5) Poor"] <- "Poor"
chart3[chart3 == "(77) DON'T KNOW"] <- "Don't Know"
chart3$`how would you rate your health` <-
  as.factor(chart3$`how would you rate your health`)

chart3$`household size` <- as.character(chart3$`household size`)
chart3[chart3 == "(1) One person, I live by myself"] <-
  "One person, I live by myself"
chart3[chart3 == "(2) Two persons"] <- "Two persons"
chart3[chart3 == "(3) Three persons"] <- "Three persons"
chart3[chart3 == "(4) Four persons"] <- "Four persons"
chart3[chart3 == "(5) Five persons"] <- "Five persons"
chart3[chart3 == "(6) Six or more persons"] <- "Six or more persons"
chart3$`household size` <- as.factor(chart3$`household size`)

scatter <- ggplot(data = chart3) +
  geom_count(mapping = aes(
    x = `how would you rate your health`,
    y = `household size`
  ))
