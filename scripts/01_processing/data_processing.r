#EVR628 Project
#Christine Martin
#Citizen Science x Chondrichthyans
#Species Data Processing

#Loading packages
library(EVR628tools)
library(tidyverse)
library(janitor)

#Creating directories
EVR628tools::create_dirs()

#Loading citizen science x chondrichthyan species data
species_data <- read_csv("data/raw/citsci_specieslist_data.csv")

#Review column names
colnames(species_data)

#Replace NAs in numeric variables with 0
species_data <- species_data |>
  mutate(across(where(is.numeric), ~replace_na(., 0)))

#Delete unnecessary columns that are creating issues re: error message:
#"Error in is.data.frame(x) && do.NULL : invalid 'y' type in 'x && y'"
#(these columns will not be needed for visualizations anyway)
species_data <- species_data |>
  select(Species,
         `Scientific Name`,
         Type,
         Order,
         `NOT Species Level`,
         `Cat_1#`,
         `Cat_2#` ,
         `Cat_3#`,
         `Cat_4#`,
         IUCN) |>
  mutate(Cat1_Source = NULL,
         Cat2_Source = NULL,
         Cat3_Source = NULL,
         Cat4_Source = NULL,
         Total = NULL,
         Notes = NULL,
         ...17 = NULL,
         ...18 = NULL)

#Clean and rename column names
species_data <- species_data |>
  clean_names() |>
  rename(division = type,
         cat1_total = cat_1_number,
         cat2_total = cat_2_number,
         cat3_total = cat_3_number,
         cat4_total = cat_4_number)

#Review column names
colnames(species_data)

#Create a new column with the sum of all cat#_total grouped by species
species_data_totals <- species_data |>
  mutate(species_totals =
           cat1_total +
           cat2_total +
           cat3_total +
           cat4_total) |>
  group_by(species)

#Review column names
colnames(species_data_totals)

#Save cleaned data as csv to correct folder
write.csv(species_data_totals, "data/processed/citsci_specieslist_clean.csv")

#Data should now be ready to generate visualizations summarizing the proportions
#of species divisions/orders, species totals, and IUCN status to
#understand how the citizen science literature is interacting with various
#species, orders, and divisions of chondrichthyans and their conservation status
