###Input 2 files

#Count.csv
#EXAMPLE FILE-
#Gene Sample1,Sample2,Sample3,Sample4
#Gene1 2,4,6,8

#Metadata.csv
#EXAMPLE FILE-
#id,dex,type
#Sample1,Control,paired-end
#Sample2,Control,paired-end	
#Sample3,Treated,paired-end
#Sample4,Treated,paired-end

###Script
library(DESeq2)
library(dplyr)

countData <- read.csv("/home/bionivid/Desktop/project/shashikumar/3_DGE/output/deseq_r_transimprove/countData.csv",header = TRUE, sep = ",")
head(countData)

metaData <- read.csv("Metadata.csv",header = TRUE, sep = ",")
head(metaData)

dds <- DESeqDataSetFromMatrix(countData=(countData), colData=metaData, design=~dex, tidy = TRUE)

#keep <- rowSums(counts(dds)) >= 10


keep <- rowSums(counts(dds) >= 3 ) >= 6
#filters out genes with less than 5 normalised counts in less than 6 of the samples
dds_filt <- dds[keep,]
vld <- varianceStabilizingTransformation(dds_filt, blind=FALSE)
write.table(assay(vld),file="log_expression.tsv",sep="\t")
View(assay(vld))

#no of transcripts before and after filtering
nrow(counts(dds))  #[250035]
nrow(counts(dds_filt)) #[]

#counts(dds_filt) |> summary() |> View()
#counts(dds) |> summary() |> View()
#PCA plot
png("samples_PCA_plot.png")
DESeq2::plotPCA(vld, intgroup=c("dex"))
dev.off()

dds_filt <- DESeq(dds_filt)
metaData
#Sets "Control" sample as the contrast
#res <- results(dds, contrast = c("dex", 'Treated', 'Control'))
#res1 C vs TDA
#res2 C vs TDB
#res3 C vs TSA
#res4 C vs TSB
#res5 TDA vs TDB
#res6 TSA vs TSB
#res7 TDA vs TSA
#res8 TDB vs TSB
res1 <- results(dds_filt, contrast=c("dex", "TDA", "C"),pAdjustMethod = 'BH', parallel = TRUE)
res2 <- results(dds_filt, contrast=c("dex", "TDB", "C"),pAdjustMethod = 'BH', parallel = TRUE)
res3 <- results(dds_filt, contrast=c("dex", "TSA", "C"),pAdjustMethod = 'BH', parallel = TRUE)
res4 <- results(dds_filt, contrast=c("dex", "TSB", "C"),pAdjustMethod = 'BH', parallel = TRUE)
res5 <- results(dds_filt, contrast=c("dex", "TDB", "TDA"),pAdjustMethod = 'BH', parallel = TRUE)
res6 <- results(dds_filt, contrast=c("dex", "TSB", "TSA"),pAdjustMethod = 'BH', parallel = TRUE)
res7 <- results(dds_filt, contrast=c("dex", "TSA", "TDA"),pAdjustMethod = 'BH', parallel = TRUE)
res8 <- results(dds_filt, contrast=c("dex", "TSB", "TDB"),pAdjustMethod = 'BH', parallel = TRUE)
#res <- lfcShrink(dds, contrast=c("Condition", "Treated", "Control"), res = res)


#sorts result based on ascending p-value
res1 <- res1[order(res1$pvalue),]
res2 <- res2[order(res2$pvalue),]
res3 <- res3[order(res3$pvalue),]
res4 <- res4[order(res4$pvalue),]
res5 <- res5[order(res5$pvalue),]
res6 <- res6[order(res6$pvalue),]
res7 <- res7[order(res7$pvalue),]
res8 <- res8[order(res8$pvalue),]

#write output to file
write.table(res1,file="TDA_C_deseq2_results.txt",sep="\t")
write.table(res2,file="TDB_C_deseq2_results.txt",sep="\t")
write.table(res3,file="TSA_C_deseq2_results.txt",sep="\t")
write.table(res4,file="TSB_C_deseq2_results.txt",sep="\t")
write.table(res5,file="TDB_TDA_deseq2_results.txt",sep="\t")
write.table(res6,file="TSB_TSA_deseq2_results.txt",sep="\t")
write.table(res7,file="TSA_TDA_deseq2_results.txt",sep="\t")
write.table(res8,file="TSB_TDB_deseq2_results.txt",sep="\t")

##To get normalised expression - to be confirmed 
baseMeanPerLvl <- sapply( levels(dds$dex), function(lvl) rowMeans( counts(dds,normalized=TRUE)[,dds$dex == lvl]))

or

baseMeanPerLvl <- sapply( levels(dds$dex), function(lvl) rowMeans( counts(dds,normalized=TRUE)[,dds$dex == lvl, drop=F] ) )

write.table(baseMeanPerLvl, file="basemeanvalues.txt", sep="\t", quote=F, col.names=NA)

hist(res7$pvalue,breaks=500)


