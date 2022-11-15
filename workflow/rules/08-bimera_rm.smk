# Bimera removal
rule bimera_rm_08:
  input:
    config["resultsfolder"]+"{run}/{run}_R1R2_good_demultiplexed_filtAndTrim_derep_cleaned.fasta"
  output:
    config["resultsfolder"]+"{run}/{run}_R1R2_good_demultiplexed_filtAndTrim_derep_cleaned_bimerafree.fasta"
  params:
    multithread=config["general"]["cores"]
  log:
    "log/{run}_rm_bimeara.log"
  conda:
    "../envs/R_env.yaml"
  script:
    "../scripts/rm_bimera_dada2.R"
