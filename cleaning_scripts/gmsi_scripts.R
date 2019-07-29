#======================================================================================================
# Gold MSI Extra Script 
# This script scores the code here https://musiccog.lsu.edu/goldMSi/gmsi_lite/goldmsi5_extra.html
#--------------------------------------------------
# Libraries
library(data.table)
library(stringr)
#--------------------------------------------------


score.gmsi.extra <- function(fns=list.files(pattern=".csv")){
  
  # Set up the For Loop to score all of the .csv files in the directory
  for(i in seq(along=fns)){
    
    tmp.dat <- read.csv(fns[i])
    print(paste("Now Working On File",fns[i]))
    
    ##tmp.dat <- read.csv("data/goldmsi/combined/1014.csv") # Line for Debugging 
    
    
    #--------------------------------------------------
    # Break off jsPsych portion with responses and subject number 
    
    data1 <- tmp.dat[,c(7,8)]
    subjectNo <- as.character(data1[1,1])
    data2 <- as.vector(data1) 
    
    
    data2a <- data2[-1,-1] # Drop First row, subject number column 
    data2a <- as.character(data2a)
    
    ## Clean jsMarkers off of Data 
    data3 <- gsub("Q[0-9]|Q10|Q11|Q12|Q13","",data2a)     # Remove Q bit PROBLEM NEED TO TAKE AWAY 10 
    data4 <- gsub(":","",data3)               # Remove colon
    dataX <- gsub('"',"",data4)               # Remove Quotes
    
    ## Likerts Cleaned 
    # If you run dataX, you will see we have 8 item list of each page 
    
    # Split to pages 
    likerts <- dataX[c(3:7,9:13)] 
    
    # Split Likerts to Pages 
    lkt1 <- str_split(likerts,",") 
    
    #--------------------------------------------------
    # Gold MSI Scoring
    #--------------------------------------------------
    
    # Create item level page for easier sorting later 
    page1gmsi <- gsub("[[:punct:]]","",unlist(lkt1[1]))
    page2gmsi <- gsub("[[:punct:]]","",unlist(lkt1[2]))
    page3gmsi <- gsub("[[:punct:]]","",unlist(lkt1[3]))
    page4gmsi <- gsub("[[:punct:]]","",unlist(lkt1[4]))
    instrument <- gsub("[[:punct:]]","",unlist(lkt1[5]))
    
    GoldsmithsLikert <- as.numeric(as.vector(c(page1gmsi,page2gmsi, page3gmsi, page4gmsi)))
    
    GoldPlusOne <- GoldsmithsLikert + 1
    
    ##Aggregate
    data7 <- GoldPlusOne
    data7t <- t(data7)
    
    data7 <- as.data.frame(data7)    
    
    ## Data is now long data frame ready to get subscales out
    
    activeEngagement <- data7[c(1,3,8,15,21,24,28,34,38),]
    activeEngagement <- as.numeric(as.vector(activeEngagement))
    perceptualAbilities <- data7[c(5,6,11,12,13,18,22,23,26),]
    perceptualAbilities <- as.numeric(as.vector(perceptualAbilities))
    musicalTraining <- data7[c(14,27,32,33,35,36,37),]
    musicalTraining <- as.numeric(as.vector(musicalTraining))
    musicalTrainingRaw <- data7[c(14,27,32,33,35,36,37),]
    singingAbilities <- data7[c(4,7,10,17,25,29,30),]
    singingAbilities <- as.numeric(as.vector(singingAbilities))
    emotions <- data7[c(2,9,16,19,20,31),]
    emotions <- as.numeric(as.vector(emotions))
    generalFactor <- data7[c(1,3,4,7,10,12,14,15,17,19,23,24,25,27,29,32,33,37),]
    generalFactor <- as.numeric(as.vector(generalFactor))
    
    #Reverse Items
    
    ##Active Engagment
    actRev5 <- (activeEngagement[5] * -1) + 8
    activeEngagement[5] <- actRev5
    ##Perceptual Abilities 
    perRev3 <- (perceptualAbilities[3]*-1) + 8
    perRev5 <- (perceptualAbilities[5]*-1) + 8
    perRev8 <- (perceptualAbilities[8]*-1) + 8
    perceptualAbilities[3] <- perRev3
    perceptualAbilities[5] <- perRev5
    perceptualAbilities[8] <- perRev8
    ##Musical Training
    musRev1 <- (musicalTraining[1]*-1) + 8 
    musRev2 <- (musicalTraining[2]*-1) + 8
    musicalTraining[1] <- musRev1
    musicalTraining[2] <- musRev2
    # ##Singing Abilities 
    singRev4 <- (singingAbilities[4]*-1) + 8
    singRev5 <- (singingAbilities[5]*-1) + 8
    singingAbilities[4] <- singRev4
    singingAbilities[5] <- singRev5
    ##Emotions
    emotionRev2 <- (emotions[2]*-1) + 8
    emotions[2] <- emotionRev2
    ##General Factor 
    generalFactor[7] <- (generalFactor[7]*-1) + 8
    generalFactor[9] <- (generalFactor[9]*-1) + 8
    generalFactor[11] <- (generalFactor[11]*-1) + 8
    generalFactor[13] <- (generalFactor[13]*-1) + 8
    generalFactor[14]  <- (generalFactor[14]*-1) + 8
    
    ##Items have been subsetted, rename the headers,transpose, join together
    tActive <- t(activeEngagement)
    tPerceptual <-t(perceptualAbilities)
    tMusical <- t(musicalTraining)
    tSinging <- t(singingAbilities)
    tEmotions <- t(emotions)
    tGeneral <- t(generalFactor)
    individual_responses <- cbind(tActive,tPerceptual,tMusical,tSinging,tEmotions)
    
    #Add them up
    ACTIVE <- sum(activeEngagement)
    PERCEPTUAL <- sum(perceptualAbilities)
    MUSICAL <- sum(musicalTraining)
    SINGING <- sum (singingAbilities)
    EMOTIONS <- sum(emotions)
    GENERAL <- sum(generalFactor)
    #--------------------------------------------------
    
    #--------------------------------------------------
    # Score STOMP
    stomp <- gsub("[[:punct:]]","",unlist(lkt1[6]))
    
    stompPlus <- as.numeric(stomp) + 1
    
    classical <- stompPlus[1]
    blues<- stompPlus[2]
    country<- stompPlus[3]
    dancElectronica<- stompPlus[4]
    folk<- stompPlus[5]
    rapHipHop<- stompPlus[6]
    soulFunk<- stompPlus[7]
    relgious<- stompPlus[8]
    alternative<- stompPlus[9]
    jazz<- stompPlus[10]
    rock<- stompPlus[11]
    pop<- stompPlus[12]
    heavyMetal<- stompPlus[13]
    SoundtracksThemeSongs<- stompPlus[14]
    
    #--------------------------------------------------
    # Score SES
    ses <- gsub("[[:punct:]]","",unlist(lkt1[7]))
    
    sesPlus <- as.numeric(ses) + 1
    
    familyIncome <- sesPlus[1]
    highestMother <- sesPlus[2]
    highestFather <- sesPlus[3]
    
    #--------------------------------------------------
    # Score Aural 
    
    aural <- gsub("[[:punct:]]","",unlist(lkt1[8]))
    
    auralPlus <- as.numeric(aural) + 1
    
    melodicTraning <- auralPlus[1]
    melodicCourses <- auralPlus[2]
    melodicPrivate <- auralPlus[3]
    
    harmonicTraning <- auralPlus[4]
    harmonicCourses <- auralPlus[5]
    harmonicPrivate <- auralPlus[6]
    
    sightsingTraning <- auralPlus[7]
    sightsingCourses <- auralPlus[8]
    sightsingPrivate <- auralPlus[9]
    
    #--------------------------------------------------
    # Single Level Items
    
    age <- gsub("[[:punct:]]","",unlist(lkt1[9]))[1]
    gender <- gsub("[[:punct:]]","",unlist(lkt1[9]))[2]
    meds <- gsub("[[:punct:]]","",unlist(lkt1[10]))
    listMeds <- gsub("[[:punct:]]","",unlist(dataX[14]))
    
    
    
    finalScores1 <- cbind(subjectNo,
                          ACTIVE,PERCEPTUAL,MUSICAL,SINGING,EMOTIONS,GENERAL,
                          classical, blues, country, dancElectronica, folk, rapHipHop, soulFunk, relgious, alternative, jazz, rock,pop, heavyMetal, SoundtracksThemeSongs,
                          familyIncome, highestFather, highestMother,
                          melodicTraning,melodicCourses, melodicPrivate,
                          harmonicTraning, harmonicCourses, harmonicPrivate,
                          sightsingTraning, sightsingCourses, sightsingPrivate,
                          instrument,age, gender,
                          meds,listMeds,
                          individual_responses)
    final <- data.table(finalScores1)
    
    
    write.table(final,paste0(substr(fns[i],1,nchar(fns[i])-4),"_data.csv"),sep=",",col.names=TRUE,row.names=FALSE)
    
  }
}

create.gmsi.dataset <- function(){
  filenames <- list.files(pattern = "data")
  bigdata <- do.call("rbind", lapply(filenames, read.csv, header = TRUE))
  write.csv(bigdata,"../../Current_GMSI_Data.csv")
}