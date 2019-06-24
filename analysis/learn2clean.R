#--------------------------------------------------
# Single Cleaner Script
#--------------------------------------------------
# The goal of this script will to be to make our 
# input javascript data as a tidy format
# https://cran.r-project.org/web/packages/tidyr/vignettes/tidy-data.html 
# There are examples of how I've done this on my github
# But try to figure it out before peeking at mine.
#--------------------------------------------------

#--------------------------------------------------
# Libraries
# * install and library() the tidyverse 

#--------------------------------------------------
# Read in Data
# * use the CSV reader command that is used 
# in the tidyverse to read in one data file 

#--------------------------------------------------
# Extract out "important" data 
# Write some code that looks for the 
# Cell that has participant information in it
# Save it to an object that has a unique name 

#--------------------------------------------------
# Get Experimental Data
# use the select() and filter() commands with 
# the pipe operator (%>%) to only get the 
# columns and rows where there is response data

#--------------------------------------------------
# Split file name column to make the data tidy
# Read up on the stringr pacakge
# https://cran.r-project.org/web/packages/stringr/vignettes/stringr.html
# and regular expressions
# https://regexone.com/
# and start to try to extract different strings of text from the file name column

# Eventually make a column for every type of data in the column

# Save a clean, tidy version to a folder with the write_csv() command 


