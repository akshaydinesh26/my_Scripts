#denovo transcriptome pipeline
#seperate scripts before use

#1.
#trinty

#for lop for file names and exceute trinity in loop
#start
for f in `ls *_R1.fastq.gz | sed 's/_R1.fastq.gz//' | sort -u`; do
	echo "doing for "${f} 
	Trinity --seqType fq --max_memory 100G --left ${f}_R1.fastq.gz  --right ${f}_R2.fastq.gz --CPU 10 --output  /media/bionivid-256/Data_256/New_data/RNA/2023/Shashikumar/2_Assembly/${f}_trinity

done
#end

#2.
#change the trinity string in transcript fasta sequence header to sample name
#merge all files
#start 
sed 's/Trinity/<sample name>/g' transcript.fasta > header_changed.fasta
cat header_changed1.fasta header_changed2.fasta > merged.fasta
#end

#3.
#cdhit merged transcript file to remove redudancy
#start
cd-hit-est -i merged.fasta -o combined_cdhit.fasta -c 0.95 -d 0 -n 8 -T 3 -M 10000
#end

#4.
#remove smaller reads less than Xbp
#start
faSize cdhit.fasta -detailed | awk '$2>500 {print $1}' > size_selected.txt
faSomeRecords cdhit.fasta size_selected.txt size_selected.fasta
#end

#4.
#abundance estimation
#start 
#reference
ref="/media/bionivid-256/Data_256/New_data/RNA/2023/Shashikumar/2_Assembly/ref/combined_cdhit.fasta";

#sample names
sample=($(ls *_R1.fastq.gz | sed 's/_R1.fastq.gz//g'));

#estimate abundance using script from trinity
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
#end

#5.
#get read count using samtools idxstats
#3rds colum has count
#start
samtools idxstats coordsorted_bam.bam > count.txt
#end

#6.
#for getting coverage info at every genomic positions info
#start
file=(C3 TDA1 TDA2 TDA3 TDB1 TDB2 TDB3 TSA1 TSA2 TSA3 TSB1 TSB2 TSB3);

for var in "${file[@]}"; do\
 genomeCoverageBed -ibam "filtered_${var}_RSEM/bowtie.csorted.bam"\ 
 -bga > "genomecov/${var}.bed";
 done
#end

#7.
#use transimprove or abundance based filter

#8.
#differential expression analysis














