#### Data parsing with dplyr ####

# downloads, compiles, and installs packages
install.packages("tidyverse")
# loads package
library(tidyverse)
# check to see if a dplyr function is loaded
?select

#### Selecting columns and rows ####

# read in data 
clinical <- read.csv("data/clinical.csv")
# recall object
clinical
str(clinical)

# selecting columns with dplyr
sel_columns <- select(clinical, tumor_stage, ethnicity, disease)
# extract a range of columns
sel_columns2 <- select(clinical, tumor_stage:vital_status)
# select rows based on a condition (filter)
filtered_rows <- filter(clinical, disease == "LUSC")
# filter out missing data from years smoked
filtered_smoke <- filter(clinical, !is.na(years_smoked))

## Challenge: create a new object called race_disease that includes only race, ethnicity, and disease
race_disease <- select(clinical, race, ethnicity, disease)

## Challenge: create a new object from race_disease that called race_BRCA that includes only BRCA (disease)
race_BRCA <- filter(race_disease, disease == "BRCA")

#### Combining commands ####

# last challenge exercise uses intermediate objects to combine commands

# nesting functions to combine commands
clinical_brca <- select(filter(clinical, disease == "BRCA"), race, ethnicity, disease)

# combine functions using pipes
# same example as above
piped <- clinical %>%
  select(race, ethnicity, disease) %>%
  filter(disease == "BRCA")
# extract race, ethnicity, and disease from cases born prior to 1930
piped2 <- clinical %>%
  filter(year_of_birth < 1930) %>%
  select(race, ethnicity, disease)
# does the order of commands (lines) matter? YES
#piped2 <- clinical %>%
#  select(race, ethnicity, disease) %>%
#  filter(year_of_birth < 1930)

## Challenge: using pipes, extract columns gender, years smoked, year of birth for only living patients (vital status) who have smoked fewer than 1 cigarettes per day
challenge <- clinical %>%
  filter(cigarettes_per_day < 1 & vital_status == "alive") %>%
  select(gender, years_smoked, year_of_birth)
challenge <- clinical %>%
  filter(cigarettes_per_day < 1) %>%
  filter(vital_status == "alive") %>%
  select(gender, years_smoked, year_of_birth)

#### Mutate ####

# mutate columns (allows unit conversions, ratios)
# convert days to years
clinical_years <- clinical %>%
  mutate(years_to_death = days_to_death / 365)
# multiple conversions at once
clinical_years <- clinical %>%
  mutate(years_to_death = days_to_death / 365, 
         months_to_death = days_to_death / 30)
# filtering out missing data and inspecting sample
clinical %>%
  filter(!is.na(days_to_death)) %>%
  mutate(years_to_death = days_to_death / 365) %>%
  head()

## Challenge: create a new object from clinical including only lung cancer patients (LUSC) that includes a new column called total_cig representing an estimate of the total number of cigarettes smoked during the individual's lifetime (days to death)
challengeNext <- clinical %>%
  mutate(total_cig = days_to_death * cigarettes_per_day) %>%
  filter(disease == "LUSC")

#### Split-apply-combine ####

# we want to summarize by gender

# testing out summarize function
summarize(clinical, mean_days_to_death = mean(days_to_death, na.rm = TRUE))

# show table of categories in gender
table(clinical$gender)

# count the number of individuals of each gender
clinical %>%
  group_by(gender) %>%
  tally()

# summarize average days to death by gender
clinical %>%
  filter(!is.na(days_to_death)) %>%
  group_by(gender) %>%
  summarize(mean_days_to_death = 
              mean(days_to_death, na.rm = TRUE))

## Challenge: create a new object called smoke_complete that removes missing data for cigarettes per day and age at diagnosis
smoke_complete <- clinical %>%
  filter(!is.na(cigarettes_per_day)) %>%
  filter(!is.na(age_at_diagnosis))
# save data to a file
write.csv(smoke_complete, "data/smoke_complete.csv", row.names = FALSE)

## Challenge: create a new object called birth_complete that contains no missing data for year of birth or vital status
birth_complete <- clinical %>%
  filter(!is.na(year_of_birth)) %>%
  filter(!is.na(vital_status)) %>%
  filter(vital_status != "not reported")
# check to see all missing data are removed
table(birth_complete$vital_status)

#### Filtering data based on number of cases of each type ####

# check how many cases of each cancer type 
table(birth_complete$disease)

# remove cancers with fewer than 500 cases
# count number of records for each cancer
cancer_counts <- birth_complete %>%
  count(disease) %>%
  arrange(n)
# get names of frequently ocurring cancers
frequent_cancers <- cancer_counts %>%
  filter(n >= 500)
# extract data from cancers we would like to keep
birth_reduced <- birth_complete %>%
  filter(disease %in% frequent_cancers$disease)
# save/write data to a file
write.csv(birth_reduced, "data/birth_reduced.csv", row.names = FALSE)
