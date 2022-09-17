#!/bin/bash
INPUT="0-samples"
OUTPUTP="2-trimming/trimmomatic/paired"
OUTPUTUNP="2-trimming/trimmomatic/unpaired"

time while read SAMP \n
            do
            TrimmomaticPE $INPUT/${SAMP}_R1.fastq $INPUT/${SAMP}_R2.fastq \
            $OUTPUTP/${SAMP}_R1_trimmomatic_paired.fastq \
            $OUTPUTUNP/${SAMP}_R1_trimmomatic_unpaired.fastq \
            $OUTPUTP/${SAMP}_R2_trimmomatic_paired.fastq \
            $OUTPUTUNP/${SAMP}_R2_trimmomatic_unpaired.fastq \
            ILLUMINACLIP:TruSeq3-PE-2.fa:2:30:10 \
            LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36
        done < samplesNames.txt
