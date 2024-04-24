#*******************************************************************************
# Titel/Beschreibung des Skripts, Autor + Datum
#*******************************************************************************

# evtl: kurze Zusammenfassung, was in dem Skript passiert


#*******************************************************************************
# Grundgeruest / Setup ####
{
  # Packages laden
  pacman::p_load(here,
                 janitor,
                 openxlsx,
                 psych, 
                 ggplot2)
  
  # Pfade setzen
  pfad <- here::here()   # falls in einem Projekt
  pfad <- 
    "T:/A_REFERAT/09_Workshops_Lehre/2022/Summer_School_Innsbruck/Einfuehrung_in_R/Code"
  # falls ohne Projekt
  
  pf_roh <- file.path(pfad, "01_Rohdaten")
  pf_in <- file.path(pfad, "02_Aufbereitet")
  pf_out <- file.path(pfad, "03_Ergebnisse")
  # oder aehnlich, je nach Beduerfnis und Groesse des Projekts
  
  setwd(pfad)   # falls nicht in einem Projekt
  
  # Optionen 
  # falls Bedarf da
  
  # falls man sich beim Rechnen das Herausschreiben offenhalten will
  schreiben <- TRUE    # FALSE
  # Lieblings-ggplot-Theme
  theme_set(theme_minimal())   # ggplot-Theme fuer Skripte mit vielen Grafiken
  #... 
  
  
  # Funktionen
  # z.B. eigene Funktionen oder andere defaults fuer vorhandene Funktionen
  tnable <- function(..., useNA = "a"){
    return(base::table(..., useNA = useNA))
  }
}

#*******************************************************************************
# Daten einlesen ####
{
  # meine Daten
  dat0 <- read.csv2(file.path(pf_roh, "meine_rohdaten.csv"))
  
  # meine Fragebogen-Daten dazu
  fragebogen <- read.xlsx(file.path(pf_roh, "mein_fragebogen.xlsx"), sheet = 1)
}

#*******************************************************************************
# Daten aufbereiten ####
{
  # Sortieren
  # Filtern
  # Rekodieren
  # Variablen erstellen
  # Zusammenfuegen
  # ...
  dat <- dat0[!is.na(dat0$meine_filtervariable), ]   
}

#*******************************************************************************
# Berechnungen ####
{
  # lineares Modell, um y durch x vorherzusagen
  model1 <- lm(y ~ x, data = dat)
  summary(model1)
}


# evtl Grafiken


# Speichern ####
{
  save(model1, file = file.path(pf_out, "meine_Ergebnisse.Rdata"))
}
