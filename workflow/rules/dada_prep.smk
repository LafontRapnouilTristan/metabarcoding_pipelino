# DADA2 prep
checkpoint dada_prep_03:
	input:
		config["resultsfolder"]+"{run}/{run}_R1R2_good_demultiplexed.fastq"
	output:
	    directory(config["resultsfolder"]+"{run}/dada2_splitted_fastq")
	log:
		"log/osplit_{run}.log"
	conda:
		"../envs/obi_env.yaml"
	shell:
		"""
		mkdir {output}
		obisplit {input} -t sample -p {output}/
		"""