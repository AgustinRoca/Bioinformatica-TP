from Bio.pairwise2 import format_alignment 
from Bio import pairwise2

from Bio import SeqIO

original_seq = list(SeqIO.parse(open('sequences/results/protein.fasta','r'), 'fasta'))[0].seq
saimiri_seq = list(SeqIO.parse(open('sequences/saimiri.fasta','r'), 'fasta'))[0].seq
rattus_seq = list(SeqIO.parse(open('sequences/rattus.fasta','r'), 'fasta'))[0].seq
bos_taurus_seq = list(SeqIO.parse(open('sequences/bos_taurus.fasta','r'), 'fasta'))[0].seq

saimiri_alignments = pairwise2.align.globalxx(original_seq, saimiri_seq) 
rattus_alignments = pairwise2.align.globalxx(original_seq, rattus_seq) 
bos_taurus_alignments = pairwise2.align.globalxx(original_seq, bos_taurus_seq) 

with open(f'sequences/results/msa_results.txt', 'w') as save_file: 
    save_file.write(format_alignment(*saimiri_alignments[-1]))
    save_file.write('\n')
    save_file.write(format_alignment(*rattus_alignments[-1]))
    save_file.write('\n')
    save_file.write(format_alignment(*bos_taurus_alignments[-1]))
    save_file.write('\n')

