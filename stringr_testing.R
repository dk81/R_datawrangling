# The stringr Package In R:

# Me playing around and testing some functions in R's stringr package.

library(stringr)

## Length of strings:

str_length("Hello")

str_length(c("Green", NA, "R", "Programming"))


## Converting cases in a string:

word <- "Green"

print(str_to_upper(word)) # Uppercase

print(str_to_lower(word)) # Lowercase

print(str_to_title(word)) # Title, first letter upper case, rest lowercase

# invert_match function dont know; from str_locate_all:

## Join multiple strings into a single string:
## R Documentation examples use letters.

## My example:

fibonacci_ten <- c("1", "1", "2", "3", "5", "8", "13", "21", "34", "55")

str_c("Number: ", fibonacci_ten)

str_c("Number", fibonacci_ten, sep = " - ")

str_c("The number ", fibonacci_ten, " is a Fibonacci number.")

str_c(fibonacci_ten[-10], " is less than or equal to ", fibonacci_ten[-1])

str_c(c("1", NA, "10"), "2") # missing values cases = missing outputs, concatenate strings

## Str_conv


## Number of matches in a string using str_count():

fruit <- "strawberry"

str_count(fruit, pattern = "r") # Find r's

str_count(fruit, pattern = "w") # Find w's

str_count(fruit, pattern = c("w", "a", "y", "r")) # Find w's, a's, y's and r's

colours <- c("green", "red", "blue", "purple", "orange", "yellow", "teal")

str_count(colours, pattern = "e") # Find number of e's in colours; output is a vector

str_count(colours, pattern = "l") # Find number of l's in colours

## Detect matches in a string using str_count(). Output is a logical vector.
## Regular expressions can be used too.

item <- "chair"

str_detect(item, pattern = "a") # Is there an a?

str_detect(item, pattern = "y") # Is there a y?

str_detect(item, pattern = "[aeiou]") # Is there a vowel?

str_detect(item, pattern = "^c") # Is there a starting c?

str_detect(item, pattern = "c$") # Is there an ending c?

str_detect(c(item, "TV"), pattern = "^c") # Is there a starting c?

## Duplicating and combining strings:
# These examples are similar to the R documentation examples.

food <- c("Pizza", "Chicken", "Noodles", "Salad")

str_dup(food, 2) # Double

str_dup(food, 1:4) # Single for Pizza, 2x Chicken, 3x Noodles, 4x Salad

str_c(food, str_dup("!", 1:4)) # Add exclamation marks to food items.

## Extract the matching pattern from string:
# Can use regular expressions; more examples in documentation.

colours <- c("green", "red", "blue", "purple", "orange", "yellow", "teal")

str_extract(string = colours, pattern = "e") # Extract letter e.

str_extract(string = colours, pattern = "[aeiou]") # Extract vowels.

str_extract_all(string = colours, pattern = "e") # Extract all cases of letter e.

str_extract_all(string = colours, pattern = "[aeiou]") # Extract all vowel cases.

# String interpolation (don't know):

# Locating the position of patterns in a string:

colours <- c("green", "red", "blue", "purple", "orange", "yellow", "teal")

str_locate(colours, "e") # Find position of e.

str_locate(colours, "a") # Find position of a.

# Find cases of letter e in green, d in red, u in blue, p in purple and so on:

str_locate(colours, c("e", "d", "u", "p", "n", "y", "l")) 


str_locate_all(colours, "e") # Find positions of e in each colour in colours.

str_locate_all(colours, "o") # Find positions of o in each colour in colours.



## String matching:

str_match(string = "yellow", pattern = "ll")

str_match_all(string = "parallelogram", pattern = "l")

## String Order/Sort:

# Template Code: str_order(x, decreasing = FALSE, na_last = TRUE, locale = "", ...)
#                str_sort(x, decreasing = FALSE, na_last = TRUE, locale = "", ...)
# Don't know what locale is.

five_numbers <- as.character(c(1:5))
five_numbers 

# Order from highest to lowest, decr is FALSE by default:

