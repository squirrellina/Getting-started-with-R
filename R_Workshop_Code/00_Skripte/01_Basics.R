# R-Workshop "Einfuehrung in R - Datenverarbeitung und grundlegende Statistiken"
# 04. - 06.07.2022
# Innsbrucker Summer Seminar zu Methoden der empirischen Sozial- und Bildungsforschung 2022

# Basics: Datenstrukturen und Datentypen; Indizierung
# GVE, ERO, 04.07.2022

install.packages("psych")


a <- 35   # a wird durch Zuweisung zu einem Objekt

# 3 Möglichkeiten ein Objekt auszugeben
{
  a
  print(a)
  (a <- 35)  
}

# Zahlenreihen koennen mit Doppelpunkt notiert werden
# Zahlen in eckigen Klammern [] geben Index (Position) des Wertes an
{
  a <- 1:100
  a
  
  # "combine" fuer einen Vektor
  a <- c(4, 7, 2022)
  a
  
  x <- 4
  y <- "vier"
  z <- 50 < 100
  class(x); class(y); class(z)
  is.numeric(x); is.logical(x)
  as.character(x); as.character(z)
  # Raetselfrage! Vielleicht Hilfe lesen davor?
  as.logical(x)  
}


# Runden
{
  x <- 536.35346
  round(x)   # Default-Einstellung: auf ganze Zahl runden
  round(x, digits = 2)   # auf 2 Nachkommastellen
  round(x, digits = -2)   # auf 2 Vorkommastellen
  
  # Textobjekte und Sonderzeichen
  # cat() ist wie print, aber fuehrt die Funktionen der Sonderzeichen aus 
  cat("Der Papagei sagt: \n 'bla'")
  print("Der Papagei sagt: \n 'bla'")
  
  ( hallo <- paste("Willkommen", "beim", "R-Workshop!", sep=" ") )
  substr(hallo, 1, 10)
  gsub("beim", "bei unserem", hallo)
  toupper(hallo)
  tolower(hallo)
  
  # Typumwandlungen
  class(c(1, "Banane", TRUE, NA))   # character
  class(c(1, 2, 3, TRUE, NA))   # numeric
  as.numeric(c(TRUE, FALSE, NA))
  as.numeric(c("TRUE", "FALSE", NA))   
  # Warnmeldung! Character kann nicht in Numeric umgewandelt werden
  # Raetselfrage! Vielleicht Hilfe lesen davor?
  0:5
  as.logical(0:5)
  as.numeric(as.logical(0:5))
}


# Funktionen
{
  # This will return an error because the arguments are not numeric!
  mean(c("1", "10"))
  # This is ok!
  mean(c(1, 10))
}

# Datentypen
# Skalare
{
  # Beispiele fuer numerische Skalare
  a <- 100
  b <- 3 / 100
  c <- (a + b) / b
  
  # Beispiele fuer Text-Skalare
  d <- "Hallo"
  e <- "Wie geht's?"
  f <- "Ich bin Beispiel-Text!"
  
  # Arithmetische Operationen funktionieren nicht mit dem Character-Typ
  a <- "1"
  b <- "2"
  a + b  
}


# Vektoren
{
  c(1, 5, 9)
  c("Apfel", "Banane", "Kiwi")
  1:5
  10:-3
  seq(from = 0, to = 6, by = 2)
  seq(1, 9, 2)
  rep(2, 10)   # wiederhole 2 10x
  rep(c(7, 8), times = 2, each = 2)   # wiederhole Vektor 2x, jedes Element 2x
  rep(3:5, 1:3)   # 1x3, 2x4, 3x5
  # die Laenge eines Vektors feststellen
  a <- c(1, 23, 10, 22)
  length(a)
  # Vektorelemente benennen
  c("WertA" = 34, "WertB" = 65)  
}


# Daten generieren
{
  menge <- c("Kopf", "Zahl")
  # ziehe 1 aus der Menge von Kopf und Zahl
  sample(x = menge, size = 1)
  
  # replace = TRUE
  sample(x = menge, size = 5, replace = T)
  
  # Wahrscheinlichkeit definiert
  sample(x = menge, size = 10, replace = T, prob = c(0.8, 0.2))
  
  # Ziehung aus der Normalverteilung
  # 5 Ziehungen aus einer Normalverteilung mit M = 0, SD = 1
  rnorm(n = 5)
  # 5 Ziehungen aus einer Normalverteilung mit BIST-/PISA-Skala
  rnorm(n = 5, mean = 500, sd = 100)
  
  # Ziehung aus einer uniformen Distribution
  runif(n = 5, min = 0, max = 100)
  
  set.seed(2022)
  rnorm(n = 5) 
}

