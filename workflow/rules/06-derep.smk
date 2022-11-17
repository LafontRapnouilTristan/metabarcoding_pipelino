# dereplication
rule derep_05:
  input:
    config["resultsfolder"]+"{run}/dada2_trimmed_fastq"
  output:
    config["resultsfolder"]+"{run}/{run}_R1R2_good_demultiplexed_filtAndTrim_derep.fasta"
  params:
    simult_reads=config["dereplication"]["simult_reads"]
  benchmark:
    "benchmarks/{run}/derep.txt" 
  log:
    "log/{run}/derep.log"
  conda:
    "../envs/R_env.yaml"
  script:
    "../scripts/derep_dada2.R"
