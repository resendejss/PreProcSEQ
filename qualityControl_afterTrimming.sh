#!/bin/bash
INPUTFASTQC="2-trimming/trimmomatic/paired"
OUTPUTFASTQC="3-qualityControl_afterTrimming/outputFastqc"
OUTPUTMULTIQC="3-qualityControl_afterTrimming/outputMultiqc"

/usr/bin/time -f "\nResultado do time: \nTempo decorrido = %E" \
fastqc $INPUTFASTQC/*.fastq -o $OUTPUTFASTQC

/usr/bin/time -f "\nResultado do time: \nTempo decorrido = %E" \
multiqc $OUTPUTFASTQC/. -o $OUTPUTMULTIQC
