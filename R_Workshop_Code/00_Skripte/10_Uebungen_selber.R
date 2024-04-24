# Übungskript
# GVE; 13.07.2023

klang <- "c-e-g"

a = 10
a + 10
a2 <- a + 10
a +10

mean(a, na.rm = FALSE)

# Uebung: Objekttyp "character"
vorname <- "Gabriele"
nachname <- toupper("von Eichhorn")
geburtsort <- "Gmunden"

# Wie lange ist mein Nachname?
nchar(nachname)

paste("Mein Name ist", vorname, nachname, ",",
      "ich wurde in", geburtsort, "geboren.")
paste0("Mein Name ist ", vorname, " ", nachname, ", ",
       "ich wurde in ", geburtsort, " geboren.")

# Buchstaben im Vornamen ersetzen
gsub("Ga", "X", vorname)

# Vorname = Nachname?
vorname == nachname

# Koerpergroesse
groesse <- 153
groesse < 172


# logical-Quiz
?as.logical
0:5
as.logical(0:5)
as.numeric(as.logical(0:5))


# Funktionen
# Erstellen Sie eine Variable aus den Antworten
values_r_erfahrung <- c(1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3)

# Mittelwert berechnen
?mean
mean_r_erfahrung <- mean(values_r_erfahrung)

# Mittelwert ohne die 20% extremsten Werte
mean(values_r_erfahrung, trim = 0.1)

# Zahl hinzufuegen
5 - mean_r_erfahrung
mean_r_erfahrung + 3.09   # eine Moeglichkeit (haendisch)
mean_r_erfahrung + (5 - mean_r_erfahrung)   # zweite Moeglichkeit (mathematisch)


# Vektoren und Matrizen, Indizierung

# Vektor erstellen
v <- c(4, 5, 4, 6, 7)
v1 <- v

# dritte Zahl ausgeben lassen
v[3]

# dritte Zahl aendern
v[3] <- 78
v1[3] = 78

# Laenge feststellen
?length
length(v)

# Vektor j mit Jahreszahlen erstellen
j <- 1992:2022

# An welcher Position stehen die Jahre nach 2000?
j[j > 2000]
which(j > 2000)

# Jahre der Volksschulzeit
j[7:10]   

# Vektor kuerzen auf 20 Werte
j <- j[1:20]

# Matrix generieren
?matrix
m <- matrix(data = j, nrow = 10, ncol = 2)

# 1900 subtrahieren
m - 1900

# was muss ich subtrahieren, um das Alter zu bekommen?
m - 1992   # Matrix minus Geburtsjahr = Alter


# Uebung Data Frames
# Einkaufszettel erstellen
?data.frame
(einkaufszettel <- data.frame(Produkt = c("Saft", "Paprika", "Zwiebel", "Banane", 
                                          "Apfel", "Ananas", "Bier"),
                              Abteilung = c("Getränke", "Gemüse", "Gemüse", "Obst", 
                                            "Obst", "Obst", "Getränke"),
                              Menge = c(4, 1, 2, 1, 3, 1, 2)))
einkaufszettel

# Getraenke filtern
# --> heisst ich moechte Zeilen, in denen das Produkt "Getränke" ist
# ausserdem will ich alle Spalten
einkaufszettel[einkaufszettel$Abteilung == "Getränke", ]

# neue Spalte erstellen
# Moeglichkeit 1 (Umwandeln von logisch zu numerisch)
einkaufszettel$Menge_groesser_2 <- as.numeric(einkaufszettel$Menge >= 2)
# Moeglichkeit 2 (Rechnen mit logischen Objekten)
einkaufszettel$Menge_groesser_2 <- (einkaufszettel$Menge >= 2) * 1


# Uebung Datenaufbereitung
zuf <- read.spss("01_Datensaetze/zuf.sav", 
                  to.data.frame = TRUE,
                  use.value.labels = FALSE)

# welche Variablennamen kommen vor?
names(zuf)
colnames(zuf)

# welche Struktur hat der Datensatz?
str(zuf)

# wie viele fehlende Werte hat "religion"?
sum(is.na(zuf$religion))
# 303
round(mean(is.na(zuf$religion)) * 100)

# neuen Datensatz erzeugen (ohne Missings)
?na.omit
zuf_komplett <- na.omit(zuf)
dim(zuf); dim(zuf_komplett)

zuf_relikomplett <- zuf[!is.na(zuf$religion), ]

# zuf1 rekodieren
?recode
# Moeglichkeit 1
zuf$zuf1 <- recode(zuf$zuf1, recodes = "c(1,2,3)=1; c(4,5,6,7)=2")
# Moeglichkeit 2
zuf$zuf1 <- recode(zuf$zuf1, recodes = "1:3=1; 4:7=2")
# Moeglichkeit 3
zuf$zuf1 <- recode(zuf$zuf1, recodes = "1=1;2=1;3=1;4=2;5=2;6=2;7=2")

# Variable koennte auch anders heissen
zuf$zuf1_rec <- recode(zuf$zuf1, recodes = "1:3=1; 4:6=2")

