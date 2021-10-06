library(ggplot2)
library(dplyr)
library(tidyr)
library(tidyverse)

df <- read.csv("datos/total.csv", na.strings = "")
df1 <- df %>% select(Partido, Cambio.Eleccion.2018, Cambio.Eleccion.2021) %>%
  gather("Periodo", "CambioPorcentual", 2:3) %>%
  mutate(Cambio = as.numeric(sub("%","",CambioPorcentual))) %>%
  arrange(Cambio) %>%
filter(Partido != "NA")
  
viz4<-ggplot(df1, aes(x= Partido,y=Cambio)) + ylim(-120, 410) +
  geom_bar(stat = 'identity',  aes(fill= Partido))
viz4 + theme_classic() +  coord_flip() + facet_grid(~Periodo) + 
  labs(title ="Cambio porcentual en cantidad de diputados totales", subtitle="Elecciones 2018 y 2021", caption = "Fuente: Currícula Cámara de Diputados")+
   geom_text(aes(label = Cambio)) + theme(legend.position = "top")


