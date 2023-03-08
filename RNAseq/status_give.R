library(dplyr)

status_cha <- function(x){
  tag <- ""
  if(x>2){
    tag <- "up-regulated"
  }else if(x<(-2)){
    tag <- "down-regulated"
  }else{tag <- "baseline"}
  return(tag)
}


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
