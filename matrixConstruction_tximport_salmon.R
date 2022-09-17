library(tximport)
library(GenomicFeatures)

setwd("~/PreProcSEQ-main/5-expressionMatrix/tximport")
dirquant <- "~/PreProcSEQ-main/4-quantification/salmon/quant_salmon/"
files <- list.files(dirquant)
files_import <- paste0(dirquant, files[-1], "/quant.sf")
all(file.exists(files_import))

txdb <- makeTxDbFromGFF("../../gencode.v40.annotation.gff3.gz")

k <- keys(txdb, keytype = "TXNAME")
tx2gene <- ensembldb::select(txdb, k, "GENEID", "TXNAME")

mat_gse <- tximport(files_import,
                    type = "salmon",
                    tx2gene = tx2gene,
                    ignoreAfterBar = TRUE)
save(mat_gse, file = "matrix_salmon_tximport.RData")
