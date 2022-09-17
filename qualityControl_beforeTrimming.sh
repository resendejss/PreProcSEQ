#!/bin/bash
INPUTFASTQC="0-samples"
OUTPUTF="1-qualityControl_beforeTrimming/outputFastqc"
OUTPUTM="1-qualityControl_beforeTrimming/outputMultiqc"

/usr/bin/time -f "\nResultado do time: \nTempo decorrido = %E" \
fastqc $INPUTFASTQC/*.fastq -o $OUTPUTF

/usr/bin/time -f "\nResultado do time: \nTempo decorrido = %E" \
multiqc $OUTPUTF/. -o $OUTPUTM