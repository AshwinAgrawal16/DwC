#########################################################################
#
# DwC Event quickfix: From DwC Archives and back again
#
# Created by AGF 2015-10-09
#
# Comment: Not the most elegant pice of code in the history of mankind,
# but it sort off works if you don't have too large datasets 
#
#########################################################################

library(xlsx) 
library(tidyr)
library(dplyr)

# set directory of directory with data if not in same directory as the script
setwd("C:\\iSkya\\GitHub\\andersfi\\DwC\\gillnet_data")

#######################################################################
#
# importing data;
# Raw data inn is in xls workbook with five worksheets containing the
# three DwC formatted sheets "location","event", and "occurence", and 
# then a sheet "measurements" with various measuremens on individuals,
# and then the sheet "measurments_description" giving the description of 
# headers and measurment units and methods in the measurments sheet.
#
######################################################################
# name of xl file
xl.inn <- "raw_testfishing_BearIsland.xls"
# read data

occurence <- read.xlsx2(file=xl.inn,sheetName="occurrence")
event <- read.xlsx2(file=xl.inn, sheetName="event")
location <- read.xlsx2(file=xl.inn,sheetName="location")
measurm_facts <- read.xlsx2(file=xl.inn,sheetName="measurments")
measurments_description <- read.xlsx2(file=xl.inn,sheetName="measurments_description")

##################################################
# reshaping the measurments table from wide format 
# to long format and creates the 
# measurments and facts EXTENTION of a DwC Archive
##################################################

temporary <- gather(measurm_facts,key=occurrenceID)
names(temporary) <- c("occurrenceID","measurementType","measurementValue")

temporary2 <- inner_join(temporary, measurments_description, by = "measurementType")
measurements.extention  <- temporary2[!(temporary2$measurementValue==""),] # deleate all records without measurements
head(measurements.extention)

write.csv(measurements.extention, "measurements.extention.csv",row.names=F)

##################################################
# merge the location, event and occurence table
# into one table (i.e. the occurence core of a DwC Archive)
##################################################

# first join event and occurence table 
occurence.temp <- left_join(event, occurence)

#then join joint-occurence-event with location
occurence.core  <- inner_join(occurence.temp, location)

# the date column is no good (xl store dates as numbers), 
# use the day,month,year columns to create date in ISO format
occurence.core$eventDate <- paste(occurence.core$year,occurence.core$month,occurence.core$day,sep="-")
occurence.core <- subset(occurence.core, select = -c(date) )

# write output to workdir
write.csv(occurence.core, "occurence.core.csv",row.names=F)


#####################################################
# Test: provide file ready for analyses
#####################################################

# occurence core as is
occurence.core.inn <- read.csv("occurence.core.csv")

# spreading measurements measurements 
measurments.temp <- read.csv("measurements.extention.csv")
measurments.temp2 <- measurments.temp[c("occurrenceID","measurementType","measurementValue")]

measurments.inn <- spread(measurments.temp2, key = measurementType,value=measurementValue)
head(measurments.inn)

data <- left_join(occurence.core.inn,measurments.inn)


#write.csv(data, "testdata.csv",row.names=F)
