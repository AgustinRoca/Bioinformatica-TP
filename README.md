# TP-Bioinformatica
Scripts para resolver ejercicios del TP de Introducción a la Bioinformática (ITBA)

## Install
### Prerequisites
- You need Python 3
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

### Exercise 1
```
python ej1.py
```

### Exercise 2
#### Local Blast
```
./ej2_local.sh
```

#### Remote Blast
```
python ej2_remote.py
```

### Exercise 3
```
python ej3.py
```
