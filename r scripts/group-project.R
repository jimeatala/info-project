dataset <- read.csv("https://query.data.world/s/x7qrjzoufcjzx6agzg5d6omncpzup7",
  header = TRUE, stringsAsFactors = FALSE
)
library(dplyr)
library(ggplot2)
library(tidyverse)

colnames(dataset)
names(dataset)[names(dataset) == "SOC1"] <-
  "how much do you trust your neighborhood"
names(dataset)[names(dataset) == "SOC2A"] <- "talk with neighbor in month"
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
names(dataset2)[names(dataset2) == "household size"] <- "household_size"
dataset2 <- dataset %>%
  select(
    `how much do you trust your neighborhood`:
    `how would you rate your health`, gender, race, RACE_R2, EDUCATION,
    `household size`, P_GEO
  )

chart3 <- dataset2 %>%
  filter(`how would you rate your health` != "(98) SKIPPED ON WEB") %>%
  filter(`household size` != "(99) REFUSED") %>%
  filter(`household size` != "(98) SKIPPED ON WEB")

One_person_excellent <- chart3 %>%
  filter(`how would you rate your health` == "(1) Excellent") %>%
  filter(`household size` == "(1) One person, I live by myself") %>%
  summarise(`household size`, `how would you rate your health`)
nrow(One_person_excellent)

num_female_Excellent <- dataset2 %>%
  filter(gender == "(2) Female") %>%
  filter(`how would you rate your health` == "(1) Excellent")
nrow(num_female_Excellent)

num_male_Excellent <- dataset2 %>%
  filter(gender == "(1) Male") %>%
  filter(`how would you rate your health` == "(1) Excellent")
nrow(num_male_Excellent)

Contant_before_covid <- dataset2 %>%
  filter(`how often did you stay in touch with family/friend before covid` ==
    "(1) Basically every day")
nrow(Contant_before_covid)

Contact_with_family <- dataset2 %>%
  filter(`how often did you stay in touch with family/friends` ==
    "(1) Basically every day")
nrow(Contact_with_family)
