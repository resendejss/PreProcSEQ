#!/bin/bash

time while read SAMP \n
        do
            echo "Processing sample ${SAMP}"
            salmon quant -i 4-quantification/salmon/gencode_v40_index -l A \
            -1 2-trimming/trimmomatic/paired/${SAMP}_R1_trimmomatic_paired.fastq \
            -2 2-trimming/trimmomatic/paired/${SAMP}_R2_trimmomatic_paired.fastq \
            -p 4 --gcBias --validateMappings -o 4-quantification/salmon/quant_salmon/${SAMP}_quant
        done < samplesNames.txt