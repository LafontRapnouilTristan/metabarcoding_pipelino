This pipeline starts from raw foward (R1) and reverse (R2) `.fastq` files and a `.tab` ngsfilter file.

This pipeline aims to respects the [FAIR](https://www.go-fair.org/fair-principles/) principles using [snakemake](https://snakemake.readthedocs.io/en/stable/#). 

# Description

Pipeline for raw NGS metabarcoding data processing using a combination of the OBItools, dada2 and sumaclust.

You'll find parameters used by the pipeline in the [config file](config/config.yaml).

DAG of the pipeline:

![DAG of the pipeline](dag/dag.png).

# Input

## Required

### Environment
In order to run this pipeline you need **snakemake**.

### Files

Raw illumina sequencing output for forward and reverse reads in `.fastq` format.
Forward file named *XXX_R1.fastq* and reverse *XXX_R2.fastq*.
Additionally, you will need a text file named *XXX_ngsfilter.tab* as required by the [ngsfilter](https://pythonhosted.org/OBITools/scripts/ngsfilter.html) function of the obitools.

## Tree

```bash
.
|-- README.Rmd
|-- README.md
|-- Snakefile
|-- benchmarks
|   |-- run1
|   |-- run2
|-- config
|   |-- config.yaml
|-- dag
|-- log
|   |-- run1
|   |-- run2
|-- metabarcoding_pipelino.Rproj
|-- report
|-- resources
|   |
|   |-- run1
|   |   |-- run1_ngsfilter.tab
|   |   |-- run1_R1.fastq
|   |   |-- run1_R2.fastq
|   |-- run2
|       |-- run2_ngsfilter.tab
|       |-- run2_R1.fastq
|       |-- run2_R2.fastq
|
| 
|-- results
|   |-- run1
|   |-- run2
|
|
|-- workflow
    |-- envs
    |   |-- R_env.yaml
    |   |-- obi_env.yaml
    |   |-- suma_env.yaml
    |-- rules
    |   |-- 01-pairing.smk
    |   |-- 02-sort_alignments.smk
    |   |-- 03-demultiplex.smk
    |   |-- 04-dada_prep.smk
    |   |-- 05-filterandtrim.smk
    |   |-- 06-derep.smk
    |   |-- 07-obi_clean.smk
    |   |-- 08-abbundance_filt.smk
    |   |-- 09-bimera_rm.smk
    |   |-- 10-otu_clust.smk
    |   |-- 11-merge_clust.smk
    |   |-- 12-format_out.smk
    |   |-- 12-seq_tracking.smk
    |   |-- 12-taxassign.smk
    |   |-- 13-benchmark.smk
    |-- scripts
        |-- benchmark.R
        |-- derep_dada2.R
        |-- filtandtrim_dada2.R
        |-- rm_bimera_dada2.R
        |-- seq_tracking.R
        |-- taxassign_dada2.R

```

# Pipeline steps and tools

## I - Pre-processing

### 1 - merging paired-end sequenced reads

a - split fasq for faster processing

**OBItools** - [*obidistribute*](https://pythonhosted.org/OBITools/scripts/obidistribute.html)

options : 
  `-n` : number of files to split in, `nfile` in [`config`](config/config.yaml). (between 2 and 1000).

b - align paired-end sequence

**OBItools** - [*illuminapairedend*](https://pythonhosted.org/OBItools/scripts/illuminapairedend.html)


### 2 - filtering alignments

**OBItools** - [*obiannotate*](https://pythonhosted.org/OBItools/scripts/obiannotate.html)

options :
  `-S` : expression used for annotation, ali:`good` if alignment score > `minscore` in [`config`](config/config.yaml).
  else `bad`.

**OBItools** - [*obisplit*](https://pythonhosted.org/OBItools/scripts/obisplit.html)

options :
  `-t` : split according to a condition, here `ali = good`

### 3 - demultiplexing and tag/primer trimming

**OBItools** - [*ngsfilter*](https://pythonhosted.org/OBItools/scripts/ngsfilter.html)

options :
  `-ngs` : ngs filter used for the demultiplexing in a `.tab` format.
  Check [input](##Required) for details about input format.
  

### 4 - sequence quality filtering and trimming

**dada2** - [*filterAndTrim*](https://rdrr.io/bioc/dada2/man/filterAndTrim.html)

options :
  `truncLen`: 200, length at which perform trimming.
  `maxN`: 0, maximum number of accepted `N` nucleotides. 
  `maxEE`: 2, maximum number of accepted errors.
  `truncQ`: 2, 
  `matchIDs`: TRUE
  `verbose`: TRUE
  `multithread`: 15

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
