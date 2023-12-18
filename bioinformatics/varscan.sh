#!/bin/bash

#for f in $(ls *.bam | sed 's/.bam//' | sort -u) ; do 
	#echo " doing for ${f}" 
	#samtools mpileup -f /media/bionivid-256/Data_256/New_data/RNA/Dr_Neeraj/Wheat/2_Alignment/GCF_018294505.1_IWGSC_CS_RefSeq_v2.1_genomic.fna ${f}.bam > ${f}.mpileup
	
#done 	

for f in $(ls *.mpileup | sed 's/.mpileup//' | sort -u) ; do 
	echo " doing for ${f}"

	java -jar '/home/bionivid-256/Programs/VarScan.v2.3.9.jar' mpileup2snp ${f}.mpileup --min-coverage 15 --min-reads2 8  --p-value 0.05 --output-vcf 1 > ../${f}_snp.vcf
	java -jar '/home/bionivid-256/Programs/VarScan.v2.3.9.jar' mpileup2indel ${f}.mpileup --min-coverage 15 --min-reads2 8 --p-value 0.05 --output-vcf 1 > ../${f}_indel.vcf
	
done	

#for f in $(ls *.vcf | sed 's/.vcf//' | sort -u) ; do 

#	vcftools --vcf ${f}.vcf  --min-meanDP 25 --recode --recode-INFO-all --out ${f}_filtered.vcf 
#done 	
