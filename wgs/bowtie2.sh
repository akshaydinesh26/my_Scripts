#!/usr/bin/bash
file=($(ls *_1.fq.gz | sed 's/_1.fq.gz//g' | sed 's/filtered_//g'));

for var in ${file[@]}; do\
 echo "doing for ${var}"
 bowtie2 -p 10 -x /media/bionivid-256/Data_256/New_data/WGS/2023/Dr.Stella/1_ref/Apidx\
 -1 "filtered_${var}_1.fq.gz" -2 "filtered_${var}_2.fq.gz" | samtools view -@ 10\
 -bS -o "../3_alignment/${var}.bam";
 done
