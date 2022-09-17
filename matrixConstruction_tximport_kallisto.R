library(tximport)
library(GenomicFeatures)

setwd("~/PreProcSEQ-main/5-expressionMatrix/tximport")
dirquant <- "~/PreProcSEQ-main/4-quantification/kallisto/quant_kallisto/"
files <- list.files(dirquant)
files_import <- paste0(dirquant, files[-1], "/abundance.tsv")
all(file.exists(files_import))

txdb <- makeTxDbFromGFF("../../gencode.v40.annotation.gff3.gz")

k <- keys(txdb, keytype = "TXNAME")
tx2gene <- ensembldb::select(txdb, k, "GENEID", "TXNAME")

mat_gse <- tximport(files_import,
                    type = "kallisto",
                    tx2gene = tx2gene,
                    ignoreAfterBar = TRUE)
save(mat_gse, file = "matrix_kallisto_tximport.RData")
