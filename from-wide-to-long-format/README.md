# Quick and dirty example on how to change from "wide" to "long" format
Often, community type of data are punched and handled in "wide" format (i.e. the individual species and their quantities are listed in columns). DwC-A require the data to be in "long" format (i.e. each row is one occurence record). Here, I use an example dataset constituting the occurence extention for a zooplankton event based sample to change from "wide" to "long" format using the R tidyr library. 

The example is not generic and rely on manual coding of column names etc. 
