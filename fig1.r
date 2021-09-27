library(ggplot2)
library(dplyr)
library(tidyr)

df <- read.csv("datos/total.csv", na.strings = "")
str(df)

drops  <- c("Cambio.Eleccion.2018", "Cambio.Eleccion.2021")
df  <- df[, !(names(df) %in% drops)]

df1 <- df %>%
	gather("Legislatura","Diputados", -Partido)

fig  <- ggplot(df1, aes( Diputados, Partido, fill=Legislatura)) + geom_col(position = "dodge2") + coord_flip()
fig + theme_classic() + ggtitle("Total de diputados por partido en cada Legislatura")
