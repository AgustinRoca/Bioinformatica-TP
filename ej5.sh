wget https://ftp.expasy.org/databases/prosite/prosite.dat
wget https://ftp.expasy.org/databases/prosite/prosite.doc
mkdir prosite
mv prosite.dat prosite
mv prosite.doc prosite
prosextract prosite
patmatmotifs -sequence sequences/results/protein.fasta -outfile sequences/results/motifs.patmatmotifs