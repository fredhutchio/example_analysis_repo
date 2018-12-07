#### Week 1: intro to R and RStudio ####

# basic math
3 + 4
3+4 # spaces aren't essential, but they are convention

# using a function
round(3.14)
# finding help for function
args(round)
?round
# adding arguments to a function
round(3.14, digits = 1)
round(3.14, 1)
round(1, 3.14)
round(digits = 1, x = 3.14)

## Challenge: what does the function ceiling do? What are its main arguments? How did you arrive at your answer?
?ceiling
ceiling(5.7)

#### Assigning objects ####

# assigning value to an object
weight_kg <- 55 
# recall object
weight_kg
# perform operations on object
weight_kg * 2.2
# assign new value to object
weight_kg <- 57.5
# assigning output to a new object
weight_lb <- weight_kg * 2.2
weight_kg <- 100
# the order in which code is run matters!

# remove objects from environment
remove(weight_kg)
rm(weight_lb)
weight_lb

## Challenge: what is the value of each object?
mass <- 47.5            # mass?
width  <- 122             # width?
mass <- mass * 2.0      # mass?
width  <- width - 20        # width?
mass_index <- mass/width  # mass_index?

#### Vectors ####

# assign vector
ages <- c(50, 55, 60, 65)
# recall vector
ages
# how many things are there?
length(ages)
# what type of data?
class(ages)
# get an overview of the object
str(ages)

# apply functions to vectors
mean(ages)
range(ages)

# vector of character
organs <- c("lung", "prostate", "breast")

## Challenge: for organs
# How many things are there?
length(organs)
# What type of data?
class(organs)
# Get an overview
str(organs)

# data types in R
# character: chr strings, occur in quotes
# numeric; num "double"
# integers: 2L
# logical: TRUE FALSE boolean
# complex: complex imaginary numbers
# raw; bitstreams 

## Challenge: what happens when each of the objects are created?
num_char <- c(1, 2, 3, "a")
num_logical <- c(1, 2, 3, TRUE)
char_logical <- c("a", "b", "c", TRUE)
tricky <- c(1, 2, 3, "4")
tricky <- as.numeric(tricky)

#### Working on vectors ####

# add values to end of a vector
ages <- c(ages, 90)
# add values to the beginning of vector
ages <- c(30, ages)

# extract values from a dataset?
# indexing starts at 1
organs[1] # extract first value
organs[1:2] # extracting range of values
organs[c(1, 3)] # multiple values
organs[-2] # exclude values
organs[-c(1, 3)] # exclude first and third values?

# conditional subsetting
ages > 60 # asks if values meet criteria
ages[ages > 60] # subsets based on criteria
ages[ages == 60]
# combine conditions: OR
ages[ages < 50 | ages > 60]
# combine conditions AND &

# why does the following code return TRUE
"four" > "five"

#### Missing data ####

# create a new vector with missing data
heights <- c(2, 4, 4, NA, 6)
# perform functions
mean(heights)
max(heights)
# remove NA prior to calculations
mean(heights, na.rm = TRUE)
max(heights, na.rm = TRUE)

# additional ways to remove missing data
heights[!is.na(heights)]
heights[complete.cases(heights)]
test <- na.omit(heights)
?na.omit

# exploring missing data with character data
organs <- c(organs, "NA")
organs
is.na(organs)
complete.cases(organs)

## Challenge:
# create vector
heights <- c(63, 69, 60, 65, NA, 68, 61, 70, 61, 59, 64, 69, 63, 63, NA, 72, 65, 64, 70, 63, 65)
# remove NAs from heights
heightsX <- na.omit(heights)
# calculate median of heights
median(heights, na.rm = TRUE)
median(heightsX)
# identify number of people who are taller than 67 inches
length(heights[heights > 67])
# visualize
hist(heights)

