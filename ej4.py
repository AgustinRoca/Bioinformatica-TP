import xml.etree.ElementTree as ET
import sys
import os
from Bio import Entrez

Entrez.email = 'A.N.Other@example.com'


xml_tree = ET.parse(sys.argv[1])
xml_root = xml_tree.getroot()
proteins = list(xml_root.find('BlastOutput_iterations').iter('Iteration'))
filter_str = sys.argv[4].lower()
data = []
ids = []
for protein in proteins:
    hits = list(protein.find('Iteration_hits').iter('Hit'))
    for hit in hits:
        hit_description = hit.find('Hit_def').text
        if filter_str in hit_description.lower():
            data.append(hit)
            ids.append(hit_description.split(' ')[0])


with open(sys.argv[2], 'w') as save_file: 
    save_file.write('<Hits>\n')
    for hit in data:
        xml = ET.tostring(hit, encoding='unicode')
        save_file.write(xml)
        save_file.write('\n')
    save_file.write('</Hits>\n')

if not os.path.exists(sys.argv[3]):
    os.mkdir(sys.argv[3])

for i,hit_id in enumerate(ids):
    with open(f"{sys.argv[3]}/protein_{i}.fasta", 'w') as save_file: 
        handle = Entrez.efetch(db="protein", id=hit_id, rettype="fasta", retmode="text")
        save_file.write(handle.read())