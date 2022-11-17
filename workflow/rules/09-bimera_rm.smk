# Bimera removal
rule bimera_rm_09:
  input:
    config["resultsfolder"]+"{run}/{run}_R1R2_good_demultiplexed_filtAndTrim_derep_cleaned_abfilt.fasta"
  output:
    config["resultsfolder"]+"{run}/{run}_R1R2_good_demultiplexed_filtAndTrim_derep_cleaned_abfilt_bimerafree.fasta"
  params:
    multithread=config["general"]["cores"]
	benchmark:
    "benchmarks/{run}/{run}_bimera.txt" 
  log:
    "log/{run}_rm_bimeara.log"
  conda:
    "../envs/R_env.yaml"
  script:
    "../scripts/rm_bimera_dada2.R"
