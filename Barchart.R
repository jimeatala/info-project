# Histogram of Mental Health Ratings/Amount of Responses seperated by Gender----

dataset <- read.csv("https://query.data.world/s/x7qrjzoufcjzx6agzg5d6omncpzup7", header=TRUE, stringsAsFactors=FALSE)
library("dplyr")
library("ggplot2")
library("tidyverse")


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
dataset2 <- dataset %>%  select(`how much do you trust your neighborhood`:`how would you rate your health`, gender , race, RACE_R2 , EDUCATION, `household size`, P_GEO)

<<<<<<< HEAD:Barchart.R
response1 <- c('All', 'Most', 'Some', 'None', 'Basically everyday')
response2_5 <- c('A few times a week','A few times a month','Once a month', 'Not at all', 'Not sure')
response6_7 <- c('Yes', 'No')
response8 <- c('Excellent' , 'Very good', 'Good', 'Fair', 'Poor')
response9 <- c('Male', 'Female')
response10_11 <- c('White non-hispanic', )


for(i in seq_along(dataset2)) {
  dataset2[,i] <- factor(dataset2[,i], levels=response1)
}

# Bar chart for gender and mental health ratings

ggplot(data = dataset2) +
  geom_col(mapping = aes(x = `how would you rate your health`, 
                         y = gender, fill = gender)) +
  labs(title = "Mental Health Rating by Gender", x = "Level",
       y = "Gender") +
  scale_fill_brewer(palette = "Paired")


# Separated by Gender- how many responses in each "Rate of Health" level

colors <- c(rep("red",1), rep("orange",1), rep("yellow",1), rep("green",1), rep("blue",1),
            rep("black",2), rep("red",1), rep("orange",1), rep("yellow",1), rep("green",1),
            rep("blue",1), rep("black",3))

ggplot(data = dataset2, mapping = aes(x = `how would you rate your health`)) + 
  geom_histogram(binwidth = 1, stat = "count",
                 color = "white", fill = colors) +
  labs(x = "Rate of Health") +
  facet_wrap(~gender, labeller = "label_both") 


# Stacked Bar Chart x Comparison of 4 Questions

data_items <- dataset3 %>% 
  select(`1`:`4`) %>%
  na.omit 

data_items %>%  
  gather(key = Questions, value = Responses) %>% 
  mutate(Responses = factor(Responses)) %>% 
  ggplot(aes(x = Questions)) +
  geom_bar(aes(fill = Responses), position = "fill") -> interactions
interactions + scale_fill_brewer(palette = "Spectral")

dataset3 <- dataset2 %>% 
  select( `talk with neighbor in month` : `how often did you stay in touch with family/friend before covid`)
dataset3$`talk with neighbor in month` <- as.character(dataset3$`talk with neighbor in month`)
dataset3[dataset3 == "(1) Basically every day"] <- "Basically every day"
dataset3[dataset3 == "(2) A few times a week"] <- "A few times a week"
dataset3[dataset3 == "(3) A few times a month"] <- "A few times a month"
dataset3[dataset3 == "(4) Once a month"] <- "Once a month"
dataset3[dataset3 == "(5) Not at all"] <- "Not at all"
dataset3[dataset3 == "(98) SKIPPED ON WEB"] <- "Skipped on web"
dataset3[dataset3 == "(77) Not sure"] <- "Not sure"
dataset3$`talk with neighbor in month` <- as.factor(dataset3$`talk with neighbor in month`)

names(dataset3)[names(dataset3) == "talk with neighbor in month"] <- "1"
names(dataset3)[names(dataset3) == "talk with neighbor in month before covid"] <- "2"
names(dataset3)[names(dataset3) == "how often did you stay in touch with family/friends"] <- "3"
names(dataset3)[names(dataset3) == "how often did you stay in touch with family/friend before covid"] <- "4"
=======
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








>>>>>>> b44cf0a145ec4968db0a031d207eb75972303f30:histogram.R
