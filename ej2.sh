#!/bin/bash

Help()
{
   # Display Help
   echo "FASTA -> BLAST."
   echo
   echo "Syntax: ej2.sh [-h] [-i FASTA_FILE] [-o OUTPUT_BLAST_FILE] [-r]"
   echo "options:"
   echo "h                      Print this Help."
   echo "i FASTA_FILE           Input FASTA file (default = sequences/results/protein.fasta)"
   echo "o OUTPUT_BLAST_FILE    Output BLAST XML file (default = sequences/results/blast.out)"
   echo "r                      Remote run. If not present, run locally"
}

input="sequences/results/protein.fasta"
output="sequences/results/blast.out"
remote=false
while getopts ":hi:o::r" flag
do
    case "${flag}" in
        h) # display Help
            Help
            exit;;
        i) input=${OPTARG};;
        o) output=${OPTARG};;
        r) remote=true;;
        
    esac
done

if $remote
then
    echo "Running remote BLAST"
    ./blast/bin/blastp -db swissprot -query $input -out $output -outfmt 5 -remote
else
    cd blast/data
    echo "Checking updates on swissprot..."
    ../bin/update_blastdb.pl --passive --decompress swissprot
    cd ../..
    echo "Running local BLAST..."
    ./blast/bin/blastp -db blast/data/swissprot -query $input -out $output -outfmt 5
    echo "Done"
fi