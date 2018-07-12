# The Melt Function In R

# Need library reshape2
# References: http://seananderson.ca/2013/10/19/reshape.html
# Faraway library

# install.packages("reshape2")
library(reshape2)

#----------------------------

# Example One: Wide Format Data To Long Format Data

# Get kangaroo measurements data from faraway package and save it to a variable.

kangaroo_data <- faraway::kanga

# Preview the data:

head(kangaroo_data)

tail(kangaroo_data)

# Summary and data structure:

summary(kangaroo_data)

str(kangaroo_data)

# Melt The Data From Wide To Long Format (Remove NA values):

kangaroo_long <- melt(kangaroo_data, na.rm = TRUE, value.name = "Measurement_Value")

# Preview melted data and check dimensions:

head(kangaroo_long)

dim(kangaroo_long)

# Rename columns:

colnames(kangaroo_long) <- c("Species", "Sex", "Measurement", "Amount")

# Preview melted data again:

head(kangaroo_long)

tail(kangaroo_long)

#------------------------------------------------------

# Example Two - Custom Example

colours <- c("Yellow", "Green", "Red", "Blue", "Black", "White")
sizes <- c("Small", "Medium", "Large")

# Number of elements/objects in each array/vector (Set):

length(colours) #6
length(sizes) #3

# Create Cartesian Product (All combinations)
cartesianProd <- expand.grid(colours, sizes)

cartesianProd

# Length should be 
nrow(cartesianProd) #6 x 3 = 18

# Change column names:

colnames(cartesianProd) <- c("Colours", "Sizes")

# Create a table with counts

table <- table(cartesianProd)

table


# Undoing the table using melt function in reshape2 package

melted_table <- melt(table)

melted_table

# Change column names:

colnames(melted_table) <- c("Colours", "Sizes", "Count")



#------------------------------------------------------

# Example Three - Sample Generated Data Of Coin Flip and Roll a Die (300 times) 

# 0 = tails, 1 = Heads, C(1:6) is the same as c(1, 2, 3, 4, 5, 6)

# Set seed 

set.seed(177)

# Generate data (using the random seed):

coin_flips <- sample(c(0, 1), 300, replace = TRUE)
die_rolls <- sample(c(1:6), size = 300, replace = TRUE)

# Convert 0s to Tails and convert 1s to Heads:

coin_flips[coin_flips == 0] <- "Tails"
coin_flips[coin_flips == 1] <- "Heads"

# Create data.frame before table:

results_df <- data.frame(coin_flips, die_rolls)

head(results_df)
tail(results_df)

# Change column names:

colnames(results_df) <- c("Coin_Flip", "Roll_Number")

# Create Table:

results_table <- table(results_df)

results_table

# Use Melt Function To Convert Table Into A Three Column Data Frame
# With Coin_Flip Outcome, Die Roll Number and Number Of Times

melted_table <- melt(results_table)

melted_table

# Change Third column name from value to Count:

names(melted_table)[names(melted_table) == "value"] <- c("Count")

# Verify:

melted_table

# Check structure of data:

str(melted_table)

# Change Roll_number to factors:

melted_table$Roll_Number <- factor(melted_table$Roll_Number)

# ggplot Heatmap Grid:

library(ggplot2)

ggplot(melted_table, aes(x = Coin_Flip, y = Roll_Number, fill = Count)) +
  geom_tile() +
  scale_x_discrete(labels = c("Heads", "Tails")) +
  scale_y_discrete(labels = c("One","Two","Three","Four","Five","Six")) +
  scale_fill_gradient2(midpoint = median(melted_table$Count), mid="grey70", 
                       limits = c(min(melted_table$Count), max(melted_table$Count))) +
  labs(x = "\n Coin Flip Result", y = "Die Roll Number \n", 
       title = "Coin Flip and Die Roll Results (300 Times) \n",
       fill = "\n Count \n") +
  theme(plot.title = element_text(hjust = 0.5), 
        axis.title.x = element_text(face="bold", colour="darkgreen", size = 12),
        axis.title.y = element_text(face="bold", colour="darkgreen", size = 12),
        legend.title = element_text(face="bold", colour="brown", size = 10)) +
  geom_text(aes(x = Coin_Flip, y = Roll_Number, label = Count), color = "black", 
            fontface = "bold", size = 5) 

