# Tidying Data in R:

# Random practice:

# Mammals:

head(mammals)

Mammals <- data.frame(rownames(mammals), as.numeric(mammals[, 1]), as.numeric(mammals[, 2]))

colnames(Mammals) <- c("Mammal", "Body Weight", "Brain Weight")

head(Mammals)


# ---------------------------------------------------

# Cleaning a 3 dim array:

library(datasets)

# can use data.frame on 3 dim array:

# example: 

data.frame(HairEyeColor)



# ---------------------------------------------------


# spread, gather, unite, separate:
library(tidyr)

library(MASS)

# tidyr::gather example:

barley <- immer

head(barley)
str(barley)

# Rename column names:

# Y1 is yield in 1931, Y2 is yield in 1932

col_names <- c("Location", "Barley_Type", "1931", "1932")

colnames(barley) <- col_names

# Take columns from 1931 and 1932 into rows. 
# 1931 and 1932 belong into new column Year, values from the old 1931 & 1932 columns
# are yield values with the respective year.

barley2 <- gather(barley, "Year", "Yield", c(3, 4))

head(barley2)
tail(barley2)

#-------------------------------------------

# Unite function (Combines columns into one):

# 1973 data:
head(airquality)

air_data <- data.frame(airquality, Year = 1973)

air_data <- unite(air_data, Date, Year, Month, Day, sep = "-")

# Rearrange Date column to front

air_data <- data.frame(Date = air_data[, 5], air_data[, 1:4])
head(air_data)

# Convert/Format date properly:

library(lubridate)

# Format the first column of dates to year-month-day format using 
# lubridate function ymd:

air_data[, 1] <- ymd(air_data[, 1])

head(air_data)


#-------------------------------------------------

# Another gather example:

US_spend <- as.data.frame(USPersonalExpenditure)

head(US_spend)

colnames(US_spend) <- c("1940", "1945", "1950", "1955", "1960")

US_spend <- as.data.frame(cbind(US_spend, Category = rownames(US_spend)))

US_spend_long <- gather(US_spend, "Year", "Personal Expenditure", 1:5)

head(US_spend_long); dim(US_spend_long)

# --------------------------------------------

# Gather example 3:

# turtle data from faraway library
library(faraway)
head(turtle)

gather(turtle, "Hatched_Turtles_Count", "Gender", 2:3)

# --------------------------

# Gather example 4:
library(faraway)
head(potuse)

colnames(potuse) <- c("Gender", "1976", "1977", "1978", "1979", "1980", "Count")

pot_long <- gather(potuse, "Year", "Status", 2:6)

head(pot_long)

# Change numbers 1 and 2 to male and female:
pot_long$Gender[pot_long$Gender == 1] <- "Male" 
pot_long$Gender[pot_long$Gender == 2] <- "Female" 

# Change numbers 1, 2, 3 never used, no more than once per month, 
# more than once per month:




#-------------------------------------------------

# separate into multiple columns example:

# Creating sample data:
# 1 is male, 2 is female

library(tidyr)

treat_gender <- c("A_1", "A_2", "B_1", "B_2")
Count <- c(3, 8 , 10, 6)

sample <- data.frame(treat_gender, Count)
sample

# Seprate column treat_gender into Treatment and Gender columns:
data <- separate(sample, treat_gender, c("Treatment", "Gender"), sep = "_")

# Change the 1 to Male and the 2 cases to Female
data$Gender[data$Gender == 1] <- "Male"
data$Gender[data$Gender == 2] <- "Female"

data


#-------------------------------------------------

# spread rows into columns: long to wide format

library(faraway)

library(tidyr)

suicide_data <- suicide

head(suicide_data)

suicide_wide <- spread(suicide_data, sex, y)

colnames(suicide_wide) <- c("Cause", "Age_Group", "Female_Count", "Male_Count")

head(suicide_wide)

# Convert the factors m, o, y to numerics 1, 2, 3:
suicide_wide$Age_Group <- as.numeric(suicide_wide$Age_Group)

# Convert the 1, 2, 3 to middle aged, old, and young factors
suicide_wide$Age_Group[suicide_wide$Age_Group == 1] <- "Middle-Aged"
suicide_wide$Age_Group[suicide_wide$Age_Group == 2] <- "Old"
suicide_wide$Age_Group[suicide_wide$Age_Group == 3] <- "Young"

# Convert the Age_Group column back as factors:

suicide_wide$Age_Group <- as.factor(suicide_wide$Age_Group)

head(suicide_wide)

#--------------------------------------

## Putting it back using gather():


suicide2 <- gather(suicide_wide, "Gender", "Count", 3:4)

head(suicide2)

suicide2$Gender[suicide2$Gender == "Female_Count"] <- "Female"
suicide2$Gender[suicide2$Gender == "Male_Count"] <- "Male"

head(suicide2)

#-------------------------------------------------

# paste0 (mini tutorial)

paste0("a", "1")
paste("a", "1", sep = ".")

#unite Example

# Fake data, generate hours, minutes and seconds

hours <- round(runif(50, min = 0, max = 5), 0)
minutes <- round(runif(50, min = 0, max = 60), 0)
seconds <- round(runif(50, min = 0, max = 60), 0)

# Put hours, minutes and seconds together as a data frame:
sample <- data.frame(Hours = hours, Minutes = minutes, Seconds = seconds)

# A peek at the data:
head(sample)

# Put a zero as first digit if value is less than ten to get 0X format.

sample$Hours <- ifelse(sample$Hours < 10, paste0(0, sample$Hours), as.character(sample$Hours))
sample$Minutes <- ifelse(sample$Minutes  < 10, paste0(0, sample$Minutes), as.character(sample$Minutes))
sample$Seconds <- ifelse(sample$Seconds < 10, paste0(0, sample$Seconds), as.character(sample$Seconds))

# Another peek to check:
head(sample)

# Unite the Hours, Minutes, Seconds columns, this combined column is Time:

united <- unite(sample, Time , Hours, Minutes, Seconds, sep = ":")

# One last look:
head(united)

# ----------------------------------------------

# Fake data 2: dates (hmm..)

year <- runif(50, min = 2000, max = 2016)
month <- runif(50, min = 0, max = 12)
day <- runif(50, min = 0, max = 31)

sample2 <- data.frame(Year = round(year,0), Month = round(month,0), Day = round(day, 0))

sample2$Year <- ifelse(sample2$Year < 10, paste0(0, sample2$Year), as.character(sample2$Year))
sample2$Month <- ifelse(sample2$Month < 10, paste0(0, sample2$Month), as.character(sample2$Month))
sample2$Day <- ifelse(sample2$Day  < 10, paste0(0, sample2$Day ), as.character(sample2$Day ))


united2 <- unite(sample2, Date , Year, Month, Day, sep = "-" )

head(united2)

library(lubridate)







