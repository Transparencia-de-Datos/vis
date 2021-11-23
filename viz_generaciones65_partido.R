library(readxl)
library(dplyr)
library(tidyr)
library(ggplot2)
library(ggsci)
library(png)
library(grid)

df <- read_excel("datos/Generaciones_2018_2021.xlsx",sheet = 4)
df1<- df %>%
  select( Partido ,Silenciosa,Boomers,GenX,Millenials, Z) %>%
  gather("Generacion", "Total", 2:6) %>%
  filter(Total != 0) %>%
  filter(Partido != "Totales") %>%
  mutate(Generacion = fct_reorder(Generacion,desc(Total))) %>%
  mutate(Partido = fct_reorder(Partido,desc(Total)))%>%
  group_by(Generacion) %>%
  mutate(propor = Total / sum(Total) ) %>%
  mutate(propor = round(propor, 2))

img <- png::readPNG("img/logo.png")
g_pic  <- rasterGrob(img, interpolate = TRUE)

viz <- ggplot(df1, aes(Partido, Total, fill=Generacion)) + geom_col(position="dodge2")
viz + theme_classic() + labs(title="Distribución generacional de los diputados por partido", subtitle ="Legislatura LXV", caption = "Fuente: Currícula de la Cámara de Diputados") +
  theme(legend.position = "top") + geom_text(aes(label = Total),  position = position_dodge(width = 1), vjust = -.4)+
  scale_y_continuous(limits=c(0, 100)) + scale_fill_jama() + annotation_custom(g_pic, xmin=5, xmax=Inf, ymin=30, ymax=110)


