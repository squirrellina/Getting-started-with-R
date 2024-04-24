# R-Workshop "Einfuehrung in R - Datenverarbeitung und grundlegende Statistiken"
# 04. - 06.07.2022
# Innsbrucker Summer Seminar zu Methoden der empirischen Sozial- und Bildungsforschung 2022

# Statistiken: deskriptiv und Inferenzstatistiken
# GVE, ERO, 04.07.2022

# Pakete laden -------------------------------------------------------
library(foreign)
library(vcd)
library(psych)


# Pfade setzen -------------------------------------------------------
getwd()
#pfad.data <- "T:/A_REFERAT/09_Workshops_Lehre/2022/Summer_School_Innsbruck/Einfuehrung_in_R/R_Workshop_Code/01_Datensaetze"
pfad.data <- "01_Datensaetze"


# Daten laden --------------------------------------------------------
zuf <- read.spss(file = file.path(pfad.data, "zuf.sav"),   to.data.frame = TRUE, use.value.labels = FALSE)
bfik <- read.spss(file = file.path(pfad.data, "bfik.sav"),   to.data.frame = TRUE, use.value.labels = FALSE)
data(Arthritis)
penguin <- read.csv2("T:/A_REFERAT/09_Workshops_Lehre/2022/Summer_School_Innsbruck/Einfuehrung_in_R/R_Workshop_Code/01_Datensaetze/penguins.csv")
pirates <- read.csv2("01_Datensaetze/pirates.csv") 

# -------------------------------------------------------------------------

x <- c(3, 5, 7, 6)
mean(x, na.rm=TRUE)


y <- c(3, 5, 7, 6, NA)
mean(y)
mean(y, na.rm=TRUE)

median(x)
quantile(x)
summary(x)

range(x)
var(x)

a <- data.frame ("Spalte1" = c(0, 1, 0, 0, 1, 0), "Spalte2" = c(0, 0, 0, 1, 1, 1))
print(a)
rowMeans(a)
round(colMeans(a), 2)

library(psych)
describe(a$Spalte1)
summary(a)


# Tabellen --------------------------------------------------------------

library(vcd) # visualizing categorical data
data(Arthritis)
head(Arthritis)

# oneway

mytable <- table(Arthritis$Improved)
proptable <- round(prop.table(mytable), 3)
prop100 <- proptable * 100

# twoway

mytable <- table(Arthritis$Improved, Arthritis$Treatment)
#mytable <- xtabs(~Treatment + Improved, data = Arthritis)

addmargins(mytable)

#alles zusammen
addmargins(prop.table(mytable, margin = 2)) #margin = 2. Jede Spalte ergibt 100%


# Gruppenweise Berechnungen -----------------------------------------------

# Mittleres Alter pro Treatment-Gruppe
tapply(Arthritis$Age, Arthritis$Treatment, mean)

tapply(Arthritis$Age, Arthritis$Treatment, sd)


res <- tapply(Arthritis$Age, Arthritis$Treatment, function(x) mean(x))

res <- tapply(Arthritis$Age, Arthritis$Treatment, function(x) mean(x, na.rm=TRUE))

# mehrere Gruppierungsvariablen
tapply(Arthritis$Age, list(Arthritis$Treatment, Arthritis$Sex), mean)


# Übung Tabellen -------------------------------------------------------------------

#penguin <- read.csv2("T:/A_REFERAT/09_Workshops_Lehre/2022/Summer_School_Innsbruck/Einfuehrung_in_R/R_Workshop_Code/01_Datensaetze/penguins.csv")

head(penguin)
tab1 <- table(penguin$species, penguin$sex)
tab2 <- table(penguin$species, penguin$sex, useNA = "always")
tab2

addmargins(tab2)

tab3 <- round( prop.table(tab2), 2 )
tab3*100



# Inferenzstatistik -------------------------------------------------------

library (vcd)
data ("Arthritis")
head(Arthritis)

mytable <- xtabs( ~ Treatment + Improved, data = Arthritis)

mytable <- table(Arthritis$Treatment, Arthritis$Improved)

table(Arthritis$Treatment, Arthritis$Improved, useNA = "ifany")
table(Arthritis$Treatment, Arthritis$Improved, useNA = "always")

chisq.test(mytable)


fisher.test(mytable)

# Kovarianz und Korrelation ----
#zuf <- read.spss(file = file.path(pfad.data, "zuf.sav"),   to.data.frame = TRUE, use.value.labels = FALSE)

var(zuf$swls)
sd(zuf$swls)

cov(zuf$swls, zuf$fs)
cor(zuf$swls, zuf$fs)

cor.test(zuf$swls, zuf$fs)

bfik1 <- bfik[, 20:24]
bfik1 <- bfik[, (ncol(bfik)-4):ncol(bfik)]  #allgemeiner geschrieben
bfik1 <- na.omit(bfik1)  #Zeilen mit NA werden entfernt
round(cor(bfik1), 2)

# T-tests ----------------------------------------------------

# Daten laden
#install.packages(yarrr)
pirates <- yarrr::pirates  #Datensatz aus package laden
pirates <- read.csv2("01_Datensaetze/pirates.csv")  #Datensatz von Festplatte laden

# 1 sample t-test
# Are pirate ages different than 30 on average?
t.test(x = pirates$age,
       mu = 30)

