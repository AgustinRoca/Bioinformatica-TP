from Bio.pairwise2 import format_alignment 
from Bio import pairwise2

from Bio import SeqIO
import argparse
import os

parser = argparse.ArgumentParser(description='Ejercicio 3. Protein FASTA + FASTAs -> MultiSequence Alignment')
parser.add_argument('-i', metavar='FASTA_FILE', help='Input FASTA file (default = sequences/results/protein.fasta)', default='sequences/results/protein.fasta')
parser.add_argument('-d', metavar='FASTA_DIR', help='Input FASTA directory (default = sequences/fasta)', default='sequences/fasta')
parser.add_argument('-o', metavar='MSA_FILE', help='Output MultiSequence Alignment file (TXT) (default = sequences/results/msa_results.txt)', default='sequences/results/msa_results.txt')
args = parser.parse_args()

fasta_file = args.i
fasta_dir = args.d
output_path = args.o

original_seq = list(SeqIO.parse(open(fasta_file,'r'), 'fasta'))[0].seq
fasta_ext = ('.fasta', '.fna', '.ffn', '.faa', '.frn', '.fa')
with open(output_path, 'w') as save_file: 
    for filename in os.listdir(fasta_dir):
        if filename.endswith(fasta_ext): 
            sequence = list(SeqIO.parse(open(f'{fasta_dir}/{filename}','r'), 'fasta'))[0].seq
            alignment = pairwise2.align.globalxx(original_seq, sequence)
            save_file.write(format_alignment(*alignment[-1]))
            save_file.write('\n')
