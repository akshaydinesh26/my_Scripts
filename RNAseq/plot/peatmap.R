library(pheatmap)
library(RColorBrewer)

#sample to sample heatmap and clustering
vld <- read.delim(file="log_expression.tsv",header=T)
sampleDists <- dist(t(assay(vld)))
sampleDistMatrix <- as.matrix(sampleDists)
rownames(sampleDistMatrix) <- paste(vld$id)
colnames(sampleDistMatrix) <- NULL
colors <- colorRampPalette( rev(brewer.pal(9, "Blues")) )(255)
pheatmap(sampleDistMatrix,
         clustering_distance_rows=sampleDists,
         clustering_distance_cols=sampleDists,
         col=colors)
