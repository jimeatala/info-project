# Histogram of Mental Health Ratings/Amount of Responses seperated by Gender----

dataset <- read.csv("https://query.data.world/s/x7qrjzoufcjzx6agzg5d6omncpzup7", header=TRUE, stringsAsFactors=FALSE)
library("dplyr")
colnames(dataset)
names(dataset)[names(dataset) == "SOC1"] <- "how much do you trust your neighborhood"
names(dataset)[names(dataset) == "SOC2A"] <- "talk with neighbor in month"
names(dataset)[names(dataset) == "SOC2B"] <- "talk with neighbor in month before covid"
names(dataset)[names(dataset) == "SOC3A"] <- "how often did you stay in touch with family/friends"
names(dataset)[names(dataset) == "SOC3B"] <- "how often did you stay in touch with family/friend before covid"
names(dataset)[names(dataset) == "SOC4A"] <- "did you volunteer this month"
names(dataset)[names(dataset) == "SOC4B"] <- "how often did you volunteer per month before covid"
names(dataset)[names(dataset) == "PHYS8"] <- "how would you rate your health"
names(dataset)[names(dataset) == "SOC5"] <- "in the past 7 days have you felt anxious/depressed/lonely/hopeless"
names(dataset)[names(dataset) == "GENDER"] <- "gender"
names(dataset)[names(dataset) == "RACETH"] <- "race"
names(dataset)[names(dataset) == "HHSIZE1"] <- "household size"
names(dataset2)[names(dataset2) == "household size"] <- "household_size"

dataset2 <- dataset %>%  select(`how much do you trust your neighborhood`:`how would you rate your health`, gender , race, RACE_R2 , EDUCATION, `household size`)

library(tidyr)
library(tidyverse)
library(dplyr)
library(ggplot2) ''

# Start of the histogram (run everything before in the right order first)

dataset3 <- dataset2 %>%
  select(`how would you rate your health`, gender) %>%
  filter(`how would you rate your health` != "(98) SKIPPED ON WEB") %>%
  filter(gender != "(98) SKIPPED ON WEB") %>%
  filter(`how would you rate your health` != "(77) DON'T KNOW")

dataset3$`how would you rate your health` <- as.character(dataset3$`how would you rate your health`)
dataset3[dataset3 == "(1) Excellent"] <- "Excellent"
dataset3[dataset3 == "(2) Very good"] <- "Very Good"
dataset3[dataset3 == "(3) Good"] <- "Good"
dataset3[dataset3 == "(4) Fair"] <- "Fair"
dataset3[dataset3 == "(5) Poor"] <- "Poor"
dataset3$`how would you rate your health` <- as.factor(dataset3$`how would you rate your health`)

names(dataset3)[names(dataset3) == "how would you rate your health"] <- "Mental Health Rating"

ggplot(data = dataset3, mapping = aes(x = `Mental Health Rating`, fill = `Mental Health Rating`)) + 
  geom_histogram(binwidth = 1, stat = "count") +
  labs(x = "Level of Mental Health", y = "Amount of Responses") +
  facet_wrap(~gender, labeller = "label_both") 








