# DwC Archive user cases

A selection of user cases for documenting ecological datasets through Darwin Core Archives and publishe them on GBIF wit focus on sampling basded data sets.The purpose of this repository is to try to provide some user cases for documenting the sampling process in DwC-A along with some "sandbox" examples of R-scripts to wrap data from formats used in analyses and registration to DwC-A and back again. 

### What's all the fuss about? 
The current repository focuses on code for documenting sampling based ecological datasets (terrible term, I admit, which ecological datasets are not sampling based?) using [Darwin Core terms](http://rs.tdwg.org/dwc/terms/index.htm) and sharing them through GBIF as Darwin Core Archives so that they can be used in research and management with a quantitative ecological approaches. Studying drivers and treats (such as climate change) to biodiversity and ecosystem services inherently requires knowledge about the dynamics and structure of populations. One important aspect lacking in the bulk of data out on GBIF is without quantitative information and information about the sampling process, disabling applications beyond simple presence only models. The Holy Grail in this respect is the ability to explisit document negative findings (i.e. absence information of a given species at a specific time and place), and information about the quantity of individuals in a sample (e.g. number and biomass). 

The new Event Core of Darwin Core Archives offers these possibilities, but have at the moment some significant drawbacks. There are at the moment several things I can't work out and that is either due to my misconception, or that should be improved further. This is currently under rapid developement and we'll see what happends this year. 
* Using the event core, Measurements and facts about individual occurrences are not possible to map properly due to the inherent star-format of DwC-A. Measurements and facts about individuals are only possible to document properly when related to the specific sampling event. The alternative is to map sampling based data where extra information (not covered by DwC terms) are vital using the occurrence core. Then we are back to problems documenting absences. 
* Absences can be made explicit by listing occurrences of species not recorded and indicating "absent" in the "occurrenceStatus" field. However, for many types of analyses (e.g. vegetation plots where the investigator looks for every vascular plant known to mankind in his sampling square), this becomes cumbersome and impractical. A field indicating the taxonomic range the investigator have screened his sample for would solve this problem. A better solution would probably be to link each event to a checklist/taxa-list describing the taxonomic scope of the sample?

[Some other demo-examples](https://ntnu.box.com/v/dwc-mapping-demo-cases)

[Brief presentation held at a Data Publishing Workshop in Trondheim, Norway 2015-11-30](https://goo.gl/rntxpT)

[Brief presentation held at a workshop in front of the 8th GBIF European Nodes meeting](https://ntnu.box.com/v/gbif-workshop)

The repository is under Development.
