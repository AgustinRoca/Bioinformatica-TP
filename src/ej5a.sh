#!/bin/bash

Help()
{
   # Display Help
   echo "usage: src/ej5a.sh [-h] [-i GENBANK_FILE] [-o OUTPUT_FASTA_FILE]"
   echo
   echo "Ejercicio 5a. Nucleotide GenBank -> Protein FASTA."
   echo
   echo "optional arguments:"
   echo " -h                      show this help message and exit"
   echo " -i GENBANK_FILE         Input GenBank file (default = sequences/genbank/NM_001385125.gb)"
   echo " -o OUTPUT_FASTA_FILE    Output FASTA file (default = sequences/results/emboss.fasta)"
}

input="sequences/genbank/NM_001385125.gb"
output="sequences/results/emboss.fasta"
while getopts ":h i: o:" flag
do
    case "${flag}" in
        h)
            Help
            exit;;
        i) input=${OPTARG};;
        o) output=${OPTARG};;        
    esac
done

getorf -sequence $input -outseq $output