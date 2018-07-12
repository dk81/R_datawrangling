# Working with Big Data Using R's data.table Package:

# We will work with the babynames dataset:

# To install use: install.packages("data.table")

library(babynames)

library(data.table)

set.seed(45L)

baby_table <- data.table(babynames)

## Check for any missing values:

sum(is.na(baby_table))

## Take a look at our data:

# Dimensions of dataset: (1.82 million rows with 5 columns)
dim(baby_table) 

# Column names of the baby_data:

names(baby_table)

# Dataset structure and summary:
str(baby_table) 

summary(baby_table)

# A peek of the first ten rows and last ten rows:

head(baby_table, n = 10) 

tail(baby_table, n = 10)

## --------------------------------------------------

# Format is data_table[i, j, by]

# Selecting rows referring to i:

# If we want the rows from 25 to 28 (2 ways):

baby_table[25:29, ]

baby_table[25:29]

# Selecting rows with a criteria - Choosing names with the name of Marissa:

marissa <- baby_table[name == "Marissa"]

head(marissa, n = 10)

# Selecting rows with names of "Zach: and "Penny":

baby_table[name %in% c("Zach", "Penny")]


## --------------------------------------------------

# Selecting columns in j:

# Years column:

years <- baby_table[, year]; 

years

# Choosing several columns and omit the proportion column:

no_propor <- baby_table[, .(year, sex, name, n)]

head(no_propor) 

dim(no_propor)

# Could also use list() function instead of .():

baby_table[, list(year, sex, name, n)]

# Note that .() is needed to output a data.table object. Otherwise
# we get a vector.

# We can compute on serveral columns.

counts <- baby_table[ , .(Total_Count = sum(n), Standard_Deviation_Of_Counts = sd(n) )]

counts

#---------------------------------------------------

# Using the by:

# Calculating the number of rows for each group in sex column: (.N is for counting)

gender_count <- baby_table[, .N, by = sex]

gender_count

# Calculating the total number of males and total number of females:

gender <- baby_table[ , .(Total.Gender = sum(n)), by = sex]

gender

# Check if the gender counts for male and gender count for female equals total counts.
# (Is 337135426 = 167070477 + 170064949?)

counts[, Total_Count] == (sum(gender[, Total.Gender]))

# ------------------------------------------------

# Combine i and j:

# Most popular baby name in dataset:

baby_table <- data.table(babynames)

aggregate <- baby_table[ , .(Name.count = sum(n)), by = name][order(-Name.count)]

# Long way:

aggregate <- baby_table[ , .(Name.count = sum(n)), by = name]
aggregate <- aggregate[order(-Name.count)]

head(aggregate, n = 15)

agg_male <- baby_table[sex == "M" , .(Name.count = sum(n)), by = name][order(-Name.count)]

head(agg_male, n = 15)

agg_female <- baby_table[sex == "F" , .(Name.count = sum(n)), by = name][order(-Name.count)]

head(agg_female, n = 15)

#---------------------------------------------------

# Indexing and keys:

key_table <- data.table(babynames)

# Set key on our data table with column name:
setkey(key_table, name)

# name is the keyed column
# search for all rows where name == "Mario"

key_table["Mario"]

# name is the keyed column
# search for all rows where name == "Mario" or "Dennis"

key_table[c("Mario", "Dennis")]

# nomatch argument for the case where a specified value in the row
# does not match in the data table rows
# By default it is NA, nomatch = 0 means no rows to be returned
# in the event of no match

key_table[c("April", "What")]

key_table[c("April", "What"), nomatch = NA]

key_table[c("April", "What"), nomatch = 0]

## Counting Methods:

# Counting the number of Marios and Marias (together): 

key_table[c("Mario", "Maria"), sum(n)]

# Counting the number of Marios and Marias (separately): 

key_table[c("Mario", "Maria"), sum(n), by = .EACHI]

## Selecting multiple Columns in Keys:

# Select the year and name columns as keys:
# sort by year then name

key_table <- data.table(babynames)

setkey(key_table, year, name)

# Search for the year 2000 with name Sophie:

key_table[.(2000,"Sophie")]

# Search for the years 2000, 2001 with names Caitlin and Raj:

key_table[.(c(2000, 2001), c("Caitlin", "Raj"))]


#---------------------------------------------------

# Changing column names (from "n" to "Count")

new_col <- data.table(babynames)

new_col <- setnames(new_col, "n", "Count")

head(new_col, n = 10)

# Change column order:

ordered <- data.table(babynames)

new_order <- c("year", "name", "sex", "n", "prop")

setcolorder(ordered, new_order)

head(ordered, n = 10)

#---------------------------------------------------

# Remove a column:

no_years <- data.table(babynames)

no_years <- no_years[, year := NULL];

head(no_years);

# Remove year, sex and prop columns but keep the name and n columns:

just_names <- data.table(babynames) # Create new copy
just_names <- just_names[, c("year", "sex", "prop") := NULL];

head(just_names, n = 20)


