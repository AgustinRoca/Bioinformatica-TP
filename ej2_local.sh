#!/bin/bash

./blast/bin/blastp -db blast/data/swissprot -query sequences/results/protein.fasta -out sequences/results/blast.out -outfmt 5