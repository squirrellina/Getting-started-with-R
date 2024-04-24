# Beschreibung des Skripts
# Autor
# Datum

# Grundgeruest ####
# Packages laden
library("openxlsx")
# Pfade setzen
pfad <- 
  "C:/Projekte/WS_Einfuehrung_in_R"
setwd(pfad)

# Daten einlesen ####
dat0 <- read.xlsx("meine_daten.xlsx", sheet = 1)

# Daten aufbereiten ####
dat <- dat0[1:3, ]   # Daten auswaehlen

# Berechnungen durchfuehren ####
model1 <- lm(y ~ x, data = dat)

# Speichern #####
save(model1, file = "Ergebnisse.Rdata")