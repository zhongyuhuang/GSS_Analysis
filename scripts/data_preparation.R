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

# Just keep some variables that may be of interest (change 
# this depending on your interests)
names(raw_data)

reduced_data <- 
  raw_data %>% 
  select(first_col, 
         second_col)
rm(raw_data)
         

#### What's next? ####



         