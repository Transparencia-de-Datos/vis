library(readxl)
library(dplyr)
library(tidyr)
library(ggplot2)
library(ggsci)
library(png)


df <- read_excel("datos/Generaciones_2018_2021.xlsx",sheet = 5)
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
  filter(Proporcion != 0 ) %>%
  filter(estado != "Sin asginar") %>%
  mutate(Proporcion = round(Proporcion, 3)) %>%
  mutate(Porcentaje = Proporcion *100) %>%
  arrange(desc(Porcentaje))

viz <- ggplot(df1, aes(estado, Porcentaje, fill=Generacion)) + geom_col()
viz + theme_classic() + labs(title="Distribución generacional de los diputados por estados", subtitle ="Legislatura LXV (2021-2024)", caption = "Fuente: Currícula de la Cámara de Diputados") +
  theme(legend.position = "top", axis.text.x=element_text(angle =90, hjust =1))+
     geom_text(aes(label = Porcentaje), color = "white", fontface=2, position = "stack", size = 3, hjust = 0.5, vjust = 1) +
   scale_fill_jama(name = "Generación", labels = c("X", "Boomers" ,"Millenials", "Silenciosa", "Z")) 



