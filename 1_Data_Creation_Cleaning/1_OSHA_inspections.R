#### PURPOSE  ####
# The purpose of this code is to merge the all the OSHA inspection datasets into one dataframe. And then isolate all of the prison facilities using SIC/NAICS code and logic.The file then saves the data as as csv file. 


library(lubridate)
library(tidyverse)
library(dplyr)
library(ggplot2)
library(tidyr)
library(stringr)

#### Load in OSHA Inspection Datasets ####
osha1 = read.csv("1_Data_Creation_Cleaning/Raw_Data/OSHA_inspections/osha_inspection0.csv", header = TRUE, sep = ",")
osha2 = read.csv("1_Data_Creation_Cleaning/Raw_Data/OSHA_inspections/osha_inspection1.csv", header = TRUE, sep = ",")
osha3 = read.csv("1_Data_Creation_Cleaning/Raw_Data/OSHA_inspections/osha_inspection2.csv", header = TRUE, sep = ",")
osha4 = read.csv("1_Data_Creation_Cleaning/Raw_Data/OSHA_inspections/osha_inspection3.csv", header = TRUE, sep = ",")
osha5 = read.csv("1_Data_Creation_Cleaning/Raw_Data/OSHA_inspections/osha_inspection4.csv", header = TRUE, sep = ",")

# merge datasets
oshac = rbind(osha1, osha2, osha3, osha4, osha5)

#### 1. Isolate Prisons using sic code and NAICS Code ####

prisons = oshac[((oshac$sic_code == 9223 & !is.na(oshac$sic_code)) | (oshac$naics_code == 922140) & !is.na(oshac$naics_code)), ]
# testing with tidyverse to make sure the rows returned are the same
prisonst <-oshac %>% filter(sic_code == 9223 | naics_code == 922140)

# reformating the close dates
prisons$close_case_date = ymd(prisons$close_case_date)
prisons$close_year = year(prisons$close_case_date)
table(prisons$close_year)

# Filter prisons identified by sic code to only inspections with close dates no later than 2009
table(is.na(prisons$close_year))
prisons2010 = prisons[prisons$close_year > 2009 | is.na(prisons$close_year == TRUE), ]


#### 2. Find any prisons not coded correctly using logics ####
prisonnot = oshac[oshac["sic_code"] != 9223, ]
prisonnot$correction = grepl("CORRECTION|CORRECTIONS|CORRECTIONAl|CORR FAC", prisonnot$estab_name) # found 831
prisonnot$prison = grepl("PRISON", prisonnot$estab_name) # 105
prisonnot$jail = grepl("JAIL", prisonnot$estab_name) # 282
prisonnot$pen = grepl("PENITENTIARY", prisonnot$estab_name) # 31
prisonnot$det = grepl("DETENTION CENTER", prisonnot$estab_name) # nothing 
prisonnot$day = grepl("DAY CENTER", prisonnot$estab_name) # 1
  # NOTE
  # THIS IS NOT A PRISON - ADULT DAY CENTER
prisonnot$camp = grepl("BOY'S CAMP|BOYS CAMP|MEN'S CAMP|MENS CAMP", prisonnot$estab_name) # 6
  # NOTE
  # 5 of these are from the 1970s and were likly camps - no longer exist. 
prisonnot$lock = grepl("LOCK-UP FACILITY", prisonnot$estab_name) # nothing
prisonnot$wom = grepl("WOMEN'S SAFETY CENTER", prisonnot$estab_name) # nothing
prisonnot$jus = grepl("JUSTICE CENTER", prisonnot$estab_name) # 29
prisonnot$con = grepl("CONSERVATION CAMP", prisonnot$estab_name) # 9
  # Not Prisons
  # 102121969; 102215076
prisonnot$ref = grepl("REFORMATORIES", prisonnot$estab_name) # nothing
prisonnot$farm = grepl("JAIL FARM", prisonnot$estab_name) # 8 - these 8 also included in "Jail" search

# code to locate number of institutions found
table(prisonnot$farm)

# Create dataset for found facilities #
prisonnot2 = prisonnot[prisonnot[("correction")] == TRUE | prisonnot[("prison")] == TRUE | prisonnot[("jail")] == TRUE | prisonnot[("pen")] == TRUE | prisonnot[("day")] == TRUE | prisonnot[("camp")] == TRUE | prisonnot[("lock")] == TRUE | prisonnot[("jus")] == TRUE | prisonnot[("con")] == TRUE | prisonnot[("farm")] == TRUE  , ] 


# reformating the close dates for prisonnot
prisonnot2$close_case_date = ymd(prisonnot2$close_case_date)
prisonnot2$close_year = year(prisonnot2$close_case_date)
table(prisonnot2$close_year)

# Filter prisons identified by sic code to only inspections with close dates no later than 2009

prisonnot2$close_case_date <- ymd(prisonnot2$close_case_date)
newprisons <- prisonnot2 %>% mutate(close_year = year(close_case_date))
newprisons2 <- newprisons %>% filter(close_year > 2009 | is.na(close_year == TRUE))


# Drop four facilities which are not actually prisons 
# 1. 314765041
# 2. 313762569
# 3. 315736637 - contractor who builds jails
# 4. 313787681 - electrical contractor

newprisons3 = newprisons2 %>% filter(activity_nr !=  314765041) %>% filter(activity_nr != 313762569) %>% filter(activity_nr != 315736637) %>% filter(activity_nr !=  313787681)


#### 3. Combine Part1 and Part2 Datasets and Save ####
# combine prison2010 and newprisons2
newprisons4 = select(newprisons3, -correction, -prison, -jail, -pen, -det, -day, -camp, -lock, -wom, -jus, -con, -ref, -farm)

newprisons5 = full_join(prisons2010, newprisons4)

# save 
 write.csv(newprisons5, file = "1_Data_Creation_Cleaning/Cleaned_Data/prison_inspections_2010.csv", row.names = FALSE)



