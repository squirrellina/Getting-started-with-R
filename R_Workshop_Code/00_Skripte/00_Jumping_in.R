# R-Workshop "Introduction to R - Data Wrangling and Basic Statistics"
# 24.04.2024
# R-Ladies

# Jumping in!!
# Getting to Know Palmer's Penguins Dataset
# GVE, 24.04.2024

# run code line by line by pressing Ctrl+Enter
# Code in braces can be run all at once or individually
# press Ctrl+Enter when cursor is in the line of the bracket 
# or in a single line 

# Basics ####
{
  # install package 
  install.packages("palmerpenguins")
  
  # load package
  library("palmerpenguins")  
}

# load data ####
{
  # look at help
  ?palmerpenguins
  data(package = 'palmerpenguins')
  
  # load data
  penguins <- as.data.frame(palmerpenguins::penguins)
}

# explore ####
{
  # first look into the dataset
  str(penguins)   # structure of the dataset
  head(penguins)   # first 6 rows
  names(penguins)   # column names
  
  summary(penguins)   # general summary
  
  View(penguins)  # take a look at dataset in a separate window
}

# descriptives ####
{
  # mean of body mass
  mean(penguins$body_mass_g, na.rm = TRUE)
  
  # min and max of body mass
  min(penguins$body_mass_g, na.rm = TRUE)
  max(penguins$body_mass_g, na.rm = TRUE)
  
  # how many penguins are there by species?
  table(penguins$species)
  
  # what is the mean weight by species?
  aggregate(penguins$body_mass_g, list(penguins$species), mean, na.rm = TRUE)
  tapply(penguins$body_mass_g, list(penguins$species), mean, na.rm = TRUE)  
}


# plots
{
  # is there a correlation between flipper and bill length?
  plot(x = penguins$flipper_length_mm, 
       y = penguins$bill_length_mm)
  
  # jazzed-up plot
  plot(x = penguins$flipper_length_mm, 
       y = penguins$bill_length_mm,
       main = "Die Länge von Pinguin-Flossen und -Schnäbeln",
       xlab = "Flossenlänge (in mm)",
       ylab = "Schnabellänge (in mm)",
       pch = 16,
       col = gray(.0, .5))
  
  # colored species
  plot(x = penguins$flipper_length_mm,   # x coordinates
       y = penguins$bill_length_mm,      # y coordinates
       col = penguins$species,
       main = "Die Länge von Pinguin-Flossen und Schnäbeln",
       xlab = "Flossenlänge (in mm)",    # label x axis
       ylab = "Schnabellänge (in mm)",   # label y axis
       pch = 16)                         # point type 
  legend("topleft",
         legend = levels(factor(penguins$species)),
         pch = 16,
         col = factor(levels(factor(penguins$species))))  
  grid()   # Orientierungslinien
  
  # calculate linear model for regression line
  model <- lm(formula = bill_length_mm ~ flipper_length_mm,
              data = penguins)
  
  abline(model, col = "blue")   # regression line
}



# inference statistics
{
  # is there a difference in body mass between female and male penguins?
  t.test(formula = body_mass_g ~ sex,
         data = penguins,
         alternative = "two.sided")
  t.test(x = penguins$body_mass_g[which(penguins$sex == "male")],
         y = penguins$body_mass_g[which(penguins$sex == "female")],
         alternative = "two.sided")
  # yes, there is a significant difference
  
  # deactivate scientific notation
  #options(scipen=999)
  
  # What is the correlation between bill and flipper length? 
  cor.test(penguins$bill_length_mm, penguins$flipper_length_mm, method = "spearman")
  # correlation .66, highly significant
  
  # do different species have different body mass?
  mass_species_model <- lm(formula = body_mass_g ~ species,
                           data = penguins)
  anova(mass_species_model)
  # yes, highly significant
  
  # how do penguin characteristics interact with body mass?
  mass_model <- lm(formula = body_mass_g ~ sex + bill_length_mm + bill_depth_mm + flipper_length_mm,
     data = penguins)
  summary(mass_model)  
  # sex (male +), bill length (-) und flipper length (+) 
  # have a correlation with body mass
}

