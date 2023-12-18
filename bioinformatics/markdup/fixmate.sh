
file=($(ls *.bam | sed 's/.bam//g'));

for var in ${file[@]}; do\
 echo "doing for ${var}"
 samtools fixmate -m -@ 10 "${var}.bam" "../fixmate/${var}_fixmate.bam";
 done
