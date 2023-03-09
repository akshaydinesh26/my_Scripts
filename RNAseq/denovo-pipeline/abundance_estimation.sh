#!/usr/bin/bash

#this is for paired end reads
#run the script in the folder containing reads
#abundance estimation using perl script with Trinity
#REQUIREMENT:
#Trinity
#samtools
#RSEM
#bowtie

#execute as:
#abundance_estimation.sh <reference fasta file> <threads>

#reference
ref=$1;
thread=$2;

#sample names
sample=($(ls *_R1.fastq.gz | sed 's/_R1.fastq.gz//g'));

#prepare reference
align_and_estimate_abundance.pl\
 --seqType fq\
 --transcripts ${ref}\
 --est_method RSEM\
 --aln_method bowtie\
 --trinity_mode\
 --thread_count ${thread}\
 --coordsort_bam\
 --prep_reference


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
 --thread_count ${thread}\
 --coordsort_bam;
 done  
