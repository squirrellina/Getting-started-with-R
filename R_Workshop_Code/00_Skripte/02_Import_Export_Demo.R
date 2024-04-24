# R-Workshop "Einfuehrung in R - Datenverarbeitung und grundlegende Statistiken"
# 04. - 06.07.2022
# Innsbrucker Summer Seminar zu Methoden der empirischen Sozial- und Bildungsforschung 2022

# Datenimport und -export, Beispiele auf den Folien
# GVE, ERO, 04.07.2022

# Pfade einlesen

getwd()
pfad <- "T:/A_REFERAT/09_Workshops_Lehre/2022/Summer_School_Innsbruck/Einfuehrung_in_R/R_Workshop_Code/01_Datensaetze"
pfad <- "01_Datensaetze"
pfad <- here::here("01_Datensaetze")


list.files(pfad)
grep("pirates", list.files(pfad, full.names = TRUE), value = TRUE)


# Einlesen einer Textdatei
data <- read.table("01_Datensaetze/MeineDaten.txt", header = TRUE)
data <- read.table(file.path(pfad, "MeineDaten.txt"), header = TRUE)
data
str(data)


# Schreiben / Einlesen einer .csv-Datei
getwd()
write.csv2(data, "MeineDaten.csv")
write.csv2(data, "MeineDaten.csv", row.names = FALSE, na = "") 
data <- read.csv2("MeineDaten.csv")


# .xlsx-Dateien einlesen
library("openxlsx")
data <- read.xlsx("01_Datensaetze/bfik.xlsx", sheet = 1)

# .xlsx schreiben, z.B. Liste
write.xlsx(list(bfik = data, codebook = 1:24), "bfik_plus.xlsx")


# .RData-Datei schreiben / einlesen
data <- list(vec = seq(1:40), dfr = data.frame(matrix(1:16, 4, 4)))
getwd()

save(data, file = "EinListenobjekt.RData")
#rm(list = ls())
load(file = "EinListenobjekt.RData")


# SPSS-Dateien einlesen
library("foreign")
data <- read.spss("01_Datensaetze/bfik.sav", 
                  to.data.frame = TRUE,
                  use.value.labels = FALSE)
attr(data$sex, "value.labels")


# Datensaetze selber anlegen
data <- data.frame()

edit(data)   # Aenderungen werden nicht gespeichert
data <- edit(data)   # Aenderungen werden gespeichert

fix(data)   # Aenderungen werden gespeichert
