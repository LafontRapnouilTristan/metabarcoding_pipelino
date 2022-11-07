# DEMULTIPLEXING
rule demultiplex:
	input:
		config["resultsfolder"]+"{run}/{run}_R1R2_good.fastq"
	output:
		demultiplexed=config["resultsfolder"]+"{run}/{run}_R1R2_good_demultiplexed.fasta",
		unassigned=config["resultsfolder"]+"{run}/{run}_R1R2_good_unassigned.fasta"
	params:
		ngs=config["resourcesfolder"]+"{run}/{run}_ngsfilter.tab"
	log:
		"../log/demultiplex_{run}.log"
	conda:
		"envs/obi_env.yaml"
	shell:
		"""
		obiannotate --without-progress-bar --sanger -S 'Avgqphred:-int(math.log10(sum(sequence.quality)/len(sequence))*10)' {input} | ngsfilter --fasta-output -t {params.ngs} -u {output.unassigned} > {output.demultiplexed} 2> {log}
		"""


if config["tomerge"]:
	# MERGE LIBRARIES
	rule merge_demultiplex:
		input:
			expand(config["resultsfolder"]+"{run}/{run}_R1R2_good_demultiplexed.fasta", run=config["fastqfiles"])
		output:
			config["resultsfolder"]+config["mergedfile"]+"/"+config["mergedfile"]+"_R1R2_good_demultiplexed.fasta"
		log:
			"../log/merge_demultiplex_"+config["mergedfile"]+".log"
		shell:
			"""
			cat {input} > {output} 2> {log}
			"""


if config["tomerge"]:
	folder_prefix=config["resultsfolder"]+config["mergedfile"]+"/"
	folder_prefix2=folder_prefix
	files_prefix=config["mergedfile"]
else:
	folder_prefix=config["resultsfolder"]+"{run}/"
	folder_prefix2=config["resultsfolder"]+"{{run}}/"
	files_prefix="{run}"