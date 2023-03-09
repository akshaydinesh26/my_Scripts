 #Trinity --genome_guided_bam /media/bionivid-256/Data_256/New_data/RNA/Susheel_sharma_passionfruit/fastqc/2_alignment/PF-H_1.sorted.bam --max_memory 40G --genome_guided_max_intron 10000 --CPU 6 --output Trinity_assembly_healthy 
 
#Trinity --genome_guided_bam /media/bionivid-256/Data_256/New_data/RNA/Susheel_sharma_passionfruit/fastqc/2_alignment/PF-inf_1.sorted.bam --max_memory 40G --genome_guided_max_intron 10000 --CPU 6 --output Trinity_assembly_infected  
 
for f in `ls *_R1.fastq.gz | sed 's/_R1.fastq.gz//' | sort -u`; do
	echo "doing for "${f} 
	Trinity --seqType fq --max_memory 100G --left ${f}_R1.fastq.gz  --right ${f}_R2.fastq.gz --CPU 10 --output  /media/bionivid-256/Data_256/New_data/RNA/2023/Shashikumar/2_Assembly/${f}_trinity

done
 
