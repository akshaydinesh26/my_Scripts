#!/bin/bash

for f in $(ls *.bam | sed 's/_sorted.bam//' | sort -u) ; do 
	echo " doing for ${f}" 	

	samtools markdup ${f}_sorted.bam "/media/bionivid-256/Data_256/New_data/RNA/2023/Shashikumar/SNP/1_Alignment/markdup/${f}_markdup.bam"; 
 done

