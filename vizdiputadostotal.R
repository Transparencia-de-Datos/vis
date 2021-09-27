library(ggplot2)
library(dplyr)
#Cargar datos
diputadostotal <- read.csv("total1.csv",header = TRUE, sep = ",")
viz1<- ggplot(diputadostotal, aes(Diputados, Partido, fill= Legislatura)) + 
  geom_col(position = "dodge2") + coord_flip()

viz1 + theme_classic() + ggtitle("Total diputados por partido en cada Legislatura")

