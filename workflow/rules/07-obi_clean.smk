# Obiclean
rule obiclean_07:
  input: 
    config["resultsfolder"]+"{run}/{run}_R1R2_good_demultiplexed_filtAndTrim_derep.fasta"
  output:
    config["resultsfolder"]+"{run}/{run}_R1R2_good_demultiplexed_filtAndTrim_derep_cleaned.fasta"
  params:
    ratio=config["obiclean"]["ratio"]
  benchmark:
    "benchmarks/{run}/{run}_obiclean.txt" 
  conda:
    "../envs/obi_env.yaml"
  shell:
    """
    obiclean -r {params.ratio} -H {input} > {output}
    """
