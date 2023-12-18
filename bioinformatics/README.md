###_**need of these scripts**_<br>
Some tasks of RNAseq analysis pipeline can be accomplished using these scripts.

###**biotype_from_gtf.sh**<br>
bash script for extracting biotype information from gtf file

###**exon_bed_extract.R**<br>
R script to obtain bed file of exons from gtf file<br>
exon.bed is useful for filtering aligned reads

###**give_status.R**<br>
assign status to genes based on pvalue and log2FoldChange in Differential gene expression analysis results<br>
    pvalue > 0.05 - non-significant<br>
    pvalue < 0.05 & log2FoldChange > 2 - upregulated<br>
    pvalue < 0.05 & log2FoldChange < -2 - downregulated<br>
    pvalue < 0.05 & -2 < log2FoldChange < 2 - baseline<br>

###**bowtie2.sh**<br>
bowtie alignment script<br>

###**bwa-mem.sh**<br>
bwa-mem alignment script<br>
