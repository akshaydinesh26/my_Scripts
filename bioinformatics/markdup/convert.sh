#!/usr/bin/bash

file=($(ls *.sam | sed 's/.sam//g'));

for var in "${file[@]}"; do\
 samtools view -@ 10 -bS "${var}.sam" -o "sorted/${var}.bam";
 done 
