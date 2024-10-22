#Load libraries
library(dplyr)
library(geojson)
library(geojsonsf)
library(readr) 
library(sf)
library(terra)
library(tidyverse)

#Load Global Gender Inequality Data
global_index_data <- read_csv('HDR23-24_Composite_indices_complete_time_series.csv')

#need 2010 and 2019 gii index
#Creates new datafram with gii_2010 data
global_inequality <- as.data.frame(global_index_data$country)
global_inequality <- global_inequality %>% mutate(global_inequality$gii_2010)
#Adds gii_2019 data
global_inequality <- global_inequality %>% mutate(global_index_data$gii_2019)
names(global_inequality) <- c("Country", "index_2010", "index_2019")
#creates column showing difference in index between 2010 and 2019
global_inequality <- global_inequality %>% mutate(index_2019 - index_2010)
names(global_inequality) <- c("Country", "index_2010", "index_2019", "Difference")
 
#Load World spatial data
url <- "/Users/marijkevandergeer/Documents/GitHub/casa-code/World_Countries_(Generalized)_9029012925078512962.geojson"
world_data <- geojson_sf(url)

#Merge
