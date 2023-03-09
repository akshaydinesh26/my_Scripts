#peprare gene.bed from gtf file using gff2bed
#gene.bed should have
#chr	Gene-start	Gene-end	Gene-symbol	Entrez-Gene ID	Gene-Description	Gene-biotype
for f in `ls *.vcf | sed 's/.vcf//' | sort -u` ; do 
	awk '{print $1"\t"$2"\t"$2"\t"$4"\t"$5}' ${f}.vcf | grep "#" -v > ${f}snp.bed
	bedtools window -a ${f}snp.bed -b genes.bed -l 0 -r 0 > ${f}_anno.bed
done
