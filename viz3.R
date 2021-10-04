library(ggplot2)
library(dplyr)
library(tidyr)
library(grid)
library(png)

df <- read.csv("datos/rp.csv", na.strings = "")
df1<- df %>%
  gather("Legislatura","RepresentacionProporcional", 2:4)

img <- png::readPNG("img/logo.png")
g_pic  <- rasterGrob(img, interpolate = TRUE)

viz3<- ggplot(df1, aes(x=reorder(Partido, -RepresentacionProporcional), RepresentacionProporcional, fill = Legislatura)) +
  geom_col(position="dodge2")
viz3 + theme_bw() + labs(title="Distribución de la Representación Proporcional por partidos", subtitle ="Legislaturas LXIII,LXIV y LXV",
                                caption = "Fuente: SIL") + theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5))+
  xlab("Partidos") + ylab("Cantidad de diputados") + theme(legend.position = "top")


