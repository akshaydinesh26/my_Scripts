#!/usr/bin/bash

#reference
ref="/media/bionivid-256/Data_256/New_data/RNA/2023/Shashikumar/2_Assembly/ref/combined_cdhit.fasta";

#sample names
sample=($(ls *_R1.fastq.gz | sed 's/_R1.fastq.gz//g'));

#estimate abundance
for var in "${sample[@]}"; do\
 align_and_estimate_abundance.pl\
 --seqType fq\
 --transcripts ${ref}\
 --left "${var}_R1.fastq.gz"\
 --right "${var}_R2.fastq.gz"\
 --est_method RSEM\
 --aln_method bowtie\
 --trinity_mode\
 --output_dir "../3_quantification/${var}_RSEM"\
 --thread_count 10\
 --coordsort_bam;
 done  
