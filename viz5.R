library(ggplot2)
library(dplyr)
library(tidyr)

df <- read.csv("datos/gubernaturas.csv", na.strings = "")
df1 <- df %>%
  gather("Elecciones", "Cantidad", 2:3)

viz5 <- ggplot(df1, aes(Elecciones, Cantidad, fill = Partido)) + 
  geom_col(position = "dodge2")
viz5+ theme_bw() + labs(title ="Cambio de gubernatura por partido", subtitle="Elecciones 2018 y 2021", caption = "Fuente: SIL")
