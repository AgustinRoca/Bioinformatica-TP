import xml.etree.ElementTree as ET
import sys
import os
import argparse
from Bio import Entrez

Entrez.email = 'A.N.Other@example.com'

parser = argparse.ArgumentParser(description='Ejercicio 4. BLAST + Pattern -> FASTAs')
parser.add_argument('-i', metavar='FASTA_FILE', help='Input BLAST XML file (default = sequences/results/blast.out)', default='sequences/results/blast.out')
parser.add_argument('-p', metavar='PATTERN', help='PATTERN', required=True)
parser.add_argument('-ob', metavar='OUTPUT_BLAST_FILE', help='Output Filtered BLAST File (XML) (default = sequences/results/blast_filter.xml)', default='sequences/results/blast_filter.xml')
parser.add_argument('-od', metavar='OUTPUT_FASTA_DIRECTORY', help='Output FASTAs Directory (default = sequences/results/ej4_fastas)', default='sequences/results/ej4_fastas')
args = parser.parse_args()

blast_file = args.i
pattern = args.p
output_blast = args.od
output_dir = args.ob

xml_tree = ET.parse(blast_file)
xml_root = xml_tree.getroot()
proteins = list(xml_root.find('BlastOutput_iterations').iter('Iteration'))
filter_str = pattern.lower()
data = []
ids = []
for protein in proteins:
    hits = list(protein.find('Iteration_hits').iter('Hit'))
    for hit in hits:
        hit_description = hit.find('Hit_def').text
        if filter_str in hit_description.lower():
            data.append(hit)
            ids.append(hit_description.split(' ')[0])


with open(output_blast, 'w') as save_file: 
    save_file.write('<Hits>\n')
    for hit in data:
        xml = ET.tostring(hit, encoding='unicode')
        save_file.write(xml)
        save_file.write('\n')
    save_file.write('</Hits>\n')

if not os.path.exists(output_dir):
    os.mkdir(output_dir)

for i,hit_id in enumerate(ids):
    with open(f"{output_dir}/protein_{i}.fasta", 'w') as save_file: 
        handle = Entrez.efetch(db="protein", id=hit_id, rettype="fasta", retmode="text")
        save_file.write(handle.read())