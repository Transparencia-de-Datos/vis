library(readxl)
library(dplyr)
library(tidyr)
library(ggplot2)

df <- read_excel("datos/Generaciones_2018_2021.xlsx",sheet = 2)
df1<- df %>%
  select( estado ,Silenciosa,Boomers,GenX,Millenials, Z) %>%
  gather("Generacion", "Total", 2:6) 

viz <- ggplot(df1, aes(estado, Total, fill=Generacion)) + geom_col(position="dodge2")
viz + coord_flip() + theme_classic() + labs(title="Distribución generacional de los diputados por estados", subtitle ="Legislaturas LXIV", caption = "Fuente: Currícula de la Cámara de Diputados")+
  theme(legend.position = "top") + geom_text(aes(label = Total),  position = position_dodge(width = 1), vjust = -.4)

