#!/bin/bash
INPUT="2-trimming/trimmomatic/paired"
QUANT="4-quantification"

time while read SAMP \n
        do
            echo "Processing sample ${SAMP}"
            kallisto quant --index=$QUANT/kallisto/gencode_v40_index \
            --output=$QUANT/kallisto/quant_kallisto/${SAMP}_quant --threads=4 \
            $INPUT/${SAMP}_R1_trimmomatic_paired.fastq \
            $INPUT/${SAMP}_R2_trimmomatic_paired.fastq
        done < samplesNames.txt