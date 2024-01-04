
file=();

for var in "${file[@]}"; do\
 genomeCoverageBed -ibam "filtered_${var}_RSEM/bowtie.csorted.bam"\ 
 -bga > "genomecov/${var}.bed";
 done

