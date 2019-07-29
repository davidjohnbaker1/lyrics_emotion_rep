#--------------------------------------------------
# UPDATE DATA SCRIPT
#--------------------------------------------------
# Run Me to Updata Datafiles
#--------------------------------------------------
source("cleaning_scripts/data_cleaner.R")
setwd("data")
score_emotional_data()
setwd("processed/")
create_emo_dataset()
junk <- dir(pattern="_data") 
file.remove(junk)
setwd("../../")
#--------------------------------------------------
source("cleaning_scripts/gmsi_scripts.R")
setwd("data/gmsi_data/")
score.gmsi.extra()
create.gmsi.dataset()
junk <- dir(pattern="_data") 
file.remove(junk)
setwd("../../")
#--------------------------------------------------
# Make Master

experimental_data <- read_csv("CURRENT_EMO_DATA.csv")
gmsi_data <- read_csv("Current_GMSI_Data.csv")

gmsi_data %>%
  rename(subject = subjectNo) -> gmsi_data

#View(gmsi_data)

experimental_data %>%
  select(-X1) %>%
  left_join(gmsi_data) -> joined_data

#View(joined_data)

write_csv(joined_data, "Master_Data.csv")
