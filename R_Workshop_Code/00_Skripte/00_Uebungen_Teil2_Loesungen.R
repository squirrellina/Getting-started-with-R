# R-Workshop "Einfuehrung in R - Datenverarbeitung und grundlegende Statistiken"
# 04. - 06.07.2022
# Innsbrucker Summer Seminar zu Methoden der empirischen Sozial- und Bildungsforschung 2022

# Loesungen fuer Uebungen in Teil 1
# GVE, ERO, 04.07.2022

# Grundgeruest -------------------------------------------------------------------
getwd()   # sollte in dem Ordner sein, in dem Projekt liegt (R_Workshop_Code)

# Übung Tabellen -------------------------------------------------------------------

penguins <- read.csv2("01_Datensaetze/penguins.csv")

head(penguins)

# Kreuztabelle generieren, mit und ohne fehlende Werte
tab1 <- table(penguins$species, penguins$sex)
tab2 <- table(penguins$species, penguins$sex, useNA = "a")
tab2

# Randhaeufigkeiten
addmargins(tab2)

# relative Haeufigkeiten mit 2 Nachkommastellen 
tab3 <- round( prop.table(tab2), 2)

prop.table(tab2, margin = 1)
prop.table(tab2, margin = 2)


# Tab3 in Prozentwerte
tab3*100


# Übungen Inferenz Statistik ----------------------------------------------

# Nr. 1: Daten laden
pirates <- read.csv2("01_Datensaetze/pirates.csv")  #Datensatz von Festplatte laden

# Nr. 2: lineare Regression "weight durch height vorhersagen" 
mod <- lm(weight ~ height, data = pirates)
summary(mod)
coefficients(mod)

# Plot zu Regression
plot(pirates$weight ~ pirates$height, data = pirates, pch=19) #, xlim=c(0,40))
abline(mod, col="red")

# Nr. 3: lineare Regression "tattoos durch height vorhersagen" 
mod <-  lm(tattoos ~ height, data = pirates)
summary(mod)
coefficients(mod)

# Plot zu Regression
plot(tattoos ~ height, data = pirates, pch=19) #, xlim=c(0,40))
abline(mod, col="red")

# Nr. 4: t-Test: Unterscheiden sich maennliche und weibliche Piraten in Bartlaenge?
dat <- pirates[pirates$sex %in% c("male", "female"), ]
t.test(beard.length ~ sex, data = dat)

# Nr. 5: sind Geschlecht und Uni unabhaengig voneinander?
library(foreign)
dat <-  read.spss(file = "01_Datensaetze/bfik.sav", to.data.frame = T, use.missings = T, use.value.labels = F)

dat$sex[dat$sex == 99] <- NA
tab1 <- table(dat$uni, dat$sex)

chisq.test(tab1)

# Übung Grafiken ----------------------------------------
# Balkendiagramm mit Legende
tab1
barplot(tab1, 
        col = c("red", "green"))
legend("topleft", legend = rownames(tab1), 
       col = c("red", "green"), pch = 15)

# Histogramm und Density Plot fuer zuf
library(foreign)
zuf <-  read.spss(file = "01_Datensaetze/zuf.sav", 
                  to.data.frame = T, 
                  use.missings = T, 
                  use.value.labels = F)
par(mfcol = c(1, 2))
hist(zuf$swls)
car::densityPlot(zuf$fs)

# WorldPhones
data(WorldPhones)
dat <- WorldPhones

par(mfcol = c(1, 1))
dat_red <-dat[, c("N.Amer", "Europe")]
barplot(t(dat_red),
        col = c("blue", "green"),
        legend = colnames(dat_red),
        beside = TRUE)


# freies Explorieren
# Penguins
penguins <- as.data.frame(palmerpenguins::penguins)
View(penguins)

# Correlogram
# http://www.sthda.com/english/wiki/visualize-correlation-matrix-using-correlogram
#install.packages("corrplot")
library("corrplot")
cor_mat <- cor(penguins[, 3:6], use = "pairwise")
corrplot(cor_mat, method="circle")
corrplot(cor_mat, method="number")
corrplot(cor_mat, method="circle", type = "upper")

library(ggplot2)

# Zusammenhang zwischen Schnabeltiefe und Flossenlaenge nach Spezies
# Scatterplot mit Gruppierung nach Spezies und Regressionslinien
ggplot(penguins, 
       aes(x = flipper_length_mm, y = bill_depth_mm, color = species)) + 
  geom_point() +
  geom_smooth(method = "lm", alpha = 0.1) + 
  theme_classic()

# Boxplot Schnabeltiefe nach Spezies
ggplot(penguins, 
       aes(x = species, y = bill_depth_mm, color = species)) + 
  geom_boxplot() +
  theme_classic()

# Verteilung der Schnabeltiefe nach Spezies
# Violinplot mit Punkt-Overlay nach Kategorie
ggplot(penguins, 
       aes(x = species, y = bill_depth_mm, fill = species)) + 
  geom_violin() +
  geom_jitter(alpha = 0.3) + 
  theme(legend.position = "none") + 
  theme_classic()

# Histogramm des Gewichts der Pinguine
ggplot(penguins,
       aes(x = body_mass_g)) + 
  geom_histogram(fill = "blue", alpha = 0.3) + 
  theme_classic()


# Übung Schleifen ----------------------------------------------------------------

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





