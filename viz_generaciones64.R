library(readxl)
library(dplyr)
library(tidyr)
library(ggplot2)
library(ggsci)
library(forcats)


df <- read_excel("datos/Generaciones_2018_2021.xlsx",sheet = 1)
df1<- df %>%
  select(  tipoEleccion ,Silenciosa,Boomers,GenX,Millenials, Z) %>%
  gather("Generacion", "Total", 2:6) %>%
  filter(Total != 0) %>%
  mutate(Generacion=fct_reorder(Generacion, desc(Total))) 

viz1 <- ggplot(df1, aes(tipoEleccion,Total, fill=Generacion)) + geom_col(position="dodge")
viz1 + theme_classic() + labs(title="Distribución generacional diputados por tipo de elección", subtitle ="Legislaturas LXIV", caption = "Fuente: Currícula de la Cámara de Diputados") +
  theme(legend.position = "top") + geom_text(aes(label = Total),  position = position_dodge(width = 1), vjust = -.4) + 
  scale_fill_jama()+ scale_y_continuous(limits=c(0, 155)) + xlab("Tipo de elección")

