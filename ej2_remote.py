from Bio.Blast import NCBIWWW
import argparse

parser = argparse.ArgumentParser(description='Ejercicio 2. Protein FASTA -> BLAST')
parser.add_argument('-i', metavar='FASTA_FILE', help='Input FASTA file (default = sequences/results/protein.fasta)', default='sequences/results/protein.fasta')
parser.add_argument('-o', metavar='BLAST_FILE', help='Output BLAST file (XML) (default = sequences/results/protein.fasta)', default='sequences/results/blast.out')
args = parser.parse_args()

fasta_file = args.i
output_path = args.o

sequences = open(fasta_file,'r')
result_handle = NCBIWWW.qblast('blastp', 'swissprot', sequences)
with open(output_path, 'w') as save_file:
    blast_results = result_handle.read() 
    save_file.write(blast_results)