library(ggplot2)
library(dplyr)
#Cargar datos
diputadostotal <- read.csv("total1.csv",header = TRUE, sep = ",", fileEncoding="ISO-8859-1")
viz1<- ggplot(diputadostotal, aes(Diputados, Partido, fill= Legislatura)) +
  geom_col(position = "dodge2") + coord_flip()

viz1 + theme_bw() + ggtitle("Total diputados por partido en cada Legislatura")
