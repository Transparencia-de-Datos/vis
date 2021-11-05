library(readxl)
library(dplyr)
library(tidyr)
library(ggplot2)
library(forcats)
library(ggsci)

df <- read_excel("datos/Generaciones_2018_2021.xlsx",sheet = 3)
df1<- df %>%
  select( Partido ,Silenciosa,Boomers,GenX,Millenials, Z) %>%
  filter(Partido!= "Total")%>%
  gather("Generacion", "Total", 2:6) %>%
  filter(Total != 0) %>%
  mutate(Generacion = fct_reorder(Generacion,desc(Total))) %>%
  mutate(Partido = fct_reorder(Partido,desc(Total))) 

viz <- ggplot(df1, aes(Partido, Total, fill=Generacion)) + geom_col(position="dodge2")
viz + theme_classic() + labs(title="Distribución generacional de los diputados por partido", subtitle ="Legislatura LXIV", caption = "Fuente: Currícula de la Cámara de Diputados") +
  theme(legend.position = "top") + geom_text(aes(label = Total),  position = position_dodge(width = 1), vjust = -.4) +
  scale_fill_jama() + scale_y_continuous(limits=c(0, 120))

