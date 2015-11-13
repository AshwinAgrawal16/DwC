#########################################################################
#
# DwC Occurence quickfix: From wide to long-format (typically from data as recorded in field-forms)
#
# Created by AGF 2015-11-13
#
# Comment: Not the most elegant pice of code in the history of mankind,
# but it sort off works if you don't have too large datasets. The code is 
# not genereric, but specific to this case and meant only as an example.
#
#########################################################################

library(tidyr)
library(dplyr)
library(jsonlite)

# set working directory if your data is not in the same directory as the script
setwd("C:\\iSkya\\GitHub\\DwC\\from-wide-to-long-format")

#######################################################################
#
# In this case we have a single csv file with zooplankton data in "wide" format
# i.e. each row correpond to one sampling event and the number and biomass of different species
# are in rows. 
#
# Need to a) convert to long format, b) convert units d) revise species names (only given as codes in orginal file)
#
######################################################################

data.inn <- read.csv("zoopl_data_toR.csv",head=T,sep=";")
occurence_information <- read.csv("zoopl_occurence_information.csv",sep=";")

#######################################################################
# reshaping the data from wide format 
#####################################################################

# i) We have three different measures in this datast - individual count (to individualCount), 
# length (to dynamic properties) and biomass (to organismQuantity)
# 
# Split up different measures, rename and transfer from short to long format
data.individualCount <- data.inn[c("eventID","N_daph", "N_cop","N_naup" ,"N_bos")]
names(data.individualCount) <- c("eventID","daph", "cop","naup" ,"bos")
data.individualCount <- data.individualCount %>% gather(key=eventID,value=individualCount)
names(data.individualCount) <- c("eventID","internal_taxonID","individualCount")
head(data.individualCount)

data.organismQuantity <- data.inn[c("eventID","B_daph_ugL", "B_cop_ugL","B_naup_ugL" ,"B_bos_ugL")]
names(data.organismQuantity) <- c("eventID","daph", "cop","naup" ,"bos")
data.organismQuantity <- data.organismQuantity %>% gather(key=eventID,value=organismQuantity)
names(data.organismQuantity) <- c("eventID","internal_taxonID","organismQuantity")
head(data.organismQuantity)

data.organismLength <- data.inn[c("eventID","l_daph_mm","l_cop_mm","l_naup_mm","l_bos_mm")]
names(data.organismLength) <- c("eventID","daph", "cop","naup" ,"bos")
data.organismLength <- data.organismLength %>% gather(key=eventID,value=measurementValue)
names(data.organismLength) <- c("eventID","internal_taxonID","orgasmLength")
head(data.organismLength)

# creating the occurence extention
occurence_ext <- data.individualCount
occurence_ext$organismQuantity <- data.organismQuantity$organismQuantity
occurence_ext$organismQuantityType <- rep("biomassDryMicroG",length(data.organismQuantity$organismQuantity))
occurence_ext$occurrenceStatus <- ifelse(occurence_ext$individualCount>0,"present","absent")

for(i in 1:length(data.out$organismQuantityType)){
  occurence_ext$dynamicProperties <- paste("meanLength_mm:",data.organismLength$orgasmLength[i])
}

data.out <- left_join(occurence_ext,occurence_information,by=c("internal_taxonID"))
data.out <- data.out[!names(data.out) %in% c("internal_taxonID")]

write.table(data.out,"occurence_extention.csv",sep=",")

