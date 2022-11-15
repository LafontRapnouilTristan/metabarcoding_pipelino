# SPLIT GOOD/BAD ALIGNMENTS
rule alifilt_03:
	input:
		config["resultsfolder"]+"{run}/{run}_R1R2.fastq"
	output:
		good=config["resultsfolder"]+"{run}/{run}_R1R2_good.fastq",
		bad=config["resultsfolder"]+"{run}/{run}_R1R2_bad.fastq"
	params:
		minscore=config["alifilt"]["minscore"],
		prefix=config["resultsfolder"]+"{run}/{run}_R1R2_"
	log:
		"log/split_ali_{run}.log"
	conda:
		"../envs/obi_env.yaml"
	shell:
		"""
		obiannotate -S ali:'"good" if score>{params.minscore} else "bad"' {input} | obisplit -t ali -p {params.prefix} 2> {log}
		"""
