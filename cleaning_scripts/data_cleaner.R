#--------------------------------------------------
# Score the Emotional Data
#--------------------------------------------------
library(tidyverse)
#--------------------------------------------------

score_emotional_data <- function(fns=list.files(pattern="*.csv")){
  
  for(i in seq(along=fns)){
    
    print(paste("Now Working On File",fns[i])) 
    
    emotional <- read_csv(fns[i])
    
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
    
    write.table(subject_responses,paste0("processed/",substr(fns[i],1,nchar(fns[i])-4),"_response_data.csv"),sep=",",col.names=TRUE,row.names=FALSE)
    
    
  }
  print("NOW CHANGE DIRECTORY FOR CREATE EMO")
}


create_emo_dataset <- function(){
  filenames <- list.files(pattern = "data")
  bigdata <- do.call("rbind", lapply(filenames, read.csv, header = TRUE))
  write.csv(bigdata,"../../CURRENT_EMO_DATA.csv")
}
