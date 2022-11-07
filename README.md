This pipeline starts from raw foward (R1) and reverse (R2) `.fastq` files and a `.tab` ngsfilter file.

This pipeline respects the [FAIR](https://www.go-fair.org/fair-principles/) principle using [snakemake](https://snakemake.readthedocs.io/en/stable/#) and [singularity](https://docs.sylabs.io/guides/3.0/user-guide/index.html#) tools.



# Pipeline steps and tools

## I - Pre-processing

### 1 - merging paired-end sequenced reads

**OBItools** - [*illuminapairedend*](https://pythonhosted.org/OBItools/scripts/illuminapairedend.html)

options :

### 2 - filtering alignments

**OBItools** - [*obiannotate*](https://pythonhosted.org/OBItools/scripts/obiannotate.html)

options :

**OBItools** - [*obisplit*](https://pythonhosted.org/OBItools/scripts/obisplit.html)

options :

### 3 - demultiplexing and tag/primer trimming

**OBItools** - [*ngsfilter*](https://pythonhosted.org/OBItools/scripts/ngsfilter.html)

options :

### 4 - sequence quality filtering and trimming

**dada2** - [*filterAndTrim*](https://rdrr.io/bioc/dada2/man/filterAndTrim.html)

options :

### 5 - sequence dereplication

**dada2** - [*derepFastq*](https://rdrr.io/bioc/dada2/man/derepFastq.html)

options :

## II - Key processing 

### 1 - sequencing and error elimination 

**OBItools** - [*obiclean*](https://pythonhosted.org/OBItools/scripts/obiclean.html)

options :

### 2 - Abundance filtering

**OBItools** - [*obigrep*](https://pythonhosted.org/OBItools/scripts/obigrep.html)

options : 

## III - Post-processing

### 1 - Chimera removal

**dada2** - [*removeBimeraDenovo*](https://rdrr.io/bioc/dada2/man/removeBimeraDenovo.html)

options :

### 2 Sequence clustering

**sumaclust** - [*sumaclust*](https://git.metabarcoding.org/OBItools/sumaclust/-/wikis/home)

options :

### 3 Merging Clusters

**OBItools** - [*obiselect*](https://pythonhosted.org/OBItools/scripts/obiselect.html)

options :

### 4 Output Formating

**OBItools** - [*obitab*](https://pythonhosted.org/OBItools/scripts/obitab.html)

options :
