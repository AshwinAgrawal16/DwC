# Quick and dirty example on how to change from "wide" to "long" format
Often, community type of data are punched and handled in "wide" format (i.e. the individual species and their quantities are listed in columns). DwC-A require the data to be in "long" format (i.e. each row is one occurrence record). Here, I use an example dataset constituting the occurrence extension for a zooplankton event based sample to change from "wide" to "long" format using the R tidyr library. 

The example is not generic and rely on manual coding of column names etc. 

The input data consists of a) zooplankton data in "wide" format and b) extra information for the occurrence records (including species names, taxon information etc.) repeatedly entered to the occurrence data. Output data are in the occurence_extention.csv file.
