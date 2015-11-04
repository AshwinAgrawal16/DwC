# Survey of Lepidurus arcticus occurrence and relative abundance (Z-sweeps) on North-east Greenland

The data set origins from a small survey of Lepidurus Arcticus in the Zackenberg area North-east Greenland. It is presented as an example of using the event core extension of Darwin Core Archives for documenting the sampling process. Although the basic data is occurrence type (i.e. answer the question where did we find L. Arcticus in the area sampled), there are also invaluable information in the data that would be lost if not the sampling process is documented. Particularly, this involves the abundance type of data (semiquanitative CPUE given as catches per unit effort) and negative observations: i.e. there are several sampling instances that leaves blank samples (i.e. negative observations). For the latter, there is presently no good way of explicitly documenting this in Darwin core. The field OccurenceStatus having the option of indicating "absence" does not capture that other species may have been looked for and not found. In this case we have been screening the data also for other Notostraca species (although we are pretty sure they don't exist in the area). This is indicated in the eventRemarks field as "eventTaxonomicRange:Notostraca spp.". A suggestion could be to include something like "eventTaxonomicRange" in the event core to solve this issue. 

The folder contains raw data (as punched from field forms) in xls format, R-scripts to convert these data to Darwin Core Archive event core format, and text (csv) files with the formatted data ready to upload into the IPT. 

Resource URL: http://gbif.vm.ntnu.no/ipt/resource?r=lepidurus-arcticus-survey_northeast-greenland_2013&v=1.1

Raw data input on google docs: https://docs.google.com/spreadsheets/d/1AkZSzhSqf5LWdc0Vos8BXkCP2egeD6wp-Tgh1Dwho1A/edit?usp=sharing

