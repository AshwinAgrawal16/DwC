### Mapping tools
Some simple ideas for mapping tools getting various formats of data into DwC. Create a mapping field listing sheet (if spreadsheet type of data), orignal column name, value along with the DwC class, corrsponding DwC term, and value in controled vocabuary. 

Example: 

| sheet-name | column | value | dwc:class     | dwc:term              |controlled-vocabulary  
|----------------|----------|--------|----------------|---------------------|-----------------------------|
| fish                 | Species| Trout  | Occurrence  | scientificName  | Salmo trutta                    |
| fish                 | Species| Charr| Occurrence   | scientificName | Salvelinus alpinus          |
| fish                 | Garn      | GB     | event               | samplingProtocol | survey_gillnett_bottom|

Then, R script to cast this over to format ready for DwC import. 

To be continued... 
