#libraries 
library(tidyverse)

#read and inspect 
surveys <- read_csv("data/portal_data_joined.csv")
head(surveys)
summary(surveys)

typeof(surveys$species_id); typeof(surveys$hindfoot_length) #identify the 'type' for these rows

length(surveys) #number of columns in DF
nrow(surveys) #number of rows in DF

#selecting columns and filtering rows 
    #changing columns: select()
select(surveys, plot_id, species_id, weight)
select(surveys, plot_id, weight_g = weight) #can simultaneously rename and select columns with the select function
select(surveys, -record_id, -species_id) #removes columns

    #changing rows: filter()
filter(surveys, year == 1985)
filter(surveys, year == 1995, plot_id == 7) #the comma indicates an '&' operator
filter(surveys, month == 2 | day == 20) #the '|' is the or operator 

      #Q3
filter(surveys, month == 11, hindfoot_length > 36)

     #Q4
filter(surveys, year == 1995) 
filter(surveys, plot_id == 2)


#pipes
surveys_psw <- surveys %>% 
  filter(year == 1995) %>%
  select(plot_id, weight)

      #Q5
survey_q5 <- surveys %>%
  filter(year < 1995) %>%
  select(year, sex, weight)

#mutate 
surveys %>%
  mutate(weight_kg = weight/1000) %>%
  view() #will pull up in viewer to see new column

surveys %>%
  mutate(weight_kg = weight/1000, 
         weight_lb = weight_kg * 2.2)

surveys %>% 
  filter(!is.na(weight)) %>%
  mutate(weight_kg = weight/1000, 
         weight_lb = weight_kg * 2.2)

        #Q6
surv_df <- surveys %>%
  mutate(hindfoot_cm = hindfoot_length/10) %>%
  filter(!is.na(hindfoot_cm), hindfoot_cm < 3) %>%
  select(species_id, hindfoot_cm) 
surv_df


#summarize 
surveys %>% 
  group_by(sex) %>% #just by sex
  summarise(mean_weight = mean(weight, na.rm = TRUE))

surveys %>% 
  drop_na(weight) %>% #drops the NAs from the weight column
  group_by(species_id, sex) %>% #by sex and species
  summarize(mean_weight = mean(weight),
            min_weight = min(weight),
            .groups = "drop") %>% #this line ungroups the DF
  arrange(-mean_weight) #default is ascending order

      #Q7
surveys %>%
  group_by(plot_type) %>%
  count()

      #Q8
surveys %>% 
  drop_na(hindfoot_length) %>%
  group_by(species_id) %>%
  summarise(mean_lg = mean(hindfoot_length), 
            min_lg = min(hindfoot_length), 
            max_lg = max(hindfoot_length), 
            obsv_n = n())

      #Q9
surveys %>% 
  drop_na(weight) %>%
  group_by(year) %>%
  mutate(chunky_animal = max(weight)) %>%
  select(year, genus, species_id, chunky_animal) 
