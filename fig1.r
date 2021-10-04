library(ggplot2)
library(dplyr)
library(tidyr)
library(grid)
library(png)

df <- read.csv("datos/total.csv", na.strings = "")
str(df)

drops  <- c("Cambio.Eleccion.2018", "Cambio.Eleccion.2021")
df  <- df[, !(names(df) %in% drops)]

df1 <- df %>%
	gather("Legislatura","Diputados", -Partido)

img <- png::readPNG("img/logo.png")
g_pic  <- rasterGrob(img, interpolate = TRUE)

fig  <- ggplot(df1, aes( x = reorder(Partido, -Diputados), Diputados, fill=Legislatura)) + geom_col(position = "dodge2")
fig + theme_bw() + ggtitle("Total de diputados por partido en cada Legislatura") +
  xlab("Partidos") + ylab("Cantidad de diputados") + theme(plot.title = element_text(hjust = 0.5)) + annotation_custom(g_pic, xmin=5, xmax=Inf, ymin=5, ymax=Inf)+
  theme(legend.position = "top")
