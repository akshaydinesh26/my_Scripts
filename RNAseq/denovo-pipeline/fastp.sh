#!/usr/local/bin

#this is for paired end reads
#name of the files should be name_R[1/2].fastq.gz
#run the script on directory containing reads
#execute as:
#fasp.sh <output folder>

file=($(ls *_R1.fastq.gz | sed 's/_R1.fastq.gz//g'));
out=$1
mkdir "${out}/report"

for var in "${file[@]}"; 
do
 echo "doing for ${var}"
 local read1="${var}_R1.fastq.gz"
 local read2="${var}_R2.fastq.gz"
 fastp 
 -i $read1 
 -I $read2 
 -o "${out}/filtered_$read1" 
 -O "${out}/filtered_$read2" 
 -w 10 
 -q 30 
 -l 75 
 -h "${out}/report/${var}.html";
done
