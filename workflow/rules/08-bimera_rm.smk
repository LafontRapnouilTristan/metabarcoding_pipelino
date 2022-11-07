# Bimera removal
rule bimera_rm_08:
  input:
    config["resultsfolder"]+"{run}/{run}_R1R2_good_demultiplexed_filtAndTrim_derep_cleaned_abfilt.fasta"
  output:
    config["resultsfolder"]+"{run}/{run}_R1R2_good_demultiplexed_filtAndTrim_derep_cleaned_abfilt_bimerafree.fasta"
  params:
    multithread=config["general"]["cores"]
  singularity:
    "../envs/test.sif"
  script:
    "../scripts/rm_bimera_dada2.R"