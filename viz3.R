library(ggplot2)
library(dplyr)
library(tidyr)

df <- read.csv("datos/rp.csv", na.strings = "")
df1<- df %>%
  gather("Legislatura","RepresentacionProporcional", 2:4) 

viz3<- ggplot(df1, aes(x=reorder(Partido, -RepresentacionProporcional), RepresentacionProporcional, fill = Legislatura)) + 
  geom_col(position="dodge2") 
viz3 + theme_classic() + labs(title="Distribución de la Representación Proporcional por partidos", subtitle ="Legislaturas LXIII,LXIV y LXV",
                                caption = "Fuente: SIL") + theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5))+
  xlab("Partidos") + ylab("Cantidad de diputados")
