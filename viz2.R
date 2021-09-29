library(ggplot2)
library(dplyr)
library(tidyr)

df <- read.csv("datos/mr.csv", na.strings = "")
str(df)

drops  <- c("Eleccion.2018", "Eleccion.2021")
df  <- df[, !(names(df) %in% drops)]

#Revisar transformación de los datos, no logré eliminar las
#columnas que incluían el porcentaje de cambios entre legislaturas

df1<- df %>%
  gather("Legislatura","MayoriaRelativa",-Partido)


fig  <- ggplot(df1, aes( x = Partido, MayoriaRelativa, fill=Legislatura)) + geom_col(position = "dodge2")
fig + theme_classic() + labs(title="Distribución de la Mayoría Relativa por partidos", subtitle ="Legislaturas LXIII,LXIV y LXV", caption = "Fuente: SIL")
