#!/bin/bash

wget ftp://ftp.ncbi.nlm.nih.gov/blast/db/FASTA/swissprot.gz
gzip -d swissprot.gz
../bin/makeblastdb -in swissprot -dbtype prot