# für unabhängige Stichproben
# 2 sample t-test
# Do females and males have different numbers of tattoos?
table(pirates$sex)
dat <- pirates[pirates$sex %in% c("male", "female"), ]
table(dat$sex)

pirate.ttest <- t.test(formula = tattoos ~ sex,  
                       data = dat)
pirate.ttest # Print result


# Regression ----------------------------------------------------

# pirates <- yarrr::pirates  #Datensatz aus package laden
# pirates <- read.csv2("01_Datensaetze/pirates.csv")  #Datensatz von Festplatte laden

mod1 <- lm(tchests ~ sword.time, data = pirates)
summary(mod1)
coefficients(mod1)

# plot
plot(pirates$tchests ~ pirates$sword.time, pch=19) 
abline(mod1, col="red")

plot(tchests ~ sword.time, data=pirates, pch=19) 
abline(mod1, col="red")

# mehr als 1 Praediktor
mod2 <- lm(beard.length ~ age + height, data = pirates)
summary(mod2)
coefficients(mod2)



# Übungen Inferenz Statistik ----------------------------------------------

# Nr. 1
pirates <- read.csv2("01_Datensaetze/pirates.csv")  #Datensatz von Festplatte laden

# Nr. 2
mod <- lm(weight ~ height, data = pirates)
summary(mod)
coefficients(mod)

plot(pirates$weight ~ pirates$height, data = pirates, pch=19) #, xlim=c(0,40))
abline(mod, col="red")

# Nr. 3
mod <-  lm(tattoos ~ height, data = pirates)
summary(mod)
coefficients(mod)

plot(tattoos ~ height, data = pirates, pch=19) #, xlim=c(0,40))
abline(mod, col="red")


# Nr. 4
dat <- pirates[pirates$sex %in% c("male", "female"), ]
t.test(beard.length ~ sex, data = dat)

# Nr. 5
library(foreign)
dat <-  read.spss(file = "01_Datensaetze/bfik.sav", to.data.frame = T, use.missings = T, use.value.labels = F)

dat$sex[dat$sex == 99] <- NA
tab1 <- table(dat$uni, dat$sex)

chisq.test(tab1)


# Programmieren -------------------------------------------------------------------------
# for Schleife ----

for(ii in 1:5){
  print(ii)
}


# Fibonacchi Reihe
f <- c(1,1)
for(nn in 3:10){
  #nn <- 3
  f[nn] <- f[nn-1] + f[nn-2]
}
plot(f)

# Beispiel Plots

par(mfcol=c(2,2))
vars <- c("geschl", "alter", "swls", "fs")

for(ii in vars){
  #   ii <- vars[1]
  dat <- zuf[, ii]
  hist(dat, main=ii)
  print(ii)
}

# while Schleife----
ii <- 1
while(ii < 5){
  #pruefung der Bedingung zu Beginn
  print(ii)
  ii <- ii + 1
}

# if Schleife----
x <- sample(c(TRUE, FALSE), 1)

if(x == TRUE) {print("x was true!")}
if(x == FALSE) {print("x was false!")}



# apply-Familie --------------------------------------------------
vars <- c("alter", "swls", "fs")
apply(zuf[,vars], MARGIN = 2, min, na.rm=T)

apply(zuf[,vars], MARGIN = 2, function(x) min(x, na.rm=T)) #andere Schreibweise.

# # Funktionen ----------------------------------------------------------
# #meineFunktion <- function(input){Berechnung, Output}
# 
# desc <- function(x){
#   m <- mean(x)
#   s <- round( sd(x), 3)
#   hist(x)
#   dfr <- data.frame("M"=m, "SD"=s)
#   return(dfr)
# }
# 
# vec <- c(1,2,5,4,3,2,1,5,6,1)
# results <- desc(vec)
# 
# desc2 <- function(x, print=FALSE){
#   m <- round( mean(x), 3)
#   s <- round( sd(x), 3)
#   hist(x)
#   dfr1 <- data.frame("M"=m, "SD"=s)
#   tr <- log(x)
#   out <- list(dfr1, tr)
#   
#   if(print){
#     cat("Die Ergebnisse:\n")
#     print(out)
#   }
#   
#   return(out)
# }
# 
# res2 <- desc2(vec)
# res2 <- desc2(vec, print = T)
# 
# desc
# 
# zuf.res <- desc2(zuf$swls)
# zuf.res[[1]]
# 
# desc3 <- function(x, print=FALSE,...){
#   m <- round( mean(x), 3)
#   s <- round( sd(x), 3)
#   hist(x,...)
#   dfr1 <- data.frame("M"=m, "SD"=s)
#   tr <- log(x)
#   out <- list(dfr1, tr)
#   
#   if(print){
#     cat("Die Ergebnisse:\n")
#     print(out)
#   }
#   
#   return(out)
# }
# 
# res3 <- desc3(zuf$swls, print=F, 
#               col="red", main="Mein Titel")


# Übung ----------------------------------------------------------------

#Nr. 1
for (i in 1:10) {
  print(paste(i, i^2))
}

# Nr. 2
a <- as.vector((1:10))

a.sample <- sample(a, 1)
print(a.sample)

if (a.sample < 5){
  print("Zahl ist kleiner als 5")
}


