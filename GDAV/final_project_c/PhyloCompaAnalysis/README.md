# Phylogenetic Analysis Workflow

## Directory Information

- **User**: Alberto Gonzalez Calatayud
- **Date Created**: 27/01/2024
- **Description**: This directory contains scripts and data for conducting a phylogenetic analysis of overexpressed genes in a specific bacterial isolate. The workflow includes BLAST searches, sequence extraction, alignment, and phylogenetic tree construction.

## Scripts and Usage

1. **makeblastdb.sh**
   - **Location**: `scripts/`
   - **Purpose**: Initializes the BLAST database using the provided proteome file.
   - **Usage**: Execute this script first to set up the BLAST database. It processes `all_reference_proteomes.faa` located in the `data/` directory.

2. **run_blast.sh**
   - **Location**: `scripts/`
   - **Purpose**: Performs BLAST searches for each overexpressed gene against the reference proteomes.
   - **Usage**: Run this script after `makeblastdb.sh` to conduct BLASTp searches. The script uses gene FASTA files from `data/` and outputs the results to `results/`.

3. **extract_sequences.sh**
   - **Location**: `scripts/`
   - **Purpose**: Extracts sequences of homologs from the BLAST results.
   - **Usage**: Execute this script post BLAST to extract relevant sequences based on BLAST results. It reads BLAST output files from `results/` and writes homolog sequences to the same directory.
		This script uses "extract_sequences_from_blast_result.py" so it must be present in the directory.

4. **extract_sequences_from_blast_result.py**
   - **Location**: `scripts/`
   - **Purpose**: Extracts sequences of homologs from the BLAST results.
   - **Usage**: Runs automatically when extract_sequences.sh is called.

4. **build_phylo_tree.sh**
   - **Location**: `scripts/`
   - **Purpose**: Aligns the extracted sequences and builds phylogenetic trees for each gene.
   - **Usage**: Run this script to align homolog sequences and construct phylogenetic trees. It processes files from `results/` and saves tree data in the same directory.

## Log and Error Handling

Each script writes log files to the `logs/` directory. These logs contain information about script execution and any errors encountered. Review these logs for troubleshooting and confirmation of successful script execution.

## Results and Data

All intermediary and final results are stored in the `results/` directory. This includes BLAST search outputs, extracted sequences, aligned sequences, and phylogenetic trees. Review these files for analysis and interpretation of the phylogenetic relationships.

The iTOL software was used to visualize the trees and the files were extracted. .iqtree files were extracted using scp for their visualization.


