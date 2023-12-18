#load required libraries
library(GenomicRanges)
library(GenomicFeatures)
library(rtracklayer)

#filepath as positional argument
args <- commandArgs(trailingOnly=TRUE)

#excecute work and write to file
data <- makeTxDbFromGFF(file=args[1])
exon <- exonsBy(data,use.names=T)
export.bed(exon,con="exon_gencode.bed")
