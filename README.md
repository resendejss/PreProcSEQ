# PreProcSEQ
Quality control pipeline and pre-processing of data from RNA-Seq

## Introduction
RNA-Seq has stood out among sequencing technologies. Since then, the subsequent analysis of the raw data obtained from this technology has gained focus in bioinformatics. This Pipeline aims to present the main steps for the construction of the gene expression matrix, from raw RNA-Seq data.

Among the steps presented in this pipeline, the topics are addressed:

* quality control

* trimming

* transcript quantification

* annotation of transcripts

* normalization

* batch effect removal

## Installation of the necessary tools for the execution of the pipeline
Make sure you have installed all the tools the pipeline needs to run:

Tools: [FastQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/),  [MultiQC](https://multiqc.info/), [Trimmomatic](http://www.usadellab.org/cms/?page=trimmomatic), [Salmon](https://combine-lab.github.io/salmon/), [Kallisto](https://pachterlab.github.io/kallisto/about), [R](https://www.r-project.org/)

R packages: [tximport](https://bioconductor.org/packages/release/bioc/html/tximport.html), [tximeta](https://bioconductor.org/packages/release/bioc/html/tximeta.html), [GenomicFeatures](https://bioconductor.org/packages/release/bioc/html/GenomicFeatures.html), [ensembldb](https://bioconductor.org/packages/release/bioc/html/ensembldb.html), [SummarizedExperiment](https://bioconductor.org/packages/release/bioc/html/SummarizedExperiment.html), [readxl](https://cran.r-project.org/web/packages/readxl/index.html), [AnnotationHub](https://bioconductor.org/packages/release/bioc/html/AnnotationHub.html), [stringr](https://cran.r-project.org/web/packages/stringr/index.html), [edgeR](https://bioconductor.org/packages/release/bioc/html/edgeR.html), [sva](https://bioconductor.org/packages/release/bioc/html/sva.html), [magrittr](https://cran.r-project.org/web/packages/magrittr/index.html)

In order to simplify the installation process, we provide the `installTools.sh` script, which contains the commands for installing each tool.

Below is a quick start of the pipeline, [click here](https://bookdown.org/jean_souza/PreProcSEQ/) to access the complete pipeline manual.

## Quick start
### I. download the repository and extract the files to your home folder directory
```{bash}
cd ~
wget https://github.com/resendejss/PreProcSEQ/archive/refs/heads/main.zip
unzip main.zip
```

### II. installation of tools
```{bash}
./installTools.sh
```

### III. FASTQs quality control
Let's check the quality of each FASTQ file. The `0-samples` directory contains the files. 
```{bash}
./qualityControl_beforeTrimming.sh
```

FastQC results were saved to `1-qualityControl_beforeTrimming/outputFastQC` and MultiQC results were saved to `1-qualityControl_beforeTrimming/outputMultiQC`

### III. trimming
```{bash}
./trimming_trimmomatic.sh
```
The resulting files from the Trimmomatic process are in `2-trimming/trimmomatic/paired` and `2-trimming/trimmomatic/unpaired`. In `paired` are the files that were removed from the low quality bases. Under `unpaired` are the readings that have been removed.

### IV. quality control of FASTQs after trimming
```{bash}
./qualityControl_afterTrimming.sh
```
FastQC results are in `PreProcSEQ-main/3-qualityControl_afterTrimming/outputFastqc` and MultiQC results are in `PreProcSEQ-main/3-qualityControl_afterTrimming/outputMultiqc`.

### V. transcript quantification
There are two quantification tool options: Salmon and Kallisto.
#### Salmon
```{bash}
# index construction
./salmon_index.sh

# quantification
./salmon_ quant.sh
```
#### Kallisto
```{bash}
# index construction
./kallisto_index.sh

# quantification
./kallisto_quant.sh
```
Salmon results will be in `4-quantification/salmon/quant_salmon`. Kallisto results will be in `4-quantification/kallisto/quant_kallisto`.

### VI. construction of the gene expression matrix
#### tximeta
Running the R script via terminal:
```{bash}
Rscript matrixConstruction_tximeta_salmon.R
```
#### tximport
Running the R script via terminal:
```{bash}
# salmon output
Rscript matrixConstruction_tximport_salmon.R

# kallisto output
Rscript matrixConstruction_tximport_kallisto.R
```
The matrices will be in `5-expressionMatrix`

### VII. annotation of transcripts
Running the R script via terminal:
```{bash}
# matrix_kallisto_tximport
Rscript annotaionTranscripts_kallisto_matrixTximport.R

# matrix_salmon_tximport
Rscript annotationTranscript_salmon_matrixTximport.R

# matrix_kallisto_tximeta
Rscript annotationTranscripts_salmon_tximeta.R
```

### VIII. normalization of counts
```{bash}
Rscript normalizationTMM.R
```
The results will be in `7-normalizationCounts/tmm`

### IX. batch effect removal
```{bash}
# counts
Rscript batchEffectRemoval_counts.R

# normalized data
Rscript batchEffectRemoval_TMM.R
```
The results will be in `8-batchEffect_removal`
