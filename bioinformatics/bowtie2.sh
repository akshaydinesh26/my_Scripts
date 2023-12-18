#!/usr/bin/bash

#execute as ./bowtie2.sh index outputfolder
file=($(ls *_1.fq.gz | sed 's/_1.fq.gz//g' | sed 's/filtered_//g'));
index=$1
out=$2

for var in ${file[@]}; do\
 echo "doing for ${var}"
 bowtie2 -p 10 -x ${index}\
 -1 "filtered_${var}_1.fq.gz" -2 "filtered_${var}_2.fq.gz" | samtools view -@ 10\
 -bS -o "${out}/${var}.bam";
 done
