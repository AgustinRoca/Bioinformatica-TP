from Bio.pairwise2 import format_alignment 
from Bio import pairwise2

from Bio import SeqIO
import argparse
import os

parser = argparse.ArgumentParser(description='Ejercicio 3. Protein FASTA + FASTAs -> MultiSequence Alignment')
parser.add_argument('-i', metavar='FASTA_FILE', help='Input FASTA file (default = sequences/msa_input.fasta)', default='sequences/msa_input.fasta')
parser.add_argument('-o', metavar='MSA_FILE', help='Output MultiSequence Alignment file (TXT) (default = sequences/results/msa_results.txt)', default='sequences/results/msa_results.txt')
args = parser.parse_args()

fasta_file = args.i
output_path = args.o

sequences = list(SeqIO.parse(open(fasta_file,'r'), 'fasta'))
original_seq = sequences[0].seq
with open(output_path, 'w') as save_file: 
    for i in range(1,len(sequences)):
        sequence = sequences[i].seq
        alignment = pairwise2.align.globalxx(original_seq, sequence)
        save_file.write(format_alignment(*alignment[-1]))
        save_file.write('\n')
