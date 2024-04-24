# R-Workshop "Einfuehrung in R - Datenverarbeitung und grundlegende Statistiken"
# 04. - 06.07.2022
# Innsbrucker Summer Seminar zu Methoden der empirischen Sozial- und Bildungsforschung 2022

# Grafiken, Beispiele auf Folien
# GVE, ERO, 04.07.2022

# base-Grafiken
{
  dose <- c(20, 30, 40, 45, 60)
  drugA <- c(16, 20, 27, 40, 60)
  drugB <- c(15, 18, 25, 31, 40)
  
  plot(dose)
  plot(dose, drugA)
  
  plot(dose, drugA, type="b")
  
  par(lwd=2)   # Linienstaerke festlegen
  pdf(file.path(pfad, "Output", "Grafik1.pdf"))   # als PDF speichern
  plot(dose, drugA, type="b")   # Plot
  title("Meine Grafik")   # Titel hinzufuegen
  dev.off()   # PDF fertigstellen
  
  plot(dose, drugA, type="b", lty=3, lwd=3, pch=15, cex=2)
  
  colors()
  plot(dose, drugA, type="b", lty=3, lwd=3, pch=15, cex=2, col="springgreen")
  
  cr <- rainbow(10)
  plot(dose, drugA, type="b", lty=3, lwd=3, pch=15, cex=2, col=cr[6])
  
  # layout
  layout(matrix(c(1,1,2,3), 2, 2, byrow = TRUE))
  hist(mtcars$wt)
  hist(mtcars$mpg)
  hist(mtcars$disp)
  
  # Scatter Plot
  par(mfcol=c(1,1))
  plot(mtcars$wt, mtcars$mpg, pch=19,
       xlab="Miles Per Gallon",
       ylab="Car Weight")
  #text(x = 2, y = 15, expression(A==alpha*sigma~~frac(x,y)))
  
  
  # Barplots
  library(vcd)
  
  counts <- table(Arthritis$Improved)
  counts
  par(mfcol=c(1,2))
  plot(counts)
  barplot(counts)
  
  barplot(counts, main = "Effekt der Behandlung",
          xlab = "Grad der Verbesserung",
          ylab = "H?ufigkeit",
          horiz = FALSE)
  
  barplot(counts, main = "Effekt der Behandlung",
          ylab = "Grad der Verbesserung",
          xlab = "H?ufigkeit",
          horiz = TRUE)
  
  counts <- table(Arthritis$Improved, Arthritis$Treatment)
  
  barplot(counts, main = "Effekt der Behandlung",
          xlab = "Grad der Verbesserung",
          ylab = "H?ufigkeit",
          legend = rownames(counts))
  
  barplot(counts, main = "Effekt der Behandlung", 
          xlab = "Grad der Verbesserung", ylab = "H?ufigkeit",
          legend = rownames(counts), col = c("red", "green", "blue"),
          beside = T)
  
  # Histogramme
  par(mfrow=c(2,2))
  
  # Einfaches Histogramm
  hist(mtcars$mpg) 
  
  # Hist mit mehr bins
  hist(mtcars$mpg,
       breaks=12, 
       col="red",
       xlab="Miles Per Gallon",
       main="Colored histogram with 12 bins")
  
  # Hist mit rug und density
  hist(mtcars$mpg, 
       freq=FALSE,
       breaks=12,
       col="red",
       xlab="Miles Per Gallon",
       main="Histogram, rug plot, density curve")
  rug(jitter(mtcars$mpg))
  lines(density(mtcars$mpg), col="blue", lwd=2)
  
  # Hist mit Normalverteilungskurve und box
  x <- mtcars$mpg
  h <- hist(x, 
            breaks=12,
            col="red",
            xlab="Miles Per Gallon",
            main="Histogram with normal curve and box")
  xfit <- seq( min(x), max(x), length=40 )
  yfit <- dnorm( xfit, mean=mean(x), sd=sd(x) )
  yfit <- yfit*diff(h$mids[1:2])*length(x)
  lines(xfit, yfit, col="blue", lwd=2)
  
  box()
  
  # Density Plots
  par(mfrow = c(2,1))
  d <- density(mtcars$mpg) # zuerst Density berechnen
  plot(d) 
  
  d <- density(mtcars$mpg)
  plot(d, main="Kernel Density of Miles Per Gallon")
  polygon(d, col="blue", border="green") # F?r F?llung
  rug(mtcars$mpg, col="brown")
  
  
  # Boxplots
  par(mfcol=c(1,2))
  boxplot(mpg ~ cyl, data=mtcars,
          main="Car Mileage Data",
          xlab="Number of Cylinders",
          ylab="Miles Per Gallon")
  
  boxplot.stats(mtcars$mpg) # -> F2 
  
  boxplot(mpg ~ cyl, data=mtcars,
          main="Car Mileage Data",
          xlab="Number of Cylinders",
          ylab="Miles Per Gallon",
          varwidth=T, # Breite prop. zu Gruppengr??e
          notch=T, # Konfidenzintervalle des Medians
          col="red")
  
  
  # ggplot2
  ggplot(mtcars, aes(x=mpg, y=wt)) + 
    geom_smooth(method = "lm") +
    geom_point()
}