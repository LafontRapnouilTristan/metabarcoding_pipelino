# Benchmark plotting
log <- file(snakemake@log[[1]], open="wt")
sink(log)
sink(log, type="message")

library(ggplot2)
library(ggpubr)

bench_files <- list.files(path = snakemake@input[[1]],full.names = T)
a <- list.files("benchmarks/1/",full.names = T)
bench_files <- a
bench <- do.call(rbind, lapply(bench_files, read.table, sep="\t",header=T))
bench$steps <- gsub(basename(bench_files),pattern=".txt",replacement = "")


plot_list <- list()
for (i in 1:(ncol(bench)-1)){
  plot_list[[i]] <- ggplot(bench,aes(y=bench[,i], x=steps)) +
                    ylab(names(bench)[i])+
                    geom_boxplot()
}

plot_bench <- ggarrange(plotlist = plot_list,ncol = 3,nrow=ceiling(i/3))
ggsave(plot_bench,filename = snakemake@output[[1]], device = "PNG")

