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

response1 <- c('All', 'Most', 'Some', 'None', 'Basically everyday')
response2_5 <- c('A few times a week','A few times a month','Once a month', 'Not at all', 'Not sure')
response6_7 <- c('Yes', 'No')
response8 <- c('Excellent' , 'Very good', 'Good', 'Fair', 'Poor')
response9 <- c('Male', 'Female')
response10_11 <- c('White non-hispanic', )


for(i in seq_along(dataset2)) {
  dataset2[,i] <- factor(dataset2[,i], levels=response1)
}

ahhh <- likert(dataset2)


# Bar chart for gender and mental health ratings

ggplot(data = dataset2) +
  geom_col(mapping = aes(x = `how would you rate your health`, y = gender, 
                         fill = gender)) +
  labs(title = "Mental Health Rating by Gender", x = "Level",
       y = "Amount of Responses") +
  coord_flip() +
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

data_items <- dataset2 %>% 
  select(`talk with neighbor in month`:`how often did you stay in touch with family/friend before covid`) %>%
  na.omit 

data_items %>%  
  gather(key = Questions, value = Responses) %>% 
  mutate(Responses = factor(Responses)) %>% 
  ggplot(aes(x = Questions)) +
  geom_bar(aes(fill = Responses), position = "fill") -> interactions
interactions + scale_fill_brewer(palette = "Spectral")
