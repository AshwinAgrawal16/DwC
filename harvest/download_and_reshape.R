#########################################################################################################
# access the files for the analyses stored as a Occurrence core DwC-A 
# on NTNU-VM's ITP instalation - using the curl library (https://cran.r-project.org/web/packages/curl/vignettes/intro.html)
#########################################################################################################
library(curl)
tmp <- tempfile()
curl_download("http://gbif.vm.ntnu.no/ipt/archive.do?r=bear_island_testfishing&v=1.2", tmp)
#unzip(tmp, files = "NULL", list = T) view the files in the zip archive
unzip(tmp, files = c("occurrence.txt","measurementorfact.txt"), list = F)
occurrence <- read.table("occurrence.txt",sep="\t",header = T)
measurementorfact <- read.table("measurementorfact.txt",sep="\t",header = T)

########################################################################################################
# restructure the DwC-A files to a format ready for analyses - output file "cdw" (CannibalDwarf).
########################################################################################################

# first restructure Measurment and fact table from long to wide format
library(tidyr)
library(dplyr)


measurementorfact_wide <- measurementorfact %>% select(id,measurementType,measurementValue) %>% 
  spread(key=measurementType,value=measurementValue) 
cdw <- left_join(occurrence,measurementorfact_wide)
