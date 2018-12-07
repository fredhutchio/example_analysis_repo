#### Working with data ####

#### Reading in data (importing data) ####

# create directory to store data
dir.create("data")

# download a data file from internet
download.file("https://raw.githubusercontent.com/fredhutchio/R_intro/master/extra/clinical.csv",  "data/clinical.csv")
# import data to R
clinical <- read.csv("data/clinical.csv")
(clinical <- read.csv("data/clinical.csv")) # enclosing object assignment in parentheses also previews the object in console
# recall the object
clinical
# import data directly from a URL
read.csv("https://raw.githubusercontent.com/fredhutchio/R_intro/master/extra/clinical.csv")

## importing data types that aren't csv
# example1 
download.file("https://raw.githubusercontent.com/fredhutchio/R_intro/master/extra/clinical.tsv", "data/clinical.tsv")
# example2 
download.file("https://raw.githubusercontent.com/fredhutchio/R_intro/master/extra/clinical.txt", "data/clinical.txt")
# import example1
example1 <- read.delim("data/clinical.tsv")
?read.csv
# import example2
example2 <- read.table("data/clinical.txt", header = TRUE)
read.csv("data/clinical.txt", sep = " ")

# inspect imported object in detail
# how big is the dataset?
dim(clinical) # rows, columns
# preview content of an object
head(clinical) # print first few rows
tail(clinical) # print last few rows
# view names
names(clinical) # prints column/variable names
rownames(clinical)
# summarize information about object
str(clinical)

#### Subsetting data ####

# rows, columns
# extract first column
clinical[ , 1]
clinical[1]
# extract first row, first column
clinical[1, 1]
# extract single row
clinical[1, ]
# extract range of cells
clinical[1:3, 2] # rows 1 to 3, for column 2
# exclude certain portions of data
clinical[ , -1] # excludes first column
# exclude first 100 rows
clinical[-c(1:100),]
clinical[-c(2, 10, 15),]
# create subset of data for testing
test_clinical <- clinical[1:6, ]

# extract columns by name
clinical["tumor_stage"] # results in data frame
names(clinical)
clinical[2, "tumor_stage"] # vector
clinical[["tumor_stage"]] # results vector
clinical$tumor_stage

## Challenge: extract the first 6 rows for only age at diagnosis and days to death
names(clinical) # need 3 and 6
clinical[1:6, c(3, 6)]
clinical[1:6, c("age_at_diagnosis", "days_to_death")]

#### Factors ####

# create a new factor
sex <- factor(c("male", "female", "female", "male"))
nlevels(sex)
levels(sex) # factor levels are referenced in alphabetical order
# reorder factors 
sex <- factor(sex, levels = c("male", "female"))
sex

# converting factors
as.character(sex)

# renaming factors 
race <- clinical$race # assigning column to an object
levels(race) # viewing categories
levels(race)[2] <- "Asian"
levels(race)
race
# replace race in original data frame
clinical$race <- race
levels(clinical$race)
