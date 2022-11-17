# MERGE CLUSTERS
rule merge_clust_11:
  input:
    config["resultsfolder"]+"{run}/{run}_R1R2_good_demultiplexed_filtAndTrim_derep_cleaned_abfilt_bimerafree_cl.fasta"
  output:
    config["resultsfolder"]+"{run}/{run}_R1R2_good_demultiplexed_filtAndTrim_derep_cleaned_abfilt_bimerafree_cl_agg.fasta"
  benchmark:
    "benchmarks/{run}/{run}_merge_clust.txt" 
  log:
    "log/merge_clust_"+files_prefix + ".log"
  conda:
    "../envs/obi_env.yaml"
  shell:
    """
		obiselect -c cluster -n 1 --merge sample -M -f count {input} > {output} 2> {log}
		"""
