# dereplication
library(dada2)
derepFastq(snakemake@input[[1]],
           n=snakemake@params[[1]],
           verbose=TRUE)