file=($(ls *.bam))

for var in "${file[@]}"; do\
 samtools flagstat "${var}.bam" > "${var}.txt";
 done 
 
