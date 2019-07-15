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
