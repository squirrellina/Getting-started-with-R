
# load data from a package ----
data("faithful")
str(faithful)

library(nycflights13)
data("flights")
str(flights)
flights
flights %>% 
  print(n = 1000)  #n = Inf
