# dereplication
log <- file(snakemake@log[[1]], open="wt")
sink(log)
sink(log, type="message")

library(dada2)
derepFastq(snakemake@input[[1]],
           n=snakemake@params[[1]],
           verbose=TRUE)