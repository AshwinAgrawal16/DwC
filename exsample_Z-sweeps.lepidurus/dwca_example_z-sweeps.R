#########################################################################
#
# DwC Event quickfix: From DwC Archives and back again
#
# Created by AGF 2015-11-09
#
# Comment: Not the most elegant pice of code in the history of mankind,
# but it sort off works if you don't have too large datasets 
#
#########################################################################

library(xlsx) 
library(tidyr)
library(dplyr)

# set directory of directory with data if not in same directory as the script
setwd("C:\\iSkya\\GitHub\\andersfi\\DwC\\exsample_Z-sweeps.lepidurus")

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
xl.inn <- "Lepidurus_Zackenberg.xls"
# read data

occurrence <- read.xlsx2(file=xl.inn,sheetName="occurrence")
event <- read.xlsx2(file=xl.inn, sheetName="event")
location <- read.xlsx2(file=xl.inn,sheetName="location")
measurm_facts <- read.xlsx2(file=xl.inn,sheetName="measurment_and_facts")
measurm_description <- read.xlsx2(file=xl.inn,sheetName="measurments_description")

##################################################
# merge the location and event table
# into one table (i.e. the event core of a DwC Archive)
##################################################

# first join event and occurence table 
  event_CORE <- left_join(event, location)

# the date column is no good (xl store dates as numbers), 
# use the day,month,year columns to create date in ISO format
eventDate <- paste(event_CORE$year,event_CORE$month,event_CORE$day,sep="-")
event_CORE <- subset(event_CORE, select = -c(date) )

# write output to workdir
write.csv(event_CORE, "event_CORE.csv",row.names=F)


#####################################################
# Occurence extention 
# - as is in raw data 
#####################################################

# occurence core as is
occurrence_EXTENTION <- occurrence
write.csv(occurrence_EXTENTION, "occurrence_EXTENTION.csv")


#######################################################################
# reshaping the measurments table from wide format 
# to long format and creates the 
# measurments and facts EXTENTION of a DwC Archive. 
# Also, map measurments to eventID (in raw data location specific)
#####################################################################

# i) flatten out measurments and facts and link to measurments description
temporary <- gather(measurm_facts,key=locationID)
names(temporary) <- c("locationID","measurementType","measurementValue")

temporary2 <- inner_join(temporary, measurm_description, by = "measurementType")
measurements.extention  <- temporary2[!(temporary2$measurementValue==""),] # deleate all records without measurements
head(measurements.extention)

# ii) "case specific" where measurments are recorded on location level - link measruments to eventID
temporary3 <- subset(event_CORE, select = c(locationID,eventID) )
measurements.extention2 <- left_join(measurements.extention, temporary3)
measurements_and_facts_EXTENTION <- subset(measurements.extention2, select = -c(locationID) )

write.csv(measurements_and_facts_EXTENTION, "measurements.extention.csv",row.names=F)


#######################################################################
#
# Testcase - take data back from GBIF using the rgbif library
#
#####################################################################
library(rgbif)



test <- occ_search(datasetKey = "78360224-5493-45fd-a9a0-c336557f09c3",limit=300,return="all")
lepidata <- test$data  
gbifmap(test)
           , 
           fields=c('name','basisOfRecord','protocol'), limit = 20)

lepidurus <- datasets(uuid="78360224-5493-45fd-a9a0-c336557f09c3")

test <- occ_download("datasetKey-78360224-5493-45fd-a9a0-c336557f09c3")

key <- name_backbone(name='Puma concolor')$speciesKey
dat <- occ_search(taxonKey=key, return='data', limit=300)
gbifmap(dat)

key <- name_backbone(name='Puma concolor')$speciesKey
dat <- occ_search(taxonKey=key, return='data', limit=300)
gbifmap(dat)




