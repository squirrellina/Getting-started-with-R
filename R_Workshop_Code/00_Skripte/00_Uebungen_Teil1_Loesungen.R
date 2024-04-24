# R-Workshop "Einfuehrung in R - Datenverarbeitung und grundlegende Statistiken"
# 04. - 06.07.2022
# Innsbrucker Summer Seminar zu Methoden der empirischen Sozial- und Bildungsforschung 2022

# Loesungen fuer Uebungen in Teil 1
# GVE, ERO, 04.07.2022

# Objektnamen ####
{
  # Welche der folgenden Objektnamen sind ungueltig?
  thisone <- 1   # ja
  THISONE <- 2   # ja
  1This <- 3   # nein, Zahl am Anfang
  this.one <- 4   # ja
  This.1 <- 5   # ja
  This/One <- 6   # nein, geteilt-durch-Zeichen
  ThIS...ON...E <- 7   # ja
  This!On!e <- 8   # nein, Sonderzeichen
  lkjasdfkjsdf <- 9   # ja
}

# Zuweisungen ####
{
  # Welche Aufrufe sind gueltig, was bewirken sie?
  d <- 123 -> e   # ja
  pi <= 3.14   # ja
  a <- b <- c <- 567 -> x -> y -> z   # ja
  x <- (5 + 2)   # ja
  2 + 1 <- 3   # nein, Zahlen koennen nicht Objektnamen sein
  3klang <- "c-e-g"   # nein, Zahl am Anfang
  klang <- "c-e-g"   # ja
  ( x <- 5 + 3 )   # ja
  zz <- 13; zz + 1   # ja
  5 <- 3   # nein, Zahl kann nicht Objektname sein
  5 < -3   # ja
}

# erste Berechnungen ####
{
  #Berechnen Sie
  2.6 + 5.8   # 8.4
  (7 - 10.78) / 5   # -0.756
  2^5   # 32
  
  # Pruefen Sie
  6 == 10   # FALSE; doppeltes == ist wichtig hier (sonst waere es eine Zuweisung)!
  (3 * 5) > (9 + 1)   # TRUE
  
  # Erstellen und Berechnen Sie
  a <- 2
  b <- 5
  c <- a + b
  
  # Was wird R nach der dritten Zeile zurueckgeben?
  a <- 10
  a + 10
  a   # 10; a + 10 wurde nicht neu zugewiesen, daher ist a immer noch 10
}

# Objekttypen ####
{
  # Erstellen Sie eine Variable für Ihren Vornamen, eine für Ihren Nachnamen und eine für Ihren Geburtsort.
  vorname <- "Gabriele"
  nachname <- "von Eichhorn"
  geburtsort <- "Gmunden"
  
  # Wie lange ist Ihr Nachname?
  nchar(nachname)
  
  # Verbinden Sie die Informationen zu einem Satz.
  paste("Mein Name ist", vorname, toupper(nachname), ",",
        "ich wurde in", geburtsort, "geboren.")
  
  # Ersetzen Sie die ersten beiden Buchstaben Ihres vornamens durch ein X.
  gsub("Ga", "X", vorname)
  gsub(substr(vorname, 1, 2), "X", vorname)
  
  # Ist Ihr Vorname gleich wie Ihr Nachname?
  vorname == nachname
  vorname != nachname
  
  # Erstellen Sie eine Variable fuer die Koerpergroesse in cm.
  # Pruefen Sie, ob Sie kleiner als 172cm sind.
  groesse <- 153
  groesse < 172
}

# Funktionen ####
{
  # Erstellen Sie eine Variable "values_r_erfahrung" aus den Antworten auf die Frage
  # "Vorerfahrung mit R/RStudio".
  values_r_erfahrung <- c(1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3)
  
  # Fuegen Sie einen fehlenden Wert hinzu.
  values_r_erfahrung <- c(values_r_erfahrung, NA)
  
  # Berechnen Sie den Mittelwert.
  mean_r_erfahrung <- mean(values_r_erfahrung, na.rm = TRUE)

  # Berechnen Sie den Mittelwert unter Ausschluss der extremsten 20% der Werte.
  mean(values_r_erfahrung, trim = 0.1, na.rm = TRUE)
  
  # Fuegen Sie dem Mittelwert eine Zahl hinzu, sodass er am Ende 5 ist
  5 - mean_r_erfahrung
  mean_r_erfahrung + 3.09   # eine Moeglichkeit (haendisch)
  mean_r_erfahrung + (5 - mean_r_erfahrung)   # zweite Moeglichkeit (mathematisch)
}

# Mini-Quiz Typenumwandlung ####
{
  # Was ist das Ergebnis der Funktion "as.logical(0:5)"
  ?as.logical
  as.logical(0:5)
  # FALSE TRUE TRUE TRUE TRUE TRUE
  
  # Was ist das Ergebnis von dieser Funktion?
  as.numeric(as.logical(0:5))
  # 0 1 1 1 1 1 
}

# sample() ####
{
  # Schreiben Sie eine sample()-Funktion, die "Schere, Stein, Papier" simuliert.
  menge <- c("Schere", "Stein", "Papier")
  sample(menge, 3, replace = TRUE)
  sample(menge, 1)
}

