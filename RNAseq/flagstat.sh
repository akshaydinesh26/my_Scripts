file=($(ls *.bam | sed 's/.bam//g'))

for var in "${file[@]}"; do\
 samtools flagstat "${var}.bam" > "${var}.txt";
 done 
 
