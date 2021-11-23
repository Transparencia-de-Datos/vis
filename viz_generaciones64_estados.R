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
  mutate(agenX_porcentaje = GenX / Total) %>%
  mutate(millenials_porcentaje = Millenials / Total) %>%
  mutate(z_porcentaje = Z/Total)  %>%
 select(estado, silenciosa_porcentaje, boomers_porcentaje, agenX_porcentaje,
        millenials_porcentaje, z_porcentaje)

df1<- df_porcentaje %>%
  gather("Generacion", "Proporcion", 2:6) %>%
  filter(Proporcion != 0) %>%
  mutate(Proporcion = round(Proporcion, 3)) %>%
  mutate(Porcentaje=Proporcion*100) %>%
  arrange(desc(Porcentaje))


  
viz <- ggplot(df1, aes(estado, Porcentaje, fill=Generacion)) + geom_col()
viz + theme_classic() + labs(title="Distribución generacional de los diputados por estados", subtitle ="Legislaturas LXIV", caption = "Fuente: Currícula de la Cámara de Diputados")+
  theme(legend.position = "top", axis.text.x=element_text(angle = 90, hjust = 1)) + geom_text(aes(label = Porcentaje), color = "white", position = "stack", size = 2, hjust = 0.5, vjust = 1) + 
  scale_fill_jama(name = "Generación", labels = c( "X","Boomers", "Millenials", "Silenciosa")) +
  annotation_custom(g_pic, xmin=5, xmax=Inf, ymin=30, ymax=110)



df2<- df1 %>%
  group_by(estado) %>%
  summarise(sum(Porcentaje))