# Vektoren ####
{
  # Vektor 1:10
  (x <- c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10))
  (y <- 1:10)
  (z <- seq(1, 10, 1))
  
  # Vektor 2.1, 4.1, 6.1, 8.1
  (x <- c(2.1, 4.1, 6.1, 8.1))
  (y <- seq(2.1, 8.1, 2))
  
  # Vektor 0, 5, 10, 15
  (x <- c(0, 5, 10, 15))
  (y <- seq(0, 15, by = 5))
  (z <- seq(0, 15, length.out = 4))
  
  # Vektor 101,...
  (x <- c(seq(101, 103), seq(200, 210, 5), seq(1000, 1200, 100)))
  
  # Vektor mit Wdh von 1 bis 5
  (x <- rep(1:5, 10))
  
  # Vektor mit jeweiliger Wdh von 1 bis 5
  (x <- rep(1:5, each = 10))
  
  # 50 Ziehungen aus der Normalverteilung, Ergebnis fixieren
  set.seed(20220704)
  rnorm(50, 20, 2)
  
  # 25 Ziehungen aus einer uniformen Verteilung
  runif(25, -100, -50)
}

# Vektoren und Matrizen ####
{
  # Vektor v erstellen, dritte Zahl ausgeben
  v <- c(4, 5, 4, 6, 7)
  v[3]
  
  # dritte Zahl aendern
  v[3] <- 78
  
  # Laenge feststellen
  length(v)
  
  # Vektor mit Jahreszahlen
  j <- 1992:2022
  # Position der Jahre nach 2000
  which(j >= 2000)
  # Jahre meiner Volksschulzeit
  j[7:10]
  # Vektor auf die ersten 20 Werte einschraenken
  j <- j[1:20]
  # Matrix mit 10 Zeilen und 2 Spalten
  j <- matrix(j, nrow = 10, ncol = 2)
  # Matrix minus 1900
  j - 1900
  # Matrix mit Alter statt Jahr
  k <- j - 1992
}

# list 
{
  x <- "Hallo"   # character, length 1
  y <- 1:5   # numeric, length 5
  
  my_list <- list("character" = x, "numeric" = y)
  my_list[[1]]
  my_list$character
  
}

# Data Frames ####
{
  # Erstellen Sie einen Einkaufszettel mit den Spalten 
  # Produkt, Abteilung und Menge.
  einkaufszettel <- data.frame(Produkt = c("Saft", "Paprika", "Zwiebel", "Banane", "Apfel", "Ananas", "Bier"),
                               Abteilung = c("Getraenke", "Gemuese", "Gemuese", "Obst", "Obst", "Obst", "Getraenke"),
                               Menge = c(4, 1, 2, 1, 3, 1, 2))
  
  # Filtern Sie nach Getraenken
  einkaufszettel[einkaufszettel$Abteilung == "Getraenke", ]
  
  # Erstellen Sie eine neue Spalte, welche mit 0 angibt, ob die Menge kleiner als 2 ist
  # und mit 1 angibt, ob die Menge groesser oder gleich 2 ist.
  # Moeglichkeit 1 (Umwandeln von logisch zu numerisch)
  einkaufszettel$Menge_groesser_2 <- as.numeric(einkaufszettel$Menge >= 2)
  # Moeglichkeit 2 (Rechnen mit logischen Objekten)
  einkaufszettel$Menge_groesser_2 <- (einkaufszettel$Menge >= 2) * 1
}

# Projekte und Arbeitsverzeichnis
{
  # mtcars laden
  data(mtcars)
  
  # Subordner erstellen
  getwd()   # sollte in dem Ordner "R_Workshop_Code" sein
  dir.create("01_Datensaetze/mtcars")
  
  # 
  write.csv2(mtcars, file = file.path(here::here(), "01_Datensaetze", "mtcars", "mtcars.csv"))
  library("foreign")
  zuf <- read.spss(file = file.path(here::here(), "01_Datensaetze", "zuf.sav"), 
            to.data.frame = TRUE,
            use.value.labels = FALSE)
  
  library("openxlsx")
  write.xlsx(zuf, file = file.path(here::here(), "01_Datensaetze", "zuf.xslx"))
}

# Datenaufbereitung ####
{
  # Datensatz laden
  zuf <- read.spss(file = file.path(here::here(), "01_Datensaetze", "zuf.sav"), 
                   to.data.frame = TRUE,
                   use.value.labels = FALSE)
  
  # welche Namen? welche Struktur?
  names(zuf)   # Moeglichkeit 1
  colnames(zuf)   # Moeglichkeit 2
  
  str(zuf)
  
  # Anzahl NAs in religion
  sum(is.na(zuf$religion))
  # Anteil NAs
  mean(is.na(zuf$religion))
  round(mean(is.na(zuf$religion)) * 100)   # als Prozent und gerundet
  
  # neuer Datensatz ohne Missings
  zuf_komplett <- na.omit(zuf)
  dim(zuf); dim(zuf_komplett)
  
  # Datensatz ohne Missings bei einer Variable
  zuf_relikomplett <- zuf[!is.na(zuf$religion), ]
  
  # Rekodieren Sie zuf1
  ?recode
  # Moeglichkeit 1
  zuf$zuf1 <- recode(zuf$zuf1, recodes = "c(1,2,3)=1; c(4,5,6,7)=2")
  # Moeglichkeit 2
  zuf$zuf1 <- recode(zuf$zuf1, recodes = "1:3=1; 4:7=2")
  # Moeglichkeit 3
  zuf$zuf1 <- recode(zuf$zuf1, recodes = "1=1;2=1;3=1;4=2;5=2;6=2;7=2")
  # Variable koennte auch anders heissen
  zuf$zuf1_rec <- recode(zuf$zuf1, recodes = "1:3=1; 4:6=2")
}

