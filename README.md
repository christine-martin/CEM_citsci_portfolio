# CEM_citsci_portfolio
Christine Martin
EVR 628

This is my GitHub portfolio project, which features data and visualizations from my SLR/meta-analysis of citizen science x chondrichthyans. I will be extracting data as a csv from my Google Sheets database on chondricthyan species discussed in the literature, their taxonomy, and their IUCN status. I am interested in understanding how citizen science is being used to answer questions about chondrichthyans across divisions, orders, species, and IUCN designations.

## Current project repository contents:
- data:
    - data/raw: contains this project's raw data in csv format ("citsci_specieslist_data.csv")
      
- scripts:
    - scripts/01_processing: contains an r script that imports the data, cleans the data, and creates a new column necessary for future analysis
 
Future contents will include a results folder that will contain images, etc.

## Column names, descriptions, and data type:
'species_data_totals' is the cleaned and renamed data, with 132 observations of 11 variables. Its column names, variable types, and variable descriptions are as follows -
1. species: the common name of a chondrichthyan species addressed in the citizen science literature (primary common name listed by the IUCN) [character]
2. scientific_name: the scientific name of the chondrichthyan species addressed in the citizen science literature [character]
3. division: the division of the chondrichthyan species addressed in the citizen science literature (e.g., 'Ray/Skate', 'Shark') [character] 
4. order: the order of the chondrichthyan species addressed in the citizen science literature (e.g., 'Myliobatiform', 'Carcharhiniform') [character] 
5. not_species_level: 'TRUE' indicates that an organism(s) in the literature were unable to identify to a species level and that the value is NOT at the species level (e.g., 'Sphyrna spp.' would be marked as 'TRUE' in this column). 'FALSE' would indicate a species-level identification was made [logical]
6. cat1_total: indicates the total number of times a species was addressed in a paper that was labeled 'Category 1' (the paper's primary focus is chondrichthyan(s) and addresses a single species) [numeric]
7. cat2_total: indicates the total number of times a species was addressed in a paper that was labeled 'Category 2' (the paper's primary focus is chondrichthyan(s) and addresses multiple species) [numeric]
8. cat3_total: indicates the total number of times a species was addressed in a paper that was labeled 'Category 3' (the paper discusses chondrichthyan(s) and engages with associated data in a meaningful way) [numeric]
9. cat4_total: indicates the total number of times a species was addressed in a paper that was labeled 'Category 4' (the paper mentions chondrichthyan(s) but does not engage with associated data in any meaningful way) [numeric]
10. iucn: indicates the species' global IUCN status ('NE' = Not Evaluated, 'DD' = Data Deficient, 'LC' = Least Concern, 'VU' = Vulnerable, 'EN' = Endangered, 'CR' = Critically Endangered, 'EW' = Extinct in the Wild, 'EX' = Extinct, 'Multiple/Many' = more than one species is included in the observation - ex: 'Sphyrna spp.') [character]
11. species_totals: contains the sum of all cat#_total values grouped by species. I.e., the number of times a species is identified across all Categories 1-4 [numeric]
