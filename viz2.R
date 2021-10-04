library(ggplot2)
library(dplyr)
library(tidyr)

df <- read.csv("datos/mr.csv", na.strings = "")
str(df)

drops  <- c("Eleccion.2018", "Eleccion.2021")
df  <- df[, !(names(df) %in% drops)]



df1<- df %>%
  gather("Legislatura","MayoriaRelativa",-Partido)


fig  <- ggplot(df1, aes( x = reorder(Partido, -MayoriaRelativa), MayoriaRelativa, fill=Legislatura)) + geom_col(position = "dodge2")
fig + theme_bw() + labs(title="Distribución de la Mayoría Relativa por partidos", subtitle ="Legislaturas LXIII,LXIV y LXV", caption = "Fuente: SIL") +
  xlab("Partidos") + ylab("Cantidad de diputados") + theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5)) + 
  theme(legend.position = "top")

