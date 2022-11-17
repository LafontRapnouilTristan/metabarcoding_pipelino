# Filter and trim
rule filt_and_trim_04:
  input:
    config["resultsfolder"]+"{run}/dada2_splitted_fastq"
  output:
    directory(config["resultsfolder"]+"{run}/dada2_trimmed_fastq")
  params:
    truncLen=config["filterandtrim"]["truncLen"],
    maxN=config["filterandtrim"]["maxN"],
    maxEE=config["filterandtrim"]["maxEE"],
    truncQ=config["filterandtrim"]["truncQ"],
    matchIDs=config["filterandtrim"]["matchIDs"],
    verbose=config["filterandtrim"]["verbose"],
    multithread=config["filterandtrim"]["multithread"]
	benchmark:
    "benchmarks/{run}/{run}_filt_and_trim.txt"    
  log:
    "log/{run}_filt_and_trim.log"
  conda:
    "../envs/R_env.yaml"
  script:
    "../scripts/filtandtrim_dada2.R"
