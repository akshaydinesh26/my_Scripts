for f in `ls *_R1.fastq.gz | sed 's/_R1.fastq.gz//'`; do

	echo " doing for ${f}"
	fastp -i ${f}_R1.fastq.gz -I ${f}_R2.fastq.gz -o /media/bionivid-256/Data_256/New_data/RNA/2023/Shashikumar/1_filteredReads/filtered_${f}_R1.fastq.gz -O /media/bionivid-256/Data_256/New_data/RNA/2023/Shashikumar/1_filteredReads/filtered_${f}_R2.fastq.gz -w 10 -q 30 -l 75 -a AGATCGGAAGAG -h /media/bionivid-256/Data_256/New_data/RNA/2023/Shashikumar/1_filteredReads/fastp_report/${f}.html -j /media/bionivid-256/Data_256/New_data/RNA/2023/Shashikumar/1_filteredReads/fastp_report/${f}.json
done
