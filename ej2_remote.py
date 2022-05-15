from Bio.Blast import NCBIWWW
from Bio import SeqIO

sequences = SeqIO.parse(open('sequences/results/protein.fasta','r'), 'fasta')
for i, record in enumerate(sequences):
    result_handle = NCBIWWW.qblast('blastp', 'swissprot', record.seq)
    with open(f'sequences/results/blast{i}.out', 'w') as save_file:
        blast_results = result_handle.read() 
        save_file.write(blast_results)