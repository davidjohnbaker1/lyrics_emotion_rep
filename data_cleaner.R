#--------------------------------------------------
# Score the Emotional Data
#--------------------------------------------------
library(tidyverse)
#--------------------------------------------------

emotional <- read_csv("data/005_lyr.csv")

#--------------------------------------------------
# Clean Stimuli Data 

emotional %>% 
  filter(trial_index >= 3) %>%
  mutate(temp = str_remove_all(string = stimulus, pattern = "sound/")) %>% 
  mutate(temp = str_remove_all(string = temp, pattern = "\\.mp3")) %>%
  separate(col = temp, into = c("title", "Condition", "Track_ID")) %>% 
  select(subject, rt, trial_type, button_pressed, responses, title, Condition, Track_ID) %>%
  fill(title, Condition, Track_ID, .direction = "down") %>%
  filter(trial_type == "survey-likert") %>%
  select(-button_pressed, -trial_type) %>%
  mutate(responses = str_remove_all(string = responses, pattern = '\"Q[0-9]\":')) %>%
  mutate(responses = str_remove_all(string = responses, pattern = '\\{')) %>%
  mutate(responses = str_remove_all(string = responses, pattern = '\\}')) %>%
  separate(col = responses, c("Happy", "Calm", "Sad", "AngryStressful", "Familiar"), sep = ",") %>%
  mutate(Happy = as.numeric(Happy) + 1, 
         Calm = as.numeric(Calm) + 1, 
         Sad = as.numeric(Sad) + 1, 
         AngryStressful = as.numeric(AngryStressful) + 1, 
         Familiar = as.numeric(Familiar) + 1 ) -> subject_responses
  
subject_responses
#======================================================================================================
# Break Down 
#--------------------------------------------------
emotional %>% 
  filter(trial_index >= 3) 

emotional %>% 
  filter(trial_index >= 3) %>%
  mutate(temp = str_remove_all(string = stimulus, pattern = "sound/")) 

emotional %>% 
  filter(trial_index >= 3) %>%
  mutate(temp = str_remove_all(string = stimulus, pattern = "sound/")) %>% 
  mutate(temp = str_remove_all(string = temp, pattern = "\\.mp3")) 

# And So On 
#--------------------------------------------------
# ** You can run just select lines in RStudio by just
# higlighting code and pressing CMD + Enter 
# Then you don't have to just keep copy pasting 
#--------------------------------------------------