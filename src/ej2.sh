#!/bin/bash

Help()
{
   # Display Help
   echo "usage: src/ej2.sh [-h] [-i FASTA_FILE] [-o OUTPUT_BLAST_FILE] [-r] [-s]"
   echo
   echo "Ejercicio 2. FASTA -> BLAST."
   echo
   echo "optional arguments:"
   echo " -h                      show this help message and exit"
   echo " -i FASTA_FILE           Input FASTA file (default = sequences/results/protein.fasta)"
   echo " -o OUTPUT_BLAST_FILE    Output BLAST XML file (default = sequences/results/blast.out)"
   echo " -r                      Remote run. If not present, run locally"
   echo " -s                      Skip update (only relevant in local run). If not present, will check for updates of swissprot in NCBI"
}

input="sequences/results/protein.fasta"
output="sequences/results/blast.out"
remote=false
update=true
while getopts ":h :s :r i: o:" flag
do
    case "${flag}" in
        h)
            Help
            exit;;
        i) input=${OPTARG};;
        o) output=${OPTARG};;
        r) remote=true;;
        s) update=false;;
        
    esac
done

if $remote
then
    echo "Running remote BLAST"
    ./blast/bin/blastp -db swissprot -query $input -out $output -outfmt 5 -remote
else
    if $update
    then
        cd blast/data
        echo "Checking updates on swissprot..."
        ../bin/update_blastdb.pl --passive --decompress swissprot
        cd ../..
    fi
    echo "Running local BLAST..."
    ./blast/bin/blastp -db blast/data/swissprot -query $input -out $output -outfmt 5
    echo "Done"
fi