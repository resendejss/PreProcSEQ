library(AnnotationHub)
library(GenomicFeatures)
library(ensembldb)
library(SummarizedExperiment)

setwd("~/PreProcSEQ-main/6-annotationTranscripts")

ah <- AnnotationHub()

edb <- query(ah, pattern = c("Homo sapiens", "EnsDb",106))[[1]]
gns <- genes(edb)
EnsDbAnnotation <- as.data.frame(gns)
EnsDbAnnotation <- EnsDbAnnotation[,c("gene_id","symbol","gene_biotype","entrezid")]
dim(EnsDbAnnotation)
colnames(EnsDbAnnotation) <- c("ensemblid","symbol","gene_biotype","entrezid")

load("../5-expressionMatrix/tximport/matrix_kallisto_tximport.RData")

matrix_expr <- mat_gse$abundance

nrow(matrix_expr)
rownames(matrix_expr)

rownames(matrix_expr) <- stringr::str_replace(rownames(matrix_expr), "\\...$", "")
rownames(matrix_expr) <- stringr::str_replace(rownames(matrix_expr), "\\..$", "")

all(rownames(matrix_expr)%in%rownames(EnsDbAnnotation))

rowAnnotation <- EnsDbAnnotation[rownames(matrix_expr),]
rowAnnotation <- data.frame(rowAnnotation, stringsAsFactors = F)
rownames(rowAnnotation) <- rowAnnotation$gene_id

idx <- match(rownames(matrix_expr),gns$gene_id)

rowRanges <- GRanges(seqnames = gns@seqnames[idx],
                     ranges = gns@ranges[idx],
                     strand = gns@strand[idx])

rownames(mat_gse$abundance) <- rownames(matrix_expr)
rownames(mat_gse$counts) <- rownames(matrix_expr)
rownames(mat_gse$length) <- rownames(matrix_expr)

dirquant <- "~/PreProcSEQ-main/4-quantification/kallisto/quant_kallisto"
files <- list.files(dirquant)
filesnames <- gsub("_quant","",files[-1])

colnames(mat_gse$abundance) <- filesnames
colnames(mat_gse$counts) <- filesnames
colnames(mat_gse$length) <- filesnames

coldata <- readxl::read_xlsx("../metadata.xlsx")
coldata <- as.data.frame(coldata)
rownames(coldata) <- coldata$Sample_id

colnames(mat_gse$abundance) <- rownames(coldata)
colnames(mat_gse$counts) <- rownames(coldata)
colnames(mat_gse$length) <- rownames(coldata)

mat_annot <- SummarizedExperiment(assays = list(counts=mat_gse$counts, 
                                                abundance=mat_gse$abundance,
                                                length=mat_gse$length),
                                  rowRanges = rowRanges,
                                  colData = coldata)

rowData(mat_annot) <- rowAnnotation

save(mat_annot, file = "matrix_gse_kallisto_tximport_noted.RData")