# Rechnen mit Vektoren
{
  a <- c(1, 2, 3, 4, 5)
  b <- c(10, 20, 30, 40, 50)  
  
  # Addition, Division mit Vektoren und Skalaren
  # Skalare werden in der Laenge des Vektors recycelt
  a + 100
  a / 100
  a ^ 2 
  # Addition zweier Vektoren
  a + b 
  (a + b) / 10
  
  # Multiplikation mit Bedeutung
  # Koerpergroesse in cm in m
  groesse_cm <- c(153, 172, 183, 167)
  groesse_cm / 100   # Koerpergroesse in m
  
  # Kilo-Preise fuer Aepfel, Birnen und Trauben
  preise <- c(2.99, 2.29, 4.98)
  kg <- c(5, 2, 0.5)
  (kosten <- preise * kg)
}

# Indizierung
{
  # numerische Indizierung
  a <- c(5, 3, 6, 2, 8, 8, 9)
  a[4]   # 4. Element des Vektors
  
  a[c(1, 3, 7)]   # Auswahl mehrerer Elemente
  
  a[-c(1, 2)]   # Elemente 1 und 2 ausschliessen
  
  a[which(a < 5)]   # alle Elemente kleiner 5
  
  index <- 1:4
  a[index]   # die ersten 4 Elemente ueber einen Index-Vektor
  
  
  # logische Indizierung
  a <- c(5, 3, 6, 2, 8, 8, 9)
  a < 5
  a[a < 5]   # Elemente < 5 
  
  a[a < 5 & a != 3]   # Elemente kleiner 5, aber nicht 3
  a[a < 5 | a >= 9]
  
  duplicated(a)   # doppelte Elemente (das zweite Vorkommen)
  
  b <- c("ctrl", "ctrl", "exp", "ctrl", "exp", "exp", "exp")
  a[b == "exp"]   # alle Elemente in Experimentalbedingung
  
  sum(a > 6)   # wieviele Elemente sind > 6
  
  mean(a > 6)   # wieviel % der Elemente sind > 6?
  
  
  # Indizierung durch Namen
  a <- c("PersonA" = 34, "PersonB" = 55)
  a["PersonA"]   # Auswahl ueber Namen
  
  a["PersonA"] <- 44   # Ersetzen des Wertes (Indizierung links)
  a[] <- 100   # alle Elemente ersetzen
  a[5] <- 56   # zusaetzliche Elemente einfuegen
  a
  
  # Sonstiges
  3 %in% 1:3   # TRUE
  5:9 %in% 6:10   # FALSE TRUE TRUE TRUE TRUE
  
  groesse_cm <- c(153, 172, 183, 167)
  which(groesse_cm > 170)   # 2 3
  
  arbeit <- c("Universität Innsbruck", "Universität Salzburg", "IQS")
  grep("Uni", arbeit)   # suche Bestandteil
  match("IQS", arbeit)   # suche Match
}



# Matrizen
{
  matrix(data = NA, nrow = 3, ncol = 4)
  matrix(NA, 3, 4)
  
  (a <- seq(1, 12))
  (meine_matrix <- matrix(a, 3, 4))   # 3 x 4 Matrix, spaltenweiser Aufbau (default)
  (meine_matrix <- matrix(a, 3, 4, byrow = TRUE))   # 3 x 4, zeilenweiser Aufbau
  
  (a <- seq(1, 5))
  (b <- seq(5, 9))
  (meine_matrix <- rbind(a, b))
  (meine_matrix <- cbind(a, b))
  
  # Mischen von Datentypen -> allgemeinster Typ wird uebernommen
  cbind(seq(1, 5), letters[1:5])
  
  # Indizieren von Matrizen
  meine_matrix[3, 2]   # 3. Zeile der 2. Spalte
  
  # Datenstruktur nach Indizieren kann sich veraendern!
  meine_matrix[1, 1]   # wird ein Vektor
  meine_matrix[1, 1, drop = FALSE]   # bleibt eine Matrix
  str(meine_matrix[1, 1, drop = FALSE]); str(meine_matrix[1, 1])
  
  # Eigenschaften von Matrizen
  nrow(meine_matrix)
  ncol(meine_matrix)
  # Dimensionen veraendern
  meine_matrix2 <- meine_matrix
  dim(meine_matrix2) <- c(2, 5)   
  
  colnames(meine_matrix) <- paste("Person", seq(1:2), sep = "_")
  colnames(meine_matrix)
  
  # Transponieren von Matrizen
  # Zeilen werden zu Spalten und Spalten zu Zeilen
  meine_matrix
  t(meine_matrix)
}

