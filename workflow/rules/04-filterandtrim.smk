# Filter and trim
rule filt_and_trim_04:
  input:
    config["resultsfolder"]+"{run}/{run}_R1R2_good_demultiplexed.fasta"
  output:
    config["resultsfolder"]+"{run}/{run}_R1R2_good_demultiplexed_filtAndTrim.fasta"
  conda:
    "../envs/R_env.yaml"
  script:
    "../scripts/filtandtrim_dada2.R"
