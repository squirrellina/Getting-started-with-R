# R-Workshop "Getting started with R"
# 24-04-2024
# RLadies

# Basic Data Transformation with dplyr
# GVE, ERO, 2024


# load packages -----------------------------------------------------------

library(dplyr)

# load data --------------------------------------------------------------
# open project (or give full path)
getwd()

dat <- read.csv2("01_Datensaetze/pirates.csv")


# look at the data----
head(dat)
colnames(dat)

dat %>% 
  count(favorite.pirate)

dat %>% 
  count(headband)

dat %>% 
  count(fav.pixar)

dat %>% 
  count(eye.patch, favorite.pirate) #spelling mistake in column name

dat %>% 
  count(eyepatch, favorite.pirate)


# rename columns----
# rename(data, new_name = old_name)

dat <- 
  dat %>% 
  rename(fav.pirates = favorite.pirate)

head(dat)


# select, filter, summarize , group_by ----

dat %>% 
  select(id, sex, headband, parrots, fav.pirates, fav.pixar, sword.time) %>% 
  filter(sex == "female") %>%   #= vs. ==
  summarize(mean_sword.time = mean(sword.time))

analyses.tab <- 
  dat %>% 
  select(id, sex, headband, parrots, fav.pirates, fav.pixar, sword.time) %>% 
  filter(sex == "female") %>%   
  group_by(fav.pirates) %>% 
  summarize(mean_sword.time = mean(sword.time))


# select with contains ("tidyselect")----

dat %>% 
  select(contains("fav")) %>% 
  head()

# select with all_of, any_of ----
vars <- c("id", "sex", "headband", "parrots", 
          "fav.pirates", "fav.pixar", "sword.time", "somethingelse")

dat %>% 
  select(all_of(vars))

dat %>% 
  select(any_of(vars))



# mutate, recode variables ----

# pirate: Jack Sparrow, or not Jack Sparrow
dat <- 
  dat %>% 
  mutate(fav.jack.sparrow = fav.pirates == "Jack Sparrow", 
         grogg_above_average = grogg > mean(grogg))

# check
dat %>% 
  summarize(mean(grogg))

dat %>% 
  group_by(grogg_above_average) %>% 
  summarize(mean(grogg))

dat %>% 
  group_by(grogg_above_average) %>% 
  summarize(min(grogg), max(grogg))


# replace_na ----

library(dplyr)
library(tidyr)

tt <- data.frame(a = c(1,2,3,NA,5, 6, NA, 8, 9))

tt %>% 
  mutate(b = replace_na(a, 99))

tt %>% 
  mutate(b = case_when(is.na(a) ~ 99,
                       .default = a))

# 99 -> NA

tt %>% 
  mutate(b = case_when(is.na(a) ~ 99, 
                       a == 9 ~ NA,
                       .default = a))

#mutate with case_when (recode) ----
# Monsters, Inc. --> Monsters

dat %>% 
  count(fav.pixar)

dat <- 
  dat %>% 
  mutate(fav.pixar.new = case_when(
    fav.pixar == "Monsters, Inc." ~ "Monsters", 
    .default = fav.pixar
  ))


# shorter version: case_match()
tt %>% 
  mutate(b = case_match(
    a,
    NA ~ 99,
    9 ~ NA,
    .default = a))



# arrange. sort rows ----
# sort by amount of grogg

dat %>% 
  arrange(grogg)

dat %>% 
  arrange(desc(grogg))

dat %>% 
  arrange(grogg, beard.length)


# relocate. sort colums ----
# these colums in front, the rest somewhere after.

dat %>% 
  relocate(id, fav.pirates, fav.pixar, sword.time)



# Exercises ---------------------------------------------------------------

# check how many values the variable parrots has.

# calculate average height in the groups "Has a headband/Has no headband"


# More  -------------------------------------------------------------------

library(tidyr)
pivot_longer()
pivot_wider()
 
