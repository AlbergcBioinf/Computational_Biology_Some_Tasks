# Comparative and Functional Analysis (CFA) Directory

This directory contains the tools and results for the Comparative and Functional Analysis of overexpressed genes in response to high-temperature and normal-temperature conditions.

## Directory Information

- **User**: Alberto Gonzalez Calatayud
- **Date Created**: 26/01/2024
- **Description**: The focus of this directory is on analyzing overexpressed genes, extracting their sequences from the proteome, and preparing for functional annotation.

The genome.gff file was used to extract the sequences of the overexpressed genes. There is another file called clean_genome.gff which has been checked (diff command) and its content is the same as genome.gff. They contain the same information.

## Script Execution
### fastaextraction.sh
- **Purpose**: To extract the sequences of overexpressed genes from the assembled proteome file and save them as individual FASTA files.
- **Usage**: 
    1. Navigate to the `scripts` directory.
    2. Run the script: `./fastaextraction.sh`.
- **Output**: The script will create a FASTA file for each overexpressed gene in the `results` directory. Any errors encountered will be logged in the `logs` directory.
Note: If it is necessary to run with other genes you must enter them manually in the script in genes = ( )


## Analysis Overview

1. **FASTA Sequence Extraction**: The `fastaextraction.sh` script identifies and extracts sequences of overexpressed genes from `proteome.faa`.
2. **Functional Annotation**: (Planned) The extracted sequences will undergo functional annotation using various bioinformatics databases to decipher their roles and importance in the organism's response to temperature changes.
