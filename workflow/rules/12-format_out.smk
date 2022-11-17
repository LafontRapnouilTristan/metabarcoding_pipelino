# TAB FORMATTING
rule tab_format_12:
  input:
    config["resultsfolder"]+"{run}/{run}_R1R2_good_demultiplexed_filtAndTrim_derep_cleaned_abfilt_bimerafree_cl_agg.fasta"
  output:
    config["resultsfolder"]+"{run}/{run}_R1R2_good_demultiplexed_filtAndTrim_derep_cleaned_abfilt_bimerafree_cl_agg.tab"
  benchmark:
    "benchmarks/{run}/{run}_tabformat.txt"   
  log:
    "log/tab_format_"+files_prefix + ".log"
  conda:
    "../envs/obi_env.yaml"
  shell:
    """
	  obitab -n NA -d -o {input} > {output} 2> {log}
		"""
