# abundance filt
rule abbun_filt_08:
  input: 
    config["resultsfolder"]+"{run}/{run}_R1R2_good_demultiplexed_filtAndTrim_derep_cleaned.fasta"
  output:
    config["resultsfolder"]+"{run}/{run}_R1R2_good_demultiplexed_filtAndTrim_derep_cleaned_abfilt.fasta"
  params:
    mincount=config["abb_filt"]["mincount"]
	benchmark:
    "benchmarks/{run}/{run}_abbfilt.txt" 
  log:
    "log/{run}_abb_filt.log"
  conda:
    "../envs/obi_env.yaml"
  shell:
    """
    obigrep -s '^[acgt]+$' -p 'count>{params.mincount}' {input} > {output} 2> {log}
    """
