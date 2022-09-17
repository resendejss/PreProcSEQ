library(tximeta)
library(SummarizedExperiment)
library(readxl)
library(GenomicFeatures)

setwd("~/PreProcSEQ-main/5-expressionMatrix/tximeta")
dirquant <- "~/PreProcSEQ-main/4-quantification/salmon/quant_salmon/"

coldata <- read_xlsx("../../metadata.xlsx")
coldata$names <- coldata$Sample_id
coldata$files <- paste0(dirquant,coldata$names,"_quant/","quant.sf")
all(file.exists(coldata$files))
coldata <- as.data.frame(coldata)
rownames(coldata) <- coldata$names

indexDir <- file.path("../../4-quantification/salmon/gencode_v40_index")
gffPath <- file.path("../../gencode.v40.annotation.gff3.gz")
fastaFTP <- "ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_40/gencode.v40.transcripts.fa.gz"

makeLinkedTxome(indexDir = indexDir,
                source = "GENCODE",
                organism = "Homo sapiens",
                release = "40",
                genome = "GRCh38",
                fasta = fastaFTP,
                gtf = gffPath,
                write = FALSE)

se <- tximeta(coldata, useHub = F)
gse <- summarizeToGene(se)

save(gse, file="matrix_gse_salmon_tximeta.RData")