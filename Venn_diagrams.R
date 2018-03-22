##SCRIPT PARA GENERAR DIAGRAMAS DE VENN
ALCOHOLISM_SNPs<-as.character(GWAS_FOR_ALCOHOLISM$snpid)
OCD_SNPs<-GWAS_FOR_OCD.DF$snpid
ADDICTION_SNPs<-as.character(GWAS_FOR_SAD$snpid)
all.equal(OCD_SNPs, TCS_SNPs)
GWAS_FOR_ALCOHOLISM<-GWAS_FOR_ADDICTIONS.DF[grep("Alcohol",GWAS_FOR_ADDICTIONS.DF$trait), ]
GWAS_FOR_SAD<-GWAS_FOR_ADDICTIONS.DF[grep("Alcohol",GWAS_FOR_ADDICTIONS.DF$trait, invert = T), ]


TOTAL_SNPs.DF<-data.frame(GWAS_FOR_ALCOHOLISM[,0])
TOTAL_SNPs.DF<-data.frame(
  ALCOHOLISM_SNPs=as.character(GWAS_FOR_ALCOHOLISM$snpid),
  OCD_SNPs= c(GWAS_FOR_OCD.DF$snpid, rep(NA, 4846)),
  ADDICTION_SNPs=c(as.character(GWAS_FOR_SAD$snpid), rep(NA, 3544)),
  ALCOHOLISM_AND_ADDICTION=c(ALetADD, rep(NA, 5686)),
  ALCOHOLISM_AND_OCD=c(ALetTOC,rep(NA, 5731)),
  ADDICTION_AND_OCD=c(ADDetTOC, rep(NA, 5736))
)
write.csv(TOTAL_SNPs.DF, "results/TOTAL_SNPs.csv")

##CUÁNTOS "rs" SE COMPARTEN ENTRE DOS FENOTIPOS: ALCOHOLISM AND ADDICTION:
ALetADD<-intersect(ALCOHOLISM_SNPs, ADDICTION_SNPs) #51 SNPs
ALetTOC<-intersect(ALCOHOLISM_SNPs, OCD_SNPs) #6 SNPs
ADDetTOC<-intersect(OCD_SNPs, ADDICTION_SNPs) #1 SNP
ALL<-intersect(intersect(ALCOHOLISM_SNPs, ADDICTION_SNPs), OCD_SNPs)
Reduce(intersect, list(ALCOHOLISM_SNPs, OCD_SNPs, ADDICTION_SNPs))

#GENERANDO EL DIAGRAMA DE VENN 
library(VennDiagram)
# A simple three-set diagram
venn.plot <- draw.triple.venn(5737, 2193, 819,
                              51, 6, 1, 0, c("Alcoholism", "Addiction", "OCD"),
                              fill = c("blue", "red", "green"), lwd = 0)

pdf("results/Triple_Venn_diagram.pdf")
grid.draw(venn.plot)
dev.off()

grid.draw(venn.plot)
grid.newpage()
