# rm bimera
library(dada2)
removeBimeraDenovo(snakemake@input[[1]],
                   multithread=snakemake@params[[1]],
                   verbose=TRUE)