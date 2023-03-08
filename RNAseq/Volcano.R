setwd("/home/bionivid/Desktop/project/shashikumar/3_DGE/output/deseq_r_transimprove/volcanoplot")
library(EnhancedVolcano)
res<-read.delim("TD", header = TRUE)

head(res)
names(res) <- c("pid","log2FoldChange","pval")

keyvals <- rep('grey30', nrow(res))
names(keyvals) <- rep('BASELINE', nrow(res))
names(keyvals)[which(res$pval > 0.05)] <- 'BASELINE'
keyvals[which(res$log2FoldChange > 2 & (res$pval < 0.05))] <- 'red2'
names(keyvals)[which(res$log2FoldChange > 2 & res$pval < 0.05)] <- 'UPREGULATED'
keyvals[which(res$log2FoldChange < (-2) & res$pval < 0.05)] <- 'forestgreen'
names(keyvals)[which(res$log2FoldChange < (-2) & res$pval < 0.05)] <- 'DOWNREGULATED'
unique(names(keyvals))
unique(keyvals)
keyvals[1:20]
png("TDB_C.png",width=4000, height=4000, res = 300)
EnhancedVolcano(res,lab = as.character(res$pid),x=('log2FoldChange') ,y='pval',ylim = c(0,10), xlim = c(-15,15) ,
                title='TDB vs C',pCutoff=0.05, selectLab = c('abcd'),cutoffLineType = 'blank',hline=0.05,vline=c(2,-2),pointSize=1.5,labSize=2.5,colCustom = keyvals,gridlines.major = TRUE,gridlines.minor = FALSE)
dev.off()

