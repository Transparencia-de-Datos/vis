library(ggplot2)
library(dplyr)
library(tidyr)
library(png)
library(grid)

img <- png::readPNG("img/logo.png")
g_pic  <- rasterGrob(img, interpolate = TRUE)

df <- read.csv("datos/gubernaturas.csv", na.strings = "")
df1 <- df %>%
  gather("Elecciones", "Cantidad", 2:3)

viz5 <- ggplot(df1, aes(Elecciones, Cantidad, fill = Partido)) + 
  geom_col(position = "dodge2")
viz5+ theme_classic() + labs(title ="Cambio de gubernatura por partido", subtitle="Elecciones 2018 y 2021", caption = "Fuente: Currícula de la Cámara de Diputados")+
  theme(legend.position = "top")+ geom_text(aes(label = Cantidad),  position = position_dodge(width = 1), vjust = -.4) + annotation_custom(g_pic, xmin=5, xmax=Inf, ymin=5, ymax=Inf)


