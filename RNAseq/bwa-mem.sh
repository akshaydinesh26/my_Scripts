
for f in `ls *_R1.fastq.gz | sed 's/_R1.fastq.gz//' | sort -u`; do
	echo "doing for ${f}"
	
	bwa mem -t 8 /media/bionivid-256/Data_256/New_data/RNA/2023/Shashikumar/SNP/0_ref/Assembly_idx ${f}_R1.fastq.gz ${f}_R2.fastq.gz > /media/bionivid-256/Data_256/New_data/RNA/2023/Shashikumar/SNP/1_Alignment/${f}.sam
	samtools view -@ 8 -bS /media/bionivid-256/Data_256/New_data/RNA/2023/Shashikumar/SNP/1_Alignment/${f}.sam | samtools sort -@ 8 -o /media/bionivid-256/Data_256/New_data/RNA/2023/Shashikumar/SNP/1_Alignment/${f}.bam
	rm ${f}.sam;
 done 
