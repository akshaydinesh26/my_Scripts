#!/usr/bin/bash

#requirment:

#execute as:

index=$1
out=$2

files=($(ls *_1.fastq.gz | sed 's/_1.fastq.gz//g'))

for var in ${files[@]}; 
do
 r1="${var}_1.fastq.gz"
 r2="${var}_2.fastq.gz" 
 bwa mem -t 8 ${index} ${r1} ${r2} > "${out}/${var}.sam"
 samtools -bS "${out}/${var}.sam" | samtools sort -o "${out}/${var}.bam"
 rm "${out}/${var}.sam"
done
