#### Preamble ####
# Purpose: Prepare the 2021 GSS data
# Author: Zhongyu Huang
# Data: 19 March 2021
# Contact: zhongyu.huang@mail.utoronto.ca 
# License: MIT
# Pre-requisites: 
# - Need to have downloaded the GSS data and saved it to inputs/data



#### Workspace setup ####
# Use R Projects, not setwd().
library(haven)
library(tidyverse)
# Read in the raw data. 
raw_data <- haven::read_dta("inputs/data/2021_stata/gss2021.dta")

####Data preparation ####
# Just keep some variables that may be of interest 
reduced_data <- 
  raw_data %>% 
  select(year, 
         sexnow1, age, degree,raceacs1, raceacs10, raceacs2, raceacs3, raceacs4,
         raceacs5, raceacs6, raceacs7, raceacs8, raceacs9, raceacs11, raceacs12,
         raceacs13, raceacs14, raceacs15, raceacs16,partyid, natdrug, grassv) %>% rename(Gender = sexnow1)
rm(raw_data)

# recode gender variable based on the codebook "GSS 2021 Codebook R1b.pdf"
reduced_data <- 
  reduced_data %>% 
  mutate(Gender = case_when(
    Gender == 1 ~ "Male",
    Gender == 2 ~ "Female",
    Gender == 3 ~ "Transgender",
    Gender == 4 ~ "None of these"
  ))

# recode race variable
reduced_data <- 
  reduced_data %>% 
  mutate(Race = case_when(
    raceacs1 == 1 ~ "White",
    raceacs2 == 1 ~ "Black",
    raceacs3 == 1 ~ "American indian or alaska native",
    raceacs4 == 1 ~ "Asian Indian",
    raceacs5 == 1 ~ "Chinese",
    raceacs6 == 1 ~ "Filipino",
    raceacs7 == 1 ~ "Japanese",
    raceacs8 == 1 ~ "Korean",
    raceacs9 == 1 ~ "Vietnamese",
    raceacs10 == 1 ~ "Other Asian",
    raceacs11 == 1 ~ "Native hawaiian",
    raceacs12 == 1 ~ "Guamanian or chamorro",
    raceacs13 == 1 ~ "Samoan",
    raceacs14 == 1 ~ "Other pacifis islander",
    raceacs15 == 1 ~ "Some other race",
    raceacs16 == 1 ~ "Hispanic",
  ))

# create party variable
reduced_data <- 
  reduced_data %>% 
  mutate(Party = case_when(
    partyid == 0 ~ "STRONG DEMOCRAT",
    partyid == 1 ~ "NOT VERY STRONG DEMOCRAT",
    partyid == 2 ~ "INDEPENDENT, CLOSE TO DEMOCRAT",
    partyid == 3 ~ "INDEPENDENT (NEITHER, NO RESPONSE)",
    partyid == 4 ~ "INDEPENDENT, CLOSE TO REPUBLICAN",
    partyid == 5 ~ "NOT VERY STRONG REPUBLICAN",
    partyid == 6 ~ "STRONG REPUBLICAN"
  ))


# create Degree variable
reduced_data <- 
  reduced_data %>% 
  mutate(Degree = case_when(
    degree == 0 ~ "LESS THAN HIGH SCHOOL",
    degree == 1 ~ "HIGH SCHOOL",
    degree == 2 ~ "ASSOCIATE/JUNIOR COLLEGE",
    degree == 3 ~ "BACHELORS",
    degree == 4 ~ "GRADUATE",
    
  ))


# create LegalVSIllegal variable
reduced_data <- 
  reduced_data %>% 
  mutate(LegalVSIllegal = case_when(
    grassv == 1 ~ "SHOULD BE LEGAL",
    grassv == 2 ~ "SHOULD NOT BE LEGAL",
  ))

# create Spend variable
reduced_data <- 
  reduced_data %>% 
  mutate(Spend = case_when(
    natdrug == 1 ~ "Too little",
    natdrug == 2 ~ "About right",
    natdrug == 3 ~ "Too much"
  ))


# keep new variables that may be of interest 
reduced_data <- 
  reduced_data %>% 
  select(year, 
         Gender, age, Degree, Race ,Party, Spend, LegalVSIllegal)

#### Save the data ####

write.csv(reduced_data, "outputs/data/prepared_gss.csv")
         