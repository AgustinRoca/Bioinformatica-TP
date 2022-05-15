from Bio import SeqIO
from Bio.SeqRecord import SeqRecord

def probable_orf(proteins: dict):
    '''Returns the most probable ORF. This supposes the longest protein is the most probable one'''
    longest_protein = 0
    orf = 0
    for k, v in proteins.items():
        if len(v) > longest_protein:
            longest_protein = len(v)
            orf = k
    return orf

def get_longest_protein_by_orf(record: SeqRecord) -> dict:
    '''Returns a dict with keys +1, +2, +3, -1, -2, -3. And values the longest protein to that ORF'''
    proteins = {}
    for strand, nucleotids in [(+1, record.seq), (-1, record.seq.reverse_complement())]:
        for frame in range(1, 4):
            longest_protein = 0

            # frame = 1 -> no neuclotids skipped
            # frame = 2 -> first 2 neuclotids skipped
            # frame = 3 -> first neuclotid skipped
            record_to_translate = nucleotids[(-frame + 4) % 3:]
            
            # Make the sequence length a multiple of 3 (biopython shows warning if not)
            record_to_translate = record_to_translate[:3*(len(record_to_translate) // 3)] 

            for protein in record_to_translate.translate().split('*'): # Translate the sequence and split by Stop codons (*)
                protein = protein[protein.find('M'):] # Look for start of protein if exists (M = Start)
                if protein.startswith('M') and len(protein) > longest_protein: # Register only the longest protein in the ORF
                    orf = strand * frame
                    orf = f'+{orf}' if orf > 0 else f'{orf}'
                    proteins[orf] = protein
                    longest_protein = len(protein)
    return proteins

# TODO: Be able to change gb_file path and output by command line
if __name__ == '__main__':
    gb_file = 'sequences/NM_001385125.gb'
    output_path = 'sequences/results/protein.fasta'

    for gb_record in SeqIO.parse(open(gb_file,'r'), 'genbank') :
        proteins = get_longest_protein_by_orf(gb_record)
        for orf,protein in proteins.items():
            print(f"{orf}: {len(protein)*3/len(gb_record.seq) * 100}% of gen used for protein")
        selected_orf = probable_orf(proteins)
        selected_protein = proteins[selected_orf]
        record = SeqRecord(selected_protein, description=f'Protein translated from {gb_record.id} using ORF {selected_orf}.')
        SeqIO.write(record, output_path, 'fasta')
