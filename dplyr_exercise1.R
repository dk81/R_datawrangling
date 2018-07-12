# Using R and the dplyr Package:

# Testing and working with the dplyr package for data manipulation in R:
# Dataset documentation found at: 
# https://vincentarelbundock.github.io/Rdatasets/doc/boot/poisons.html

# time: survival time of animal in units of 10 hours
# poison: factor with levels 1, 2, 3 for each poison type used
# treat: a factor with levels A, B, C, D for each treatment.

# Import data:

library(dplyr)

url <- "https://vincentarelbundock.github.io/Rdatasets/csv/boot/poisons.csv"

animal_surv <- data.frame(read.csv(url, header = TRUE))

head(animal_surv) 

tail(animal_surv)

summary(animal_surv)

#Remove first column of X values

animal_surv <- animal_surv[, -1]

head(animal_surv)

#----------------------

## dplyr Functions:

# Randomly select n = 10 rows and view:

sample_n(animal_surv, 10, replace = FALSE)

# Select rows with poison and times (2 ways):

head(select(animal_surv, time, poison))

head(select(animal_surv, -(treat)))

# Select poison column of data:

filter(animal_surv, poison == 1)

# Summarise data: Mean of the times:
summarise(animal_surv, mean_times = mean(time))

# Mean of survival times grouped/categorized by poision:
summarise(group_by(animal_surv, poison), mean_time_poison = mean(time))

#----------------------

# The pipe operator (%>%) :

# Select poison column of data (without %>%)

filter(animal_surv, poison == 1)

# With operator:

animal_surv %>% filter(poison == 1)


### More readable code of above using the pipe operator %>%:

animal_surv %>% group_by(poison) %>% summarise(mean_time_poison = mean(time))

# Group by treatment and take mean of times:

animal_surv %>% group_by(treat) %>% summarise(mean_time_treat = mean(time))

# Filter function (Treatment D is bad):

animal_surv %>% filter(treat != "D")

# Mutate function and adding a column to the dataset. Does the case have more than 1 hour
# of survival time?:

new_data <- mutate(animal_surv, one_hour_plus = time > 1)

# See data with times over an hour (2 ways):

new_data %>% filter(one_hour_plus == TRUE)

animal_surv %>% filter(time > 1)



