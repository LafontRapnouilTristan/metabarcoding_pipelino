# rm bimera
log <- file(snakemake@log[[1]], open="wt")
sink(log)
sink(log, type="message")

library(dada2) #1.24.0
library(ShortRead) #1.54.0

tab <- ShortRead::readFasta(snakemake@input[[1]])
seqtab_1 <- makeSequenceTable(tab)
seqtab_2 <- removeBimeraDenovo(seqtab_1, 
                               verbose=T,
                               multithread=snakemake@params[[1]])
# processes the bimera removal

uniqueSeqs <- getUniques(seqtab_2)
uniquesToFasta(uniqueSeqs,
               paste0(sample.names, ".fasta"))
               # creates the new file without bimeras
               
