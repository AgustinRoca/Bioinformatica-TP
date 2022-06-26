PYTHON = python3
GEN_GB_FILE = sequences/genbank/NM_001385125.gb
PROTEIN_FASTA_FILE = sequences/results/protein.fasta
BLAST_FILE = sequences/results/blast.out
FILTERED_BLAST_FILE = sequences/results/blast_filter.xml
MSA_FILE = sequences/results/msa_results.txt
EJ4_FASTA_DIR = sequences/results/ej4_fastas
PATTERN = "mus musculus"
MOTIFS_FILE = sequences/results/motifs.patmatmotifs
EMBOSS_FASTA_FILE = sequences/results/emboss.fasta

all: ej1 ej2 ej3 ej4 ej5

all_no_update: ej1 ej2_local_no_update ej3 ej4 ej5_no_update

all_remote: ej1 ej2_remote ej3 ej4 ej5

all_remote_no_update: ej1 ej2_remote ej3 ej4 ej5_no_update

ej1: ej1.py $(GEN_GB_FILE)
	$(PYTHON) ej1.py -i $(GEN_GB_FILE) -o $(PROTEIN_FASTA_FILE)

ej2: ej2.sh $(PROTEIN_FASTA_FILE)
	./ej2.sh -i $(PROTEIN_FASTA_FILE) -o $(BLAST_FILE)

ej2_remote: ej2.sh $(PROTEIN_FASTA_FILE)
	./ej2.sh -i $(PROTEIN_FASTA_FILE) -o $(BLAST_FILE) -r

ej2_local_no_update: ej2.sh $(PROTEIN_FASTA_FILE)
	./ej2.sh -i $(PROTEIN_FASTA_FILE) -o $(BLAST_FILE) -s

ej3: ej3.py $(PROTEIN_FASTA_FILE)
	$(PYTHON) ej3.py -i $(PROTEIN_FASTA_FILE) -o $(MSA_FILE)

ej4: ej4.py $(BLAST_FILE)
	$(PYTHON) ej4.py -i $(BLAST_FILE) -ob $(FILTERED_BLAST_FILE) -od $(EJ4_FASTA_DIR) -p $(PATTERN)

ej5: ej5.sh ej5a.sh $(PROTEIN_FASTA_FILE)
	./ej5.sh -i $(PROTEIN_FASTA_FILE) -o $(MOTIFS_FILE)
	./ej5a.sh i $(GEN_GB_FILE) -o $(EMBOSS_FASTA_FILE)

ej5_no_update: ej5.sh ej5a.sh $(PROTEIN_FASTA_FILE) 
	./ej5.sh -i $(PROTEIN_FASTA_FILE) -o $(MOTIFS_FILE) -s
	./ej5a.sh -i $(GEN_GB_FILE) -o $(EMBOSS_FASTA_FILE)

clean: clean_results clean_swissprot clean_prosite

clean_results: 
	rm -rd sequences/results/*

clean_swissprot:
	rm -rd blast/data/*

clean_prosite:
	rm -r prosite


	