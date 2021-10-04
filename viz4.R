library(ggplot2)
library(dplyr)
library(tidyr)
library(tidyverse)

df <- read.csv("datos/total.csv", na.strings = "")
df1 <- df %>% select(Partido, Cambio.Eleccion.2018, Cambio.Eleccion.2021) %>%
  gather("Periodo", "CambioPorcentual", 2:3) %>%
  mutate(pos = CambioPorcentual >= 0) %>%
  arrange(CambioPorcentual)
  
viz4<-ggplot(df1, aes(x= Partido,y=CambioPorcentual)) + 
  geom_bar(stat = "identity",  aes(fill=pos))
viz4 + theme_bw() +  coord_flip() + facet_grid(~Periodo) + 
  labs(title ="Cambio porcentual en cantidad de diputados totales", subtitle="Elecciones 2018 y 2021", caption = "Fuente: SIL")+
  theme(legend.position = "top")


