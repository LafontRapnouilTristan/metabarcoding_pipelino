# DADA2 prep
checkpoint dada_prep_04:
	input:
		config["resultsfolder"]+"{run}/{run}_R1R2_good_demultiplexed.fastq"
	output:
	    directory(config["resultsfolder"]+"{run}/dada2_splitted_fastq")
	benchmark:
	    "benchmarks/{run}/dada_prep.txt"    
	log:
		"log/{run}/osplit.log"
	conda:
		"../envs/obi_env.yaml"
	shell:
		"""
		mkdir {output}
		obisplit {input} -t sample -p {output}/
		"""
