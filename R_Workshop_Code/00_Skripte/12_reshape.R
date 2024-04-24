# R-Workshop "Getting started with R"
# 24-04-2024
# RLadies

# Reshaping data with dplyr and tidyr
# GVE, ERO, 2024


# load packages -----------------------------------------------------------

library(dplyr)
library(tidyr)
library(openxlsx)


# load data ---------------------------------------------------------------

getwd()
dat_long <- read.xlsx("01_Datensaetze/long_format.xlsx")



# long format to wide format ----------------------------------------------

dat_long %>% 
  head()

# I want 1 row per id. (with columns: rawscore_math, rawscore_german etc.)

dat_wide <- 
  dat_long %>% 
  pivot_wider(names_from = subject, values_from = c(rawscore, scalescore))

write.xlsx(dat_wide, "01_Datensaetze/wide_format.xlsx")  


# wide format to (very) long format ----------------------------------------------

dat_wide <- read.xlsx("01_Datensaetze/wide_format.xlsx")

dat_longer <- 
  dat_wide %>% pivot_longer(!id, names_to = "score_subject", values_to = "value")

write.xlsx(dat_longer, "01_Datensaetze/verylong_format.xlsx")  

# to get to where I was before
library(stringr)

dat_longer %>% 
  mutate(score = str_extract(score_subject, "(.*)_(.*)", group = 1), 
         subject = str_extract(score_subject, "(.*)_(.*)", group = 2)) %>% 
  select(-score_subject) %>% 
  pivot_wider(names_from = score, values_from = value) %>% 
  filter(!(is.na(rawscore) & is.na(scalescore)))

