# function day_month_year takes as innputt the three vectors day, month, year
# a common way of recording time information. However, commonly in large unstructured
# datsets, month or day are often missing and you want to express this as an 
# intervall in eventDate. 
# the function returns three vectors - eventDate (an intervall), startDate
# and endDate
day_month_year <- function(day,mnt,yr) {
  

    # first create intervalls where mnt or day are missing 
    dayStartTemp <- ifelse(is.na(day),"01",day)
    MonthStartTemp <- ifelse(is.na(mnt),"01",mnt)
    

    MonthEndTemp <- ifelse(is.na(mnt),"12",mnt)
    dayEndTemp <- ifelse(is.na(day),# small hack to get the end day of each month
                         as.numeric(days_in_month(as.Date(paste("1900","-",MonthEndTemp,"-","15",sep="")))),
                         day) 
dateStart <- paste(yr,"-",MonthStartTemp,"-",dayStartTemp,sep="")
dateEnd <- paste(yr,"-",MonthEndTemp,"-",dayEndTemp,sep="")
dateStart <- ifelse(is.na(yr),"NA",dateStart) # records with missing year gets NA in startDate
dateEnd <- ifelse(is.na(yr),"NA",dateEnd) # records with missing year gets NA in endDate

eventDate <- paste(dateStart,"/",dateEnd,sep="")
datesout <- as.data.frame(cbind(dateStart,dateEnd,eventDate))
names(datesout) <- c("dateStart","dateEnd","eventDate")
return(datesout)
}

