PYTHON = python3
GEN_GB_FILE = sequences/genbank/NM_001385125.gb
PROTEIN_FASTA_FILE = sequences/results/protein.fasta
BLAST_FILE = sequences/results/blast.out
FILTERED_BLAST_FILE = sequences/results/blast_filter.xml
MSA_INPUT_FILE = sequences/fasta/msa_input.fasta
MSA_OUTPUT_FILE = sequences/results/msa_results.txt
EJ4_FASTA_DIR = sequences/results/ej4_fastas
PATTERN = "mus musculus"
MOTIFS_FILE = sequences/results/motifs.patmatmotifs
EMBOSS_FASTA_FILE = sequences/results/emboss.fasta

all:
ifeq (remote, $(filter remote,$(MAKECMDGOALS)))
	$(eval REMOTE := true)
else
	$(eval REMOTE := false)
endif

ifeq (no_update, $(filter no_update,$(MAKECMDGOALS)))
	$(eval NO_UPDATE := true)
else
	$(eval NO_UPDATE := false)
endif

	@if [ ${NO_UPDATE} == true ] ; then \
		if [ ${REMOTE} == true ] ; then \
			make all_remote_no_update; \
		else \
			make all_no_update; \
		fi \
	else \
		if [ ${REMOTE} == true ]; \
		then \
			make all_remote; \
		else \
			make all_local; \
		fi \
	fi

%:
	@:

all_local: ej1 ej2 ej3 ej4 ej5

all_no_update: ej1 ej2_local_no_update ej3 ej4 ej5_no_update

all_remote: ej1 ej2_remote ej3 ej4 ej5

all_remote_no_update: ej1 ej2_remote ej3 ej4 ej5_no_update

ej1: src/ej1.py $(GEN_GB_FILE)
	@echo "Running ej1"
	@$(PYTHON) src/ej1.py -i $(GEN_GB_FILE) -o $(PROTEIN_FASTA_FILE)

ej2: src/ej2.sh $(PROTEIN_FASTA_FILE)
	@echo "Running ej2 local"
	@./src/ej2.sh -i $(PROTEIN_FASTA_FILE) -o $(BLAST_FILE)

ej2_remote: src/ej2.sh $(PROTEIN_FASTA_FILE)
	@echo "Running ej2 remote"
	@./src/ej2.sh -i $(PROTEIN_FASTA_FILE) -o $(BLAST_FILE) -r

ej2_local_no_update: src/ej2.sh $(PROTEIN_FASTA_FILE)
	@echo "Running ej2 no update"
	@./src/ej2.sh -i $(PROTEIN_FASTA_FILE) -o $(BLAST_FILE) -s

ej3: src/ej3.py $(PROTEIN_FASTA_FILE)
	@echo "Running ej3"
	@$(PYTHON) src/ej3.py -i $(MSA_INPUT_FILE) -o $(MSA_OUTPUT_FILE)

ej4: src/ej4.py $(BLAST_FILE)
	@echo "Running ej4"
	@$(PYTHON) src/ej4.py -i $(BLAST_FILE) -ob $(FILTERED_BLAST_FILE) -od $(EJ4_FASTA_DIR) -p $(PATTERN)

ej5: src/ej5.sh src/ej5a.sh $(PROTEIN_FASTA_FILE)
	@echo "Running ej5"
	@./src/ej5.sh -i $(PROTEIN_FASTA_FILE) -o $(MOTIFS_FILE)
	@./src/ej5a.sh i $(GEN_GB_FILE) -o $(EMBOSS_FASTA_FILE)

ej5_no_update: src/ej5.sh src/ej5a.sh $(PROTEIN_FASTA_FILE)
	@echo "Running ej5 no update"
	@./src/ej5.sh -i $(PROTEIN_FASTA_FILE) -o $(MOTIFS_FILE) -s
	@./src/ej5a.sh -i $(GEN_GB_FILE) -o $(EMBOSS_FASTA_FILE)

clean: clean_results clean_swissprot clean_prosite

clean_results: 
	@echo "Cleaning results"
	@rm -rd sequences/results/*

clean_swissprot:
	@echo "Cleaning Swissprot"
	@rm -rd blast/data/*

clean_prosite:
	@echo "Cleaning PROSITE"
	@rm -r prosite
