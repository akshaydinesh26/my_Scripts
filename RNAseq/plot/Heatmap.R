library("gplots")
library(dplyr)
#Normal one..




data<-read.csv("TDA_C.csv", header = F, row.names =1,col.names=c("protein_name","C1","C2","C3",
                                                                 "TDA1","TDA2","TDA3","TDB1",
                                                                 "TDB2","TDB3","TSA1","TSA2",
                                                                 "TSA3","TSB1","TSB2","TSB3"))
data <- data[,-c(1)] %>% 
head(data)
data<-data.matrix(data)

png("heatmap_3.png",  width=3500, height=3000 , res =300)
heatmap.2(data,col=greenred(75),scale="column",key=TRUE,symkey=FALSE,margins=c(5,12),trace="none",cexCol=1.2,cexRow=0.7)
#heatmap.2(data,col=greenred(75), key=TRUE,dendrogram='none' ,labRow = FALSE ,symkey=FALSE,margins=c(6,15),trace="none",cexCol = 1.3 , cexRow=0.5)
dev.off ()



#ALT...
heatmap.2(data, col = rev(brewer.pal(11, "RdYlBu")), scale = "column", key = TRUE, symkey = FALSE, margins = c(5,12), trace = "none", cexCol = 1.2, cexRow = 0.7)
