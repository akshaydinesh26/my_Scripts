#to extract gene name and biotype from gtf file 
# if it is not available in NCBI genome
#or ensembl biomart

# excecute file as ./biotype_from_gtf.sh <path to file>

# $1 input gtf/gff

# extract rows with gene_biotype values
grep "gene_biotype" $1 > out1.txt

#extract gene name and gene_biotype values
awk -F"[\t;]" '{for(i=1;i<=NF;i++){ if($i~/Name*/){print $i} } }' out1.txt |\
 sed 's/Name=//g' > gene_name.txt
awk -F"[\t;]" '{for(i=1;i<=NF;i++){ if($i~/gene_biotype*/){print $i} } }' out1.txt |\
 sed 's/gene_biotype=//g' > gene_biotype.txt
 
 #combine and write to file
 paste gene_name.txt gene_biotype.txt | column -s $'\t' -t > biotype_out.tsv
 rm out1.txt gene_name.txt gene_biotype.txt
