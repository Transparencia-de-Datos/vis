library(readxl)
library(dplyr)
library(tidyr)
library(ggplot2)
library(ggsci)
library(forcats)

df <- read_excel("datos/Generaciones_2018_2021.xlsx",sheet = 2)
df_porcentaje <- df %>%
  mutate(silenciosa_porcentaje = Silenciosa / Total) %>%
  mutate(boomers_porcentaje = Boomers / Total) %>%
  mutate(genX_porcentaje = GenX / Total) %>%
  mutate(millenials_porcentaje = Millenials / Total) %>%
  mutate(z_porcentaje = Z/Total)  %>%
 select(estado, silenciosa_porcentaje, boomers_porcentaje, genX_porcentaje,
        millenials_porcentaje, z_porcentaje)

df1<- df_porcentaje %>%
  gather("Generacion", "Porcentaje", 2:6) %>%
  filter(Porcentaje != 0) %>%
  mutate(Porcentaje = round(Porcentaje, 2))
  
viz <- ggplot(df1, aes(estado, Porcentaje, fill=Generacion)) + geom_col()
viz + coord_flip() + theme_classic() + labs(title="Distribución generacional de los diputados por estados", subtitle ="Legislaturas LXIV", caption = "Fuente: Currícula de la Cámara de Diputados")+
  theme(legend.position = "top") + geom_text(aes(label = Porcentaje),  position = position_dodge(width = 1), vjust = -.4) + 
  scale_fill_jama()
