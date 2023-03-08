#!/usr/bin/R

#assign status to genes based on pvalue and log2FoldChange
#pvalue > 0.05 - non-significant
#pvalue < 0.05 & log2FoldChange > 2 - upregulated
#pvalue < 0.05 & log2FoldChange < -2 - downregulated
#pvalue < 0.05 & -2 < log2FoldChange < 2 - baseline

#load library
library(dplyr)

#function to assign status to a gene based on log2FoldChange
status_cha <- function(x){
  tag <- ""
  if(x>2){
    tag <- "up-regulated"
  }else if(x<(-2)){
    tag <- "down-regulated"
  }else{tag <- "baseline"}
  return(tag)
}

#function assign status for all genes in a dataframe of Deseq2 results
change <- function(data){
  data1 <- data %>% filter(pvalue=="NA" | pvalue > 0.05)
  data2 <- data %>% filter(pvalue < 0.05)
  data1 <- data1 %>% mutate(status="non-significant")
  data2 <- data2 %>% mutate(status=sapply(log2FoldChange,status_cha))
  vec2 <- data$log2Foldchange
  vec3 <- sapply(vec2, status)
  data2 <- data.frame(data2,vec3)
  final <- cbind(data1,data2)
  return(final)
}
