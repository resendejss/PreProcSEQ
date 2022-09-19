library(sva)
library(SummarizedExperiment)

setwd("~/PreProcSEQ-main/8-batchEffect_removal/")
load("../7-normalizationCounts/tmm/gse_tmm.RData")

mat <- gse.TMM@assays@data$abundance
colAnnotation <- colData(gse.TMM)
modcombat <- model.matrix(~Tissue, data = colAnnotation)
mat <- ComBat(dat = mat, 
              batch = colAnnotation$Batch, 
              mod = modcombat)
gse.TMM.withoutBE <- gse.TMM
gse.TMM.withoutBE@assays@data$abundance <- mat

save(gse.TMM.withoutBE,file = "gse_withoutBatchEffect_TMM.RData")
