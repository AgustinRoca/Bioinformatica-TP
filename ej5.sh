#!/bin/bash

Help()
{
   # Display Help
   echo "usage: ej5.sh [-h] [-i FASTA_FILE] [-o OUTPUT_MOTIFS_FILE] [-s]"
   echo
   echo "Ejercicio 5. FASTA -> PatmatMotifs."
   echo
   echo "optional arguments:"
   echo " -h                      show this help message and exit"
   echo " -i FASTA_FILE           Input FASTA file (default = sequences/results/protein.fasta)"
   echo " -o OUTPUT_MOTIFS_FILE    Output PatmatMotifs file (default = sequences/results/motifs.patmatmotifs)"
   echo " -s                      Skip PROSITE download. If not present, will download it from expasy"
}

input="sequences/results/protein.fasta"
output="sequences/results/motifs.patmatmotifs"
download=true
while getopts ":h i: o: :s" flag
do
    case "${flag}" in
        h)
            Help
            exit;;
        i) input=${OPTARG};;
        o) output=${OPTARG};;
        s) download=false;;
        
    esac
done

if $download
then
    echo "Downloading PROSITE..."
    wget https://ftp.expasy.org/databases/prosite/prosite.dat
    wget https://ftp.expasy.org/databases/prosite/prosite.doc
    mkdir prosite
    mv prosite.dat prosite
    mv prosite.doc prosite
fi
prosextract prosite
patmatmotifs -sequence $input -outfile $output