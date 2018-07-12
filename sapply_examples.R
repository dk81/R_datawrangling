# sapply Functions In R With Examples

# sapply(column, function)

library(ggplot2) # For plotting

#### Example One:


# Create dataframe:

df <- data.frame(x = 1:10)

# Function for x^2:

x_squared <- function(x){
  return(x^2)
}

# Change second column from xvalues to its squared values with sapply:

df$y <- sapply(df$x, x_squared)

# View dataframe:
df

# ggplot Plot:

library(ggplot2)

ggplot(data = df, aes(x = x, y = y)) +
  geom_point() +
  geom_line(col = "red") +
  annotate("text", x = 5, y = 85, parse = TRUE, size = 7, fontface ="bold",
           label= "y == x^2") +
  theme_bw()

#--------------------------------------
#### Example Two (Anonymous Function):

df2 <- data.frame(x = 1:20)


# Change second column to its square root values with sapply and an anonymous function:

df2$y <- sapply(df2$x, function(x){sqrt(x)})

df2

# ggplot Plot:

ggplot(data = df2, aes(x = x, y = y)) +
  geom_point() +
  geom_line(col = "red") +
  annotate("text", x = 15, y = 2, parse = TRUE, size = 7, fontface ="bold",
           label= "y == sqrt(x)") +
  theme_bw()


#--------------------------------------
#### Example Three:

grades <- c(62, 87, 39, 57, 80, 82, 77, 72, 70, 69, 64, 70, 59, 61)

grades_df <- data.frame(Grades = grades)

# Pass is 60 instead of regular 50.

passFail <- function(num_grade){
  if(num_grade < 60){
    return("Fail")
  } else{
    return("Pass")
  }
}

# Using sapply to determine letter grade from number grade

grades_df$status <- sapply(grades_df$Grades, passFail)

grades_df


#### Example Four (BMIs):
# Reference: https://www.nhlbi.nih.gov/health/educational/lose_wt/BMI/bmicalc.htm?source=quickfitnesssolutions

bmis <- c(17, 21.4, 18.2, 28.1, 30.6, 32.1, 22.3, 21, 23.2, 25.7, 31.7, 19.9, 26.2, 27.8)

bmis_df <- data.frame(Body_Mass_Index = bmis)

# Assign BMI number to status condition with a function

bmi_status <- function(bmi){
  if(bmi < 18.5){
    return("Underweight")
  } else if (bmi >= 18.5 & bmi <= 24.9){
    return("Normal Weight")
  } else if (bmi >= 18.5 & bmi <= 24.9){
    return("Normal Weight")
  } else if (bmi >= 25 & bmi <= 29.9){
    return("Overweight")
  } else {
    return("Obese")
  }
}

# Using sapply to determine weight status given a BMI score in bmi column.

bmis_df$Status <- sapply(bmis_df$Body_Mass_Index, bmi_status)

# View/Check
bmis_df