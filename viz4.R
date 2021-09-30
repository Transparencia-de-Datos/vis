library(ggplot2)
library(dplyr)
library(tidyr)

df <- read.csv("datos/total.csv", na.strings = "")
df1 <- df %>% select(Partido, Cambio.Eleccion.2018, Cambio.Eleccion.2021) %>%
  gather("Cambio", "Cantidad", 2:3)


viz4<-ggplot(df1, aes(Partido, Cantidad, fill = Cambio)) + 
  geom_col(position = "dodge2")
viz4 + theme_bw() + labs("Cambio porcentual por partido", "legislaturas LXIV y LXV", caption = "Fuente: SIL")
