# R-Workshop "Einfuehrung in R - Datenverarbeitung und grundlegende Statistiken"
# 04. - 06.07.2022
# Innsbrucker Summer Seminar zu Methoden der empirischen Sozial- und Bildungsforschung 2022

# Datenaufbereitung, Beispiele auf den Folien
# GVE, ERO, 04.07.2022

# Grundgeruest 
{
  # install.packages("janitor")
  # install.packages("foreign")
  # install.packages("car")
  
  library("janitor")
  library("foreign")
  library("car")
}

# Daten kennenlernen
{
  str(iris)   # Datentypen, Datenstruktur anzeigen
  names(iris)   # Variablennamen
  head(iris)   # erste 6 Faelle anzeigen
  tail(iris)   # letzte 6 Faelle anzeigen
  dim(iris)   # Zeilen-, Spaltenanzahl
  class(iris)   # Datenstruktur
}

# Namen aufraeumen
{
  iris
  names(iris)
  names(clean_names(iris))
  # fuer eine Anwendung auf Vektoren: janitor::make_clean_names()
}

# fehlende Daten
{
  a <- c(2, 4, NA, 5, 10, NA)
  
  # fehlende Daten finden
  is.na(a)   # zeige Missings
  
  which(is.na(a))   # welche Werte sind Missings?
  sum(is.na(a))   # wieviele Werte sind Missing?
  sum(!is.na(a))   # wie viele Werte sind gueltig?
  mean(is.na(a))   # welcher Anteil ist Missing?
  
  
  # fehlende Daten rekodieren
  bfik <- read.spss("01_Datensaetze/bfik.sav", 
                    to.data.frame = TRUE,
                    use.value.labels = FALSE)
  
  bfik
  is.na(bfik)   # is.na mit Data Frame als Input
  sum(unlist(is.na(bfik)))   # wieviele NAs sind im Datensatz?
  apply(bfik, 2, function(x) sum(is.na(x)))   # vorgegriffen: NAs pro Spalte
  
  bfik[bfik == 99] <- NA   # GEFAEHRLICH: Werte jeder Variablen werden ersetzt
  
  bfik1 <- bfik[, 4:24]   # bestimmte Spalten auswaehlen
  bfik1[bfik1 == 99] <- NA   # Werte ersetzen
  bfik2 <- cbind(bfik[, 1:3], bfik1)   # neuer Datensatz
  
  bfik[, 2][which(bfik[, 2] == 99)] <- NA
  
  # alle Zeilen mit Missings ausschliessen
  bfik3 <- na.omit(bfik)
  
  # Imputieren?
  ??mice
}

# Rekodieren
{
  a <- c(1, 1, 1, 1, 2, 2, 2, 2)
  b <- recode(a, "1=2; 2=1")
  rbind(a, b)
  
  ifelse(a == 1, 2, 1)
 
}

# Sortieren
{
  kgr <- c(155, 164, 187, 194, 160, 166)
  sort(kgr, decreasing = FALSE)
  sort(kgr, decreasing = TRUE)
  
  order(kgr)
  kgr[order(kgr)]
  
  bfik_sortiert <- bfik[order(bfik$alter),]
  bfik_sortiert <- bfik[order(bfik$sex, bfik$alter, bfik$uni),]
}

# neue Variablen bilden / Skala bilden
{
  items <- c("bfik01", "bfik02", "bfik03", "bfik04")
  items <- paste0("bfik0", 1:4)
  
  bfik$skala_bfik <- rowSums(bfik[, items], na.rm = TRUE)
  bfik$skala_bfik <- rowMeans(bfik[, items], na.rm = TRUE)
}