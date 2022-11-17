# taxassign
rule taxassign_12:
  input:
    config["resultsfolder"]+"{run}/{run}_R1R2_good_demultiplexed_filtAndTrim_derep_cleaned_abfilt_bimerafree_cl_agg.fasta",
    config["taxassign"]["taxofolder"]
  output:
    config["resultsfolder"]+"{run}/{run}_taxassigned.csv"
  benchmark:
    "benchmarks/{run}/{run}_taxassing.txt" 
  log:
    "log/taxassign"+files_prefix + ".log"
  conda:
    "../envs/R_env.yaml"
  script:
    "../scripts/taxassign_dada2.R"
