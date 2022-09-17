library(AnnotationHub)
library(GenomicFeatures)
library(ensembldb)

setwd("~/PreProcSEQ-main/6-annotationTranscripts")

ah <- AnnotationHub()

edb <- query(ah, pattern = c("Homo sapiens", "EnsDb",106))[[1]]
gns <- genes(edb)
EnsDbAnnotation <- as.data.frame(gns)
EnsDbAnnotation <- EnsDbAnnotation[,c("gene_id","symbol","gene_biotype","entrezid")]
dim(EnsDbAnnotation)
colnames(EnsDbAnnotation) <- c("ensemblid","symbol","gene_biotype","entrezid")

load("../5-expressionMatrix/tximeta/matrix_gse_salmon_tximeta.RData")

nrow(gse)
gseAnnotation <- rowData(gse)

rownames(gseAnnotation) <- stringr::str_replace(rownames(gseAnnotation), "\\...$", "")
rownames(gseAnnotation) <- stringr::str_replace(rownames(gseAnnotation), "\\..$", "")

all(rownames(gseAnnotation)%in%rownames(EnsDbAnnotation))

rowAnnotation <- EnsDbAnnotation[rownames(gseAnnotation),]
rowAnnotation <- data.frame(gseAnnotation, rowAnnotation, stringsAsFactors = F)
rownames(rowAnnotation) <- rowAnnotation$gene_id
rowData(gse) <- rowAnnotation

save(gse, file = "matrix_gse_salmon_tximeta_noted.RData")