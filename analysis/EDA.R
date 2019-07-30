#--------------------------------------------------
# Check Data
#--------------------------------------------------
library(tidyverse)
library(reshape2)
#--------------------------------------------------

intended <- read.csv("IntendedMaster.csv")
View(intended)

emotion <- read_csv("Master_Data.csv")
View(emotion)

#--------------------------------------------------
# List of Things here 
#--------------------------------------------------
# Plot Groupwise ANOVA 

emotion %>%
  select(subject, Happy:Familiar,title,Condition,Track_ID, ACTIVE:GENERAL) -> small_master

write_csv(x = small_master, "SmallerMaster.csv")
