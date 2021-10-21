library(ggplot2)
library(dplyr)
library(tidyr)
library(grid)
library(png)
library(ggsci)

df <- read.csv("datos/total.csv", na.strings = "")
str(df)

drops  <- c("Cambio.Eleccion.2018", "Cambio.Eleccion.2021")
df  <- df[, !(names(df) %in% drops)]

df1 <- df %>%
	gather("Legislatura","Diputados", -Partido) %>%
  filter(Diputados != 0)

img <- png::readPNG("img/logo.png")
g_pic  <- rasterGrob(img, interpolate = TRUE)

fig  <- ggplot(df1, aes( x = reorder(Partido, -Diputados), Diputados, fill=Legislatura)) + geom_col(position = "dodge2")
fig + theme_classic() + labs(title="Total de diputados por partido en cada Legislatura", subtitle ="Legislaturas LXIII,LXIV y LXV", caption = "Fuente: Currícula de la Cámara de Diputados") +
  xlab("Partidos") + ylab("Cantidad de diputados") + theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5)) + annotation_custom(g_pic, xmin=5, xmax=Inf, ymin=5, ymax=Inf)+
  theme(legend.position = "top") + scale_y_continuous(limits=c(0, 300))+ geom_text(aes(label = Diputados),  position = position_dodge(width = 0.9), vjust = -.5) + 
  scale_fill_npg(labels = c("Legislatura 2015-2018", "Legislatura 2018-2021", "Legislatura 2021-2024"))

