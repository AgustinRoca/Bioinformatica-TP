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

## Run
To run the project you need to start the virtual environment. You can do this with the following command
```
source openVenv.sh
```

### Run all exercises together
With `make` you can run all 5 exercises one after the other linking inputs and outputs as the exercises intended. 
- `make all` to run all exercises, downloading PROSITE and local BLAST updating Swissprot. 
- `make all remote` to run all exercises, downloading PROSITE and using remote BLAST
- `make all no_update` to run all exercises, using local BLAST
- `make all remote no_update` to run all exercises, using remote BLAST

### Help
Every single of the following exercises have a `-h` option that prints a help tooltip

### Exercise 1
```
python src/ej1.py [-i GENBANK_FILE] [-o FASTA_FILE] 
```

### Exercise 2
#### Local Blast
```
./src/ej2.sh [-i FASTA_FILE] [-o OUTPUT_BLAST_FILE] [-s]
```

#### Remote Blast
```
./src/ej2.sh [-i FASTA_FILE] [-o OUTPUT_BLAST_FILE] [-r]
```

### Exercise 3
```
python src/ej3.py [-i FASTA_FILE] [-o MSA_FILE]
```

### Exercise 4
```
python src/ej4.py [-i FASTA_FILE] -p PATTERN [-ob OUTPUT_BLAST_FILE] [-od OUTPUT_FASTA_DIRECTORY] [-N MAX_RESULTS]
```

### Exercise 5
#### EMBOSS test
```
src/ej5a.sh [-i GENBANK_FILE] [-o OUTPUT_FASTA_FILE]
```

#### Motifs
```
./src/ej5.sh [-i FASTA_FILE] [-o OUTPUT_MOTIFS_FILE] [-s]
```