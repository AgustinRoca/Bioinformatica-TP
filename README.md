# TP-Bioinformatica
Scripts para resolver ejercicios del TP de Introducción a la Bioinformática (ITBA)

## Install
### Prerequisites
- You need Python 3
- You need EMBOSS in your computer
- To create a python virtual environment in your computer you need to have `virtualenv`.

### Creating virtual environment
You may need to add execution permissions to `initVenv.sh`. Then you run
```
./initVenv.sh
```
This will build the virtual environment with every dependency needed for this project

## Download swissprot
To download swissprot db needed for exercise 2, you need to run `download_swissprot.sh` in the `blast/data` file

## Run
To run the project you need to start the virtual environment. You can do this with the following command
```
source openVenv.sh
```

### Help
Every single of the following exercises have a `-h` option that prints a help tooltip

### Exercise 1
```
python ej1.py [-i GENBANK_FILE] [-o FASTA_FILE] 
```

### Exercise 2
#### Local Blast
```
./ej2.sh [-i FASTA_FILE] [-o OUTPUT_BLAST_FILE] [-s]
```

#### Remote Blast
```
./ej2.sh [-i FASTA_FILE] [-o OUTPUT_BLAST_FILE] [-r]
```

### Exercise 3
```
python ej3.py [-i FASTA_FILE] [-d FASTA_DIR] [-o MSA_FILE]
```

### Exercise 4
```
python ej4.py [-i FASTA_FILE] -p PATTERN [-ob OUTPUT_BLAST_FILE] [-od OUTPUT_FASTA_DIRECTORY] [-N MAX_RESULTS]
```
