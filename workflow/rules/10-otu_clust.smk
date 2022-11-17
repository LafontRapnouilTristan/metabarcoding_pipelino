# CLUSTERING
rule otu_clust_10:
  input:
    config["resultsfolder"]+"{run}/{run}_R1R2_good_demultiplexed_filtAndTrim_derep_cleaned_abfilt_bimerafree.fasta"
  output:
    config["resultsfolder"]+"{run}/{run}_R1R2_good_demultiplexed_filtAndTrim_derep_cleaned_abfilt_bimerafree_cl.fasta"
  params:
    minsim = config["clustering"]["minsim"],
    threads = config["general"]["cores"]
  benchmark:
    "benchmarks/{run}/clust.txt" 
  log:
    "log/{run}/clustering.log"
  conda:
    "../envs/suma_env.yaml"
  shell:
    """
		sumaclust -t {params.minsim} -p {params.threads} {input} > {output}
		"""
