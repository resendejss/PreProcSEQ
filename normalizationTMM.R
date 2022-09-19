library(edgeR)
library(SummarizedExperiment)

setwd("~/PreProcSEQ-main/7-normalizationCounts/tmm/")
load("../../6-annotationTranscripts/matrix_gse_salmon_tximeta_noted.RData")

gexp.counts.brut <- assay(gse)

dge <- DGEList(counts=gexp.counts.brut)
dge <- calcNormFactors(dge)
gexp.TMM <- cpm(dge)

gse.TMM <- gse
gse.TMM@assays@data$abundance <- gexp.TMM
save(gse.TMM, file = "gse_tmm.RData")
################################################################################
