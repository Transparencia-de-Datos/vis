library(readxl)
library(dplyr)
library(tidyr)
library(ggplot2)

df <- read_excel("datos/Generaciones_2018_2021.xlsx",sheet = 1)
df1<- df %>%
  select(  tipoEleccion ,Silenciosa,Boomers,GenX,Millenials, Z) %>%
  gather("Generacion", "Total", 2:6) 

viz <- ggplot(df1, aes(Generacion, Total, fill=tipoEleccion)) + geom_col(position="dodge2")
viz + theme_classic() + labs(title="Distribución generacional diputados por tipo de elección", subtitle ="Legislaturas LXIV", caption = "Fuente: Currícula de la Cámara de Diputados") +
  theme(legend.position = "top") + geom_text(aes(label = Total),  position = position_dodge(width = 1), vjust = -.4)
