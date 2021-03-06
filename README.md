[![Code of Conduct](https://img.shields.io/badge/%E2%9D%A4-code%20of%20conduct-blue.svg?style=flat)](https://github.com/Carceral-Ecologies/Carceral-ECHO-data/blob/master/Code%20of%20Conduct.md)

# README.md
## About - Carceral Ecology
This repository aims to document the Carceral Ecology project, that is being developed by Professor Nicholas Shapiro, UCLA, and Professor Lindsay Poirier, UCD. 

Incarcerated people are on the frontlines of environmental injustice. This systematic exposure of, at a minimum, tens of thousands of incarcerated individuals results from mass incarceration’s close ties with declining, but very much ongoing, industrialism. Often built atop the brownfields of former manufacturing facilities or mines or on the cheap land next to operating facilities, prisons serve as a “recession-proof” employer to those laid off in deindustrialization beginning in the 1970s. This project seeks to assess the environmental hazards of mass incarceration on a national scale. 

This project has three main arms:
1. Envrionmental monitoring
2. Iterative study design with stakeholders
3. Data analysis of datasets that may cast light on the environmental conditions of prisons, jail, and detention centers. 

It is the third component that has likely led you here. We are managing our work flow through the [issues](https://github.com/Carceral-Ecologies/Carceral-ECHO-data/issues) function. Thats probably the best place to start contributing. 

## About - The OSHA Project

This portion of the project is working on component three above, specifically extracting data from the Occupational Safety and Health Administration (OSHA) to cast light on conditions within prisons, jails, and other carceral facilities. This repo provides code that identifies carceral facilities within OSHA data for specific years, merges multiple OSHA data files into one dataset, provides tools for data cleaning (with a specific focus on facility name cleaning), and subsets the data by state (specifically California). The code results in a dataset of OSHA inspections and violations data for carceral facilities in California whose case was resolved after 2009. 

This code may provide significant guidance for others who wish to build a similar dataset of OSHA inspections and violations. The steps here could serve as a guide for others who want to subset data to specific years or states or who want to subset data to other industries more broadly. 

Additionally, we are building a [Wiki](https://github.com/Carceral-Ecologies/Carceral-OSHA-Data/wiki) which provides guidance on obtaining OSHA data, data quality issues, and a data dictionary. 

## Organization of files
Each script represents a stage in the data cleaning or analysis process. This section details the order in which to run the files. The OSHA_Data.Rproj is the project file.

Within the 1_Data_Creation_Cleaning folder there are two additional folders Cleaned_Data and Raw_Data. The Raw_Data are converted to Cleaned_Data using the numbered rscripts in this folder. [You can learn about how to obtain OSHA data in our wiki](https://github.com/Carceral-Ecologies/Caceral-OSHA-Data/wiki/How-to-obtain-OSHA-data). Here is order in which to run the files and brief explanation of what each file does. 
  * First, 1_OSHA_inspections loads in the OSHA inspection datasets and filters the data to include only prisons using NAICS codes, SIC codes, and establishment name information.
  * Second, 2_OSHA_violations loads in the violations data and then filters that data to only include prisons identified in the 1_OSHA_inspections script. 
  * Third, 3_OSHA_related_activity does the same as step 2 but for the OSHA related activity data.
  * Fourth, 4_OSHA_violation_event does the same as step 2 but for the violation event data.
  * Fifth, 5_OSHA_merge_datasets merges the OSHA inspection, violations, related activity, and violation event data into one dataset. 
  * Sixth, 6_open_refine_JSON_cleaning_code is a text document that contains JSON code designed to be run in OpenRefine to clean the city, address, and establishment name information in the final dataset. While OpenRefine is very helpful ultimately this step could not accomplish the level of cleaning required. Thus in step 8 there is an additional file to run for cleaning address and facility name information. Future projects may want to skip the OpenRefine step and add additional cleaning steps to step 8, thus making the process slightly more parsimonious. 
  * Seventh, at this point the dataset is for prisons in the US. This file subsets the data to California prisons only. We detail some of the issues comparing data across states in the [Wiki](https://github.com/Carceral-Ecologies/Caceral-OSHA-Data/wiki/Data-Quality).
  * Eighth, this file systematically cleans address and facility name information so identical facilities can be identified (the names of facilities do not appear to be standardized by OSHA.) and produces the final dataset in both long and wide formats.

## How to Contribute

* Existing issues:
  * Review this repo's [issue queue](https://github.com/Carceral-Ecologies/Carceral-ECHO-data/issues) (and particularly the issues labeled "Help Wanted") for opportunities to contribute to open questions and ongoing tasks. 
  * Assign yourself to issues you are contributing to so that the group knows who to contact in regards to the issue.
  * Comment on issues with relevant ideas or resources. 
  * Mark your progress on issues in this repo's [project board](https://github.com/Carceral-Ecologies/Carceral-ECHO-data/projects).
* New issues
  * File a new issue via this repo's [issue queue](https://github.com/Carceral-Ecologies/Carceral-ECHO-data/issues), asking a question, documenting a bug, or suggesting a direction for further research and development. 
  * Assign yourself or others to issues so that the group knows who to contact in regards to the issue.
  * Select Labels to note whether the issue is a question, bug, or a suggested enhancement. Select the "Help Wanted" label to signal that you are looking for collaborators on the issue.
  * If the issue contributes to a project or milestone, be sure to add this label.
  * Mark your progress on issues in this repo's [project board](https://github.com/Carceral-Ecologies/Carceral-ECHO-data/projects).
* When contributing code, please be sure to:
  * Fork this repository, modify the code (changing only one thing at a time), and then issue a pull request for each change.
  * Follow the project's coding style (using K&R-style indentation and bracketing, commenting above each feature, and using snake case for variables).
  * Test your code locally before issuing a pull request (not sure how to do this? [here's how](https://help.github.com/en/github/collaborating-with-issues-and-pull-requests/creating-a-pull-request)).
  * Clearly state the purpose of your change in the description field for each commit.
  * After your first pull request is approved, please add yourself to the contributors list in the README as is appropriate.

## Code of Conduct

For any questions on decorum please see our [Code of Conduct](https://github.com/Carceral-Ecologies/Carceral-ECHO-data/blob/master/Code%20of%20Conduct.md).

## Contributors
<!-- ALL-CONTRIBUTORS-LIST:START -->
| Contributions | Name |
| ----: | :---- |
| [🔢](# "Content") [📋](# "Organizer") [🤔](# "Ideas and Planning") | Savannah Hunter |
| [💻](# "Code") | Jared Joseph |
| [🔢](# "Content") [📋](# "Organizer") [🤔](# "Ideas and Planning") | Lindsay Poirier |
| [🔢](# "Content") [📋](# "Organizer") [🤔](# "Ideas and Planning") | Nick Shapiro |


<!-- ALL-CONTRIBUTORS-LIST:END -->

(For a key to the contribution emoji or more info on this format, check out [“All Contributors.”](https://allcontributors.org/docs/en/emoji-key))

### Acknowledgements 
Thank you to Konrad Franco [(@klfranco)](https://github.com/klfranco) for his early-stage contributions to the project, for sharing his expertise, and in assisting with generating keywords for identifying carceral facilities in establishment names. 

Thank you to Amay Kharbanda [(@amayk13)](https://github.com/amayk13) for developing code to isolate facilities in California.

Thank you to Ivy Molina [(@premolina492)](https://github.com/premolina492) for her research which provided context for understanding the coverage of OSHA enforcement and for researching how variables in the OSHA dataset are defined.

Thank you to Nathan Tran [(@nathanqtran922)](https://github.com/nathanqtran922) for his investigation and explortation into operationalizing toxicity and hazard using OSHA data.

## Cite As 
Savannah Hunter, Jared Joseph, Lindsay Poirier, & Nicholas Shapiro. (2021, May 27). Carceral-Ecology OSHA Data Extraction and Cleaning Tool (Version 0.0.2). Zenodo.[![DOI](https://zenodo.org/badge/217173617.svg)](https://zenodo.org/badge/latestdoi/217173617)

## License & Copyright

<a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-sa/4.0/80x15.png" /></a> Carceral Ecologies documentation in this repository is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/">Creative Commons Attribution-ShareAlike 4.0 International License</a>. See the [`LICENSE`](https://github.com/Carceral-Ecologies/Carceral-ECHO-data/blob/master/LICENSE) file for details.
