#BiocManager::install('methylKit')
library(methylKit)

file.list=list(file.path("~/Desktop/analysis/CEC2_1_bismark_bt2_pe.deduplicated.bismark.cov"),
               file.path("~/Desktop/analysis/CEC-3_1_bismark_bt2_pe.deduplicated.bismark.cov"),
               file.path("~/Desktop/analysis/CEC-8_1_bismark_bt2_pe.deduplicated.bismark.cov"),
               file.path("~/Desktop/analysis/CEC-9_1_bismark_bt2_pe.deduplicated.bismark.cov"))

# read the files to a methylRawList object: myobj
myobj=methRead(file.list,
               sample.id=list("CEC2","CEC3","CEC8","CEC9"),
               assembly="hg18",
               treatment=c(0,0,1,1),
               context="CpG",
               mincov = 8,
               pipeline='bismarkCoverage'
)

#met summary of meth stats
getMethylationStats(myobj[[4]],plot=FALSE,both.strands=FALSE)
getMethylationStats(myobj[[1]],plot=TRUE,both.strands=FALSE)
#coverage stat
getCoverageStats(myobj[[2]],plot=TRUE,both.strands=FALSE)

#filter
#filtered.myobj=filterByCoverage(myobj,lo.count=8,lo.perc=NULL,
#                                hi.count=NULL,hi.perc=99.9)

#merge samples to obtain sites coverded in all
meth=unite(myobj, destrand=FALSE)
rm(file.list)
rm(myobj)
#correlation
getCorrelation(meth,plot=TRUE)

#cluster based on correlation
clusterSamples(meth, dist="correlation", method="ward", plot=TRUE)

#pca
?PCASamples()
PCASamples(meth)
PCASamples(meth, screeplot=TRUE)
