#EVR628 Project
#Christine Martin
#Citizen Science x Chondrichthyans
#Species Data Visualization

#Load packages
library(EVR628tools)
library(tidyverse)
library(janitor)
library(cowplot)

#Load cleaned citizen science x chondrichthyan species data
species_data_totals <- read.csv("data/processed/citsci_specieslist_clean.csv")

#Review data info, column names
colnames(species_data_totals)
dim(species_data_totals)

#Remove column "X" which is just numbering the rows. Truthfully, I am unsure of
#where this came from in my processing. It will be unnecessary for analysis.
species_data_totals <- species_data_totals |>
  select(species,
         scientific_name,
         division,
         order,
         not_species_level,
         cat1_total,
         cat2_total,
         cat3_total,
         cat4_total,
         iucn,
         species_totals) |>
  mutate(X = NULL)

#Replace the "noot" values in the Division column with "NA". This was used as an
#NA placeholder in my datasheet to avoid confusion, and now must be corrected
species_data_totals <- species_data_totals |>
  mutate(division = na_if(division, "noot"))

#Replace the "noot" values in the Order column with "NA"
species_data_totals <- species_data_totals |>
  mutate(order = na_if(order, "noot"))
#-------------------------------------------------------------------------------

#Create a bar plot of the total number of times a division of chondrichthyans is
#addressed by the cit sci literature (x = division, y = total n), ordered by
#frequency and removing NAs
ggplot(subset(species_data_totals, !is.na(division)), aes(x = fct_infreq(division))) +
  geom_bar(fill = "orchid2") +
  coord_flip() +
  labs(x = "Division",
       y = "Count",
       title = "Division of chondrichthyans addressed by citizen science literature",
       caption = "Source: 2025 systematic literature review") +
  theme_minimal()

#Assign the Division x Count Plot a name
p_division_count <- ggplot(subset(species_data_totals, !is.na(division)), aes(x = fct_infreq(division))) +
  geom_bar(fill = "orchid2") +
  coord_flip() +
  labs(x = "Division",
       y = "Count",
       title = "Division of chondrichthyans addressed by citizen science literature",
       caption = "Source: 2025 systematic literature review") +
  theme_minimal()

#Save the Division x Count Plot
ggsave(plot = p_division_count,
       filename = "results/img/p_division_count.png",
       bg = "white")

#-------------------------------------------------------------------------------
#Create a bar plot of the total number of times an order of chondrichthyans is
#addressed by the cit sci literature (x = order, y = total n), ordered by
#frequency, and removing NAs
ggplot(subset(species_data_totals, !is.na(order)), aes(x = fct_infreq(order))) +
  geom_bar(fill = "orchid2") +
  coord_flip() +
  labs(x = "Order",
       y = "Count",
       title = "Orders of chondrichthyans addressed by citizen science literature",
       caption = "Source: 2025 systematic literature review") +
  theme_minimal()

#Assign the Order x Count Plot a name
p_order_count <- ggplot(subset(species_data_totals, !is.na(order)), aes(x = fct_infreq(order))) +
  geom_bar(fill = "orchid2") +
  coord_flip() +
  labs(x = "Order",
       y = "Count",
       title = "Orders of chondrichthyans addressed by citizen science literature",
       caption = "Source: 2025 systematic literature review") +
  theme_minimal()

#Save the Order x Count Plot
ggsave(plot = p_order_count,
       filename = "results/img/p_order_count.png",
       bg = "white")

#-------------------------------------------------------------------------------
#Visualize the order proportions within divisions as a bar graph, removing NAs
ggplot(subset(species_data_totals, !is.na(order)), aes(x = fct_infreq(division), fill = order))+
  geom_bar(position = "fill") +
  coord_flip() +
  labs(x = "Division",
       y = "Proportion",
       fill = "Order",
       title = "Orders of chondrichthyans addressed by citizen science",
       caption = "Source: 2025 systematic literature review") +
  theme_minimal()

#Assign the Ordered Divisions x Proportion Plot a name
p_ord_div_prop <- ggplot(subset(species_data_totals, !is.na(order)), aes(x = fct_infreq(division), fill = order))+
  geom_bar(position = "fill") +
  coord_flip() +
  labs(x = "Division",
       y = "Proportion",
       fill = "Order",
       title = "Orders of chondrichthyans addressed by citizen science",
       caption = "Source: 2025 systematic literature review") +
  theme_minimal()

#Save the Ordered Divisions x Proportion Plot
ggsave(plot = p_ord_div_prop,
       filename = "results/img/p_ord_div_prop.png",
       bg = "white")

#-------------------------------------------------------------------------------
#Visualize the IUCN proportions within divisions as a bar graph, removing NAs
ggplot(subset(species_data_totals, !is.na(division)), aes(x = fct_infreq(division), fill = iucn)) +
  geom_bar(position = "fill") +
  coord_flip() +
  labs(x = "Division",
       y = "Proportion",
       fill = "IUCN status",
       title = "IUCN status of chondrichthyans addressed by citizen science",
       caption = "Source: 2025 systematic literature review, IUCN Redlist") +
  theme_minimal()

#Assign the IUCN Proportions x Divisions Plot a name
p_div_iucn_prop <- ggplot(subset(species_data_totals, !is.na(division)), aes(x = fct_infreq(division), fill = iucn)) +
  geom_bar(position = "fill") +
  coord_flip() +
  labs(x = "Division",
       y = "Proportion",
       fill = "IUCN status",
       title = "IUCN status of chondrichthyans addressed by citizen science",
       caption = "Source: 2025 systematic literature review, IUCN Redlist") +
  theme_minimal()

#Save the Ordered Divisions x Count Plot
ggsave(plot = p_div_iucn_prop,
       filename = "results/img/p_div_iucn_prop.png",
       bg = "white")

#-------------------------------------------------------------------------------
#Use cowplot to combine Order proportions x divisions and IUCN proportions x divisions
#Note @JC: I've attempted in other versions of the below code to adjust the plot sizes so the
#titles don't overlap with the labels by using the scale argument, but unfortunately
#I haven't been able to figure out how to also adjust the labels
#ex: plot_grid(p_ord_div_prop, p_div_iucn_prop, ncol = 1, scale = 0.9)
plot_grid(p_ord_div_prop, p_div_iucn_prop, ncol = 1)

#Assign the cowplot grid a name
p_order_iucn_grid <- plot_grid(p_ord_div_prop,
                               p_div_iucn_prop,
                               ncol = 1)

#Save the grid
ggsave(plot = p_order_iucn_grid,
       filename = "results/img/p_order_iucn_grid.png",
       bg = "white",
       height = 9,
       width = 11)
