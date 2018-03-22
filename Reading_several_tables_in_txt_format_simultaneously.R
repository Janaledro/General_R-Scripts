##Cargando todas las tablas para generar una sola
#POR MEDIO DE ESTE SCRIPT, SE ES POSIBLE LEER VARIAS TABLAS (EN ESTE CASO, 10)
#SIEMPRE Y CUANDO TODAS TENGAN EL MISMO NÚMERO DE COLUMNAS Y EL MISMO TÍTULO EN 
#CADA UNA DE ÉSTAS.
library(plyr)
setwd("~/Documentos/")
file_list<-list.files(pattern = ".*.txt")
SNPS_FOR_ADDICTION.DF = ldply(file_list, read.table, sep = "\t", header= T)
write.csv(SNPS_FOR_ADDICTION.DF, file = "SNPS_FOR_ADDICTIONS.csv")
