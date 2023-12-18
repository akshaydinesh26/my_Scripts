
file=($(ls *.bam | sed 's/_fixmate.bam//g'));

for var in ${file[@]}; do\
 echo "doing for ${var}"
 samtools sort -@ 10 -o "../${var}_sorted.bam" "${var}_fixmate.bam";
 done
