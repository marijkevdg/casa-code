#Load libraries
library(dplyr)
library(geojson)
library(geojsonsf)
library(readr) 
library(sf)
library(terra)
library(tidyverse)
library(countrycode)
library(janitor)

#Load and clean Global Index Data
global_index_data <- read_csv('data/HDR23-24_Composite_indices_complete_time_series.csv')

#Isolate Global Inequality Index data
#Create new dataframe with country, gii_2010 and gii_2019 data
global_inequality <- as.data.frame(global_index_data$country)
global_inequality <- global_inequality %>% mutate(global_index_data$gii_2010)
global_inequality <- global_inequality %>% mutate(global_index_data$gii_2019)
#Create difference column 
global_inequality <- global_inequality %>% mutate(global_index_data$gii_2019 - global_index_data$gii_2010)
names(global_inequality) <- c("Country", "index_2010", "index_2019", "Difference")
global_inequality <- clean_names(global_inequality)

#Load and clean World spatial data
url <- "/Users/marijkevandergeer/Documents/GitHub/casa-code/data/World_Countries_(Generalized)_9029012925078512962.geojson"
world_data <- geojson_sf(url)
world_data <- clean_names(world_data)
plot(world_data)

#try not to join on string columns because things can be spelled differently
#Merge so the World data contains an inequality difference column
world_inequality <- merge(world_data, global_inequality, by="country")
world_inequality <- world_inequality[-6]
world_inequality <- world_inequality[-6]
names(world_inequality) <- c("country", "fid", "iso", "countryaff", "aff_iso", "inequality_difference", "geometry")

