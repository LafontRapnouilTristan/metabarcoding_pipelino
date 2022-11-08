# filter and trim
log <- file(snakemake@log[[1]], open="wt")
sink(log)
sink(log, type="message")

library(dada2)
filterAndTrim(snakemake@input[[1]],
              snakemake@output[[1]],
              truncLen=snakemake@params[[1]],
              maxN=snakemake@params[[2]],
              maxEE=snakemake@params[[3]],
              truncQ=snakemake@params[[4]],
              matchIDs=snakemake@params[[5]],
              verbose=snakemake@params[[6]],
              multithread=snakemake@params[[7]])