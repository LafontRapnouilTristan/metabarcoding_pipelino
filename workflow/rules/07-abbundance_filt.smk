# abundance filt
rule abbun_filt_07:
  input: 
    config["resultsfolder"]+"{run}/{run}_R1R2_good_demultiplexed_filtAndTrim_derep_cleaned.fasta"
  output:
    config["resultsfolder"]+"{run}/{run}_R1R2_good_demultiplexed_filtAndTrim_derep_cleaned_abfilt.fasta"
  params:
    mincount=config["abb_filt"]["mincount"]
  conda:
    "../envs/obi_env.yaml"
  shell:
    """
    obiannotate --length -S 'GC_content:len(str(sequence).replace("a","").replace("t",""))*100/len(sequence)' {input} | obigrep -s '^[acgt]+$' -p 'count>{params.mincount}' > {output} 2> {log}
    """