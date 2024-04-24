# Grafiken 

# Grundgeruest
{
  library("ggplot2")
}

# Daten laden
{
  penguins <- palmerpenguins::penguins
  flights <- nycflights13::flights 
  data(mtcars)
}

# Aufbereiten
{
  head(penguins)
  names(penguins)
  
  head(flights)
  names(flights)
}

# Plotting
{
  flights |> 
    ggplot() + 
    geom_histogram(aes(x = dep_time, fill = )) + 
    theme_classic()
  
  mtcars |> 
    ggplot(aes(x = mpg, y = wt, color = factor(cyl))) + 
    geom_smooth(method = "lm") + 
    geom_point() + 
    scale_color_viridis_d() + 
    scale_color_manual(values = c("red", "blue", "green")) + 
    scale_color_manual(values = wesanderson::wes_palette("Zissou1", type = "discrete")) + 
    theme_minimal() 
  
  
  
}