str_order(five_numbers, decreasing = TRUE) # Gives positions in vector.
str_sort(five_numbers , decreasing = TRUE) # Outputs each number in vector.

# Example - Ordering numbers as strings is bad. 

str_sort(as.character(c(1:10)), decreasing = TRUE)

# Ordering objects:

objects <- c("Box", "TV", "Computer", "Phone", "Oven")

# ABC order:

str_order(objects) # Gives positions in vector.
str_sort(objects) # Outputs each item in vector.

# ZYX Order:

str_order(objects, decreasing = TRUE) # Gives positions in vector.
str_sort(objects , decreasing = TRUE) # Outputs each item in vector.


## Padding a string:

# Template: str_pad(string, width, side = c("left", "right", "both"), pad = " ")

str_pad("Jello", width = 7, side = "right", pad = "!")
str_pad("Jello", width = 7, side = "left", pad = "J")

# Add 2 Js both sides and 2 !s both sides a vector with 2 elements.

str_pad("Jello", width = 9, side = "both", pad = c("J", "!"))

# Making JJJello!!. Inside str_pad makes Jello!!, Outside one adds 2 Js to Jello!!:

str_pad(str_pad("Jello", width = 7, side = "right", pad = "!"), 
        width = 9, side = "left", pad = "J")


## String Replace:

term <- "yellowjello"

# Replace "ll" with blank space:

str_replace(term, pattern = "ll", replacement = "") # First instance
str_replace_all(term, pattern = "ll", replacement = "") # All instances

# Replace "ll" with "nn" :

str_replace(term, pattern = "ll", replacement = "nn")
str_replace_all(term, pattern = "ll", replacement = "nn")

## String Split - Split strings into pieces.

# Template: str_split(string, pattern, n = Inf, simplify = FALSE)

str_split("Hannah Banana", pattern = " ") 

str_split("ABC", pattern = "") # Split into each character


oils <- "Canola, Sunflower, Avocado, Sesame, Olive, Castor, Peanut"

str_split(oils, pattern = ", ")

str_split(oils, pattern = ", ", n = 2)

str_split(oils, pattern = ", ", n = 1) # One vector

str_split(oils, pattern = ", ", n = 3)

str_split(oils, pattern = ", ", n = 3, simplify = TRUE) # Return character matrix

# The fixed version returns a character matrix vs character vectors:

str_split_fixed(string = oils, pattern = ", ", n = 3)

str_split_fixed(string = oils, pattern = ", ", n = 2)

## String Sub:
# Extract & replace substrings from a character vector.

name <- "Roger Federer"

str_sub(name, start = 1, end = 5) # Roger

str_sub(name, start = 7, end = 13) # Federer

# str_count(name) = 13; Output is Federer:

str_sub(name, start = 7, end = str_length(name)) 

# Fed:

str_locate(name, pattern = "Fed") #7 and 9:

str_sub(name, start = 7, end = 9) 


## String Trim to trim whitespace at start and end of a string:

test <- " Hi "

str_trim(test, "left")
str_trim(test, "right")
str_trim(test, "both")

test_cases <- c(" Hi ", " Hey! ")

str_trim(test_cases, "left")
str_trim(test_cases, "right")
str_trim(test_cases, "both")


## String Truncate: Extract a number of characters from a string:

# Template: str_trunc(string, width, side = c("right", "left", "center"), ellipsis = "...")

long_sentence <- "This is a very long sentence with many different letters."

str_trunc(string = long_sentence, width = 25, side = "right")

str_trunc(string = long_sentence, width = 25, side = "left")

str_trunc(string = long_sentence, width = 25, side = "center")

## String View: string matching but output in HTML view


## String Wrap: didn't investigate this.

## word(): Extract words from a sentence.

sentence <- "The cat in a hat is missing."

word(string = sentence, start = 1, end = 2) # Extract first two words.

word(string = sentence, -1) # Extract last word.

word(string = sentence, -3) # Extract third last word.

# Multiple sentences case:

sentence_list <- c("Watch out there!", "Here is my car.")

word(sentence_list, 1) # First word in each sentence.

word(sentence_list, start = 1:2, end = -1) 