# Data Frames
{
  # sex <- c("m", "f", "f", "f", "m", "m", "m")
  # alter <- c(40, 50, 52, 32, 33, 30, 42)
  # kgr <- c(157, 173, 176, 146, 163, 173, 187)
  # item1 <- c(0, 1, 1, 0, 1, 1, 0)
  # item2 <- c(0, 0, 0, 1, 0, 1, 0)
  # item3 <- c(0, 1, 0, 1, 1, 1, 1)
  
  dat <- data.frame(id = seq(1, 7), 
                    sex = c("m", "f", "f", "f", "m", "m", "m"), 
                    alter = c(40, 50, 52, 32, 33, 30, 42), 
                    kgr = c(157, 173, 176, 146, 163, 173, 187), 
                    item1 = c(0, 1, 1, 0, 1, 1, 0), 
                    item2 = c(0, 0, 0, 1, 0, 1, 0), 
                    item3 = c(0, 1, 0, 1, 1, 1, 1))
  dat
  
  str(dat)
  names(dat)
  dim(dat)
  summary(dat)
  
  dat[2]   # gesamte zweite Spalte (Struktur: Data Frame)
  dat[, 2]   # Werte der zweiten Spalte (Vektor)
  dat[, "kgr"]   # Zugriff ueber Namen
  dat$kgr   # Zugriff ueber $-Operator
  dat$kgr

  dat[dat$sex == "f",]   # Zeilenauswahl (Filtern)
  dat[dat$kgr > 170, ]
  dat[dat$kgr > 170 & dat$sex == "m", ]
  dat[dat$kgr > 170 & dat$sex == "m", c(5, 6, 7)]   # Zeilen und Spalten
  dat[dat$kgr > 170 & dat$sex == "m", grep("item", colnames(dat))]  
  
  # subset(x, subset, select):
  subset(dat, kgr < 170 & sex == "m", c("item1", "item2", "item3"))
  subset(dat, kgr < 170 & sex == "m", 5:7)
  subset(dat, kgr < 170 & sex == "m", grep("item", colnames(dat)))
  
  # Hinzufuegen von Daten
  dat$kgw <- c(60, 76, 75, 52, 72, 66, 81)
  dat[, "notiz"] <- c("", "", "", "", "linkshaendig", "", "")
  
  kgw <- c(60, 76, 75, 52, 72, 66, 81)
  dat <- cbind(dat, kgw)
}

# Faktoren
{
  v <- c("g1", "g1", "g2", "g1", "g2", "g1")   # 2 Gruppen
  v <- factor(v)
  v
  table(v)
  as.numeric(v)
  
  # ordered factor
  v <- c("eins", "eins", "zwei", "drei", "drei", "zwei")
  factor(v)   # alphabetische Sortierung ist nicht korrekt
  factor(v, 
         levels = c("eins", "zwei", "drei"), 
         labels = c("Gruppe 1", "Gruppe 2", "Gruppe 3"), 
         ordered = TRUE)
  
  dat <- ToothGrowth
  str(dat)
  plot(dat$dose, dat$len)   # len wird als numeric wahrgenommen
  dat$dose <- as.factor(dat$dose)   # len zu Kategorien umwandeln
  plot(dat$dose, dat$len) 
  levels(dat$dose)
  as.numeric(dat$dose)
  str(dat)
}

# Listen
{
  # eine Liste erstellen
  t <- "Hallo Du!"   # ein Text
  v <- seq(1, 6)   # ein Vektor
  m <- matrix(v, 2, 3)   # eine Matrix
  d <- data.frame(t, v)   # ein Data Frame
  l <- list(t, v, m, d)   # eine Liste aus allen Objekten
  l
  unlist(l)
  
  # benannte Liste
  l <- list(EinText = t, 
            EinVektor = v, 
            EineMatrix = m, 
            EinDataFrame = d)
  l
  
  # Auswahl der Elemente
  l[[2]]
  l[[2]][5]
  l$EinDataFrame$v
}

