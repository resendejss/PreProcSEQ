library(sva)
library(magrittr)

setwd("~/PreProcSEQ-main/8-batchEffect_removal/")
load("../7-normalizationCounts/tmm/gse_tmm.RData")

count_matrix <- gse.TMM@assays@data$counts
batch <- gse.TMM$Batch
Tissue <- gse.TMM$Tissue

Tissue <- Tissue %>% as.factor() %>% as.numeric()
covar_mat <- as.matrix(Tissue)

adjusted_counts <- ComBat_seq(count_matrix, batch, group = NULL,
                              covar_mod = covar_mat)

range(count_matrix)
range(adjusted_counts)

gse_adjusted <- gse.TMM
gse_adjusted@assays@data$counts <- adjusted_counts
save(gse_adjusted, file = "gse_wthoutBatchEffect_counts.RData")

