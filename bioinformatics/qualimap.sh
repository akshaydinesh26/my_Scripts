#!/usr/bin/bash
file=($(ls *.bam | sed 's/_markdup.bam//g'));

for var in "${file[@]}"; do\
 qualimap bamqc\
 -bam "${var}_markdup.bam"\
 -gff /home/bionivid/Desktop/project/stella/1_ref/annotation.gff\
 --java-mem-size=7200M; done

