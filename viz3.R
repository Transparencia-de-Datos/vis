library(ggplot2)
library(dplyr)
library(tidyr)
library(grid)
library(png)
library(ggsci)

df <- read.csv("datos/rp.csv", na.strings = "")
df1<- df %>%
  gather("Legislatura","RepresentacionProporcional", 2:4) %>%
  filter(RepresentacionProporcional != 0)

img <- png::readPNG("img/logo.png")
g_pic  <- rasterGrob(img, interpolate = TRUE)

viz3<- ggplot(df1, aes(x=reorder(Partido, -RepresentacionProporcional), RepresentacionProporcional, fill = Legislatura)) +
  geom_col(position="dodge2")
viz3 + theme_classic() + labs(title="Distribución de la representación proporcional por partidos", subtitle ="Legislaturas LXIII,LXIV y LXV",
                                caption = "Fuente: Currícula Cámara de Diputados") + theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5))+
  xlab("Partidos") + ylab("Cantidad de diputados") + theme(legend.position = "top") + geom_text(aes(label = RepresentacionProporcional),  position = position_dodge(width = 1), vjust = -.5)+ scale_y_continuous(limits=c(0, 100))+
    annotation_custom(g_pic, xmin=5, xmax=Inf, ymin=5, ymax=Inf) + scale_fill_jama(labels = c("Legislatura 2015-2018", "Legislatura 2018-2021", "Legislatura 2021-2024"))



