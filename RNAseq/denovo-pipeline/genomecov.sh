
file=(C3 TDA1 TDA2 TDA3 TDB1 TDB2 TDB3 TSA1 TSA2 TSA3 TSB1 TSB2 TSB3);

for var in "${file[@]}"; do\
 genomeCoverageBed -ibam "filtered_${var}_RSEM/bowtie.csorted.bam"\ 
 -bga > "genomecov/${var}.bed";
 done

