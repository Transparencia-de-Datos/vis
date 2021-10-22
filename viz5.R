library(ggplot2)
library(dplyr)
library(tidyr)
library(png)
library(grid)
library(ggsci)
library(car)

img <- png::readPNG("img/logo.png")
g_pic  <- rasterGrob(img, interpolate = TRUE)

df <- read.csv("datos/gubernaturas.csv", na.strings = "")
df1 <- df %>%
  gather("Elecciones", "Cantidad", 2:3) %>%
  filter(Cantidad != 0) %>%
  mutate(Elecciones= recode(Elecciones, "'Elecciones.2018'='Elecciones 2018'")) %>%
  mutate(Elecciones= recode(Elecciones, "'Elecciones.2021'='Elecciones 2021'")) %>%
  arrange(desc(Cantidad))

viz5 <- ggplot(df1, aes(reorder(Partido,-Cantidad), Cantidad, fill= Partido)) + 
  geom_col() + facet_grid(~Elecciones)
viz5+ theme_classic() + labs(title ="Cambio de gubernatura por partido", subtitle="Elecciones 2018 y 2021", caption = "Fuente: Currícula de la Cámara de Diputados")+
   geom_text(aes(label = Cantidad),  position = position_dodge(width = 1), vjust = -.5) +
  annotation_custom(g_pic, xmin=5, xmax=Inf, ymin=5, ymax=Inf) + scale_y_continuous(limits=c(0, 16),breaks=seq(0,16,by=2)) +
  theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5), legend.position = "none", axis.text.x = element_text(angle = 30,  hjust=1) ) + 
  xlab("Partidos") + scale_fill_manual(values =c("indianred1","darkorange", "red4", "royalblue3", "darkorchid4", "gold1","springgreen4"))
