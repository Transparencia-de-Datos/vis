library(ggplot2)
library(dplyr)
library(tidyr)
library(png)
library(grid)
library(ggsci)

img <- png::readPNG("img/logo.png")
g_pic  <- rasterGrob(img, interpolate = TRUE)

df <- read.csv("datos/gubernaturas.csv", na.strings = "")
df1 <- df %>%
  gather("Elecciones", "Cantidad", 2:3) %>%
  filter(Cantidad != 0)

viz5 <- ggplot(df1, aes(reorder(Partido,-Cantidad), Cantidad, fill = Elecciones)) + 
  geom_col(position = "dodge")
viz5+ theme_classic() + labs(title ="Cambio de gubernatura por partido", subtitle="Elecciones 2018 y 2021", caption = "Fuente: Currícula de la Cámara de Diputados")+
  theme(legend.position = "top")+ geom_text(aes(label = Cantidad),  position = position_dodge(width = 1), vjust = -.5) +
  annotation_custom(g_pic, xmin=5, xmax=Inf, ymin=5, ymax=Inf) + scale_y_continuous(limits=c(0, 20)) +
  theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5)) + scale_fill_futurama( labels = c("Elecciones 2018", "Elecciones 2021")) + 
  xlab("Partidos")


