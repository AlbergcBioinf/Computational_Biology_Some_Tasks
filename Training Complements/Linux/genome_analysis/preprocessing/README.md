### Project information. Genome Preprocessing

-**User**: alberto.gcalatayud
-**Date**: 23-09-2023
-**Description**: Retrieval and preprocessing of bacterial genomes data.


##Relevant information:
All scripts have been made in nano

## Merging Tables
# Step 1: Run merge_tables.sh to merge tables
./scripts/merge_tables.sh

######
Script: merge_tables.sh

This script takes two tsv files, taxa.tsv and assemblies.csv, and merges them into one TSV file called assemblies_taxa.tsv.

# Step 2: Verify the results file
After running the script, check the results file to make sure it has been created correctly.

In the data directory you will see a taxa.tsv file. It has been created before joining the two tables. In it, the separator "," has been replaced by "\t".

The assemblies_taxa.tsv file will be in the results directory.

## Assemblies.list
Create a file with a single column in which each row contains an assembly ID 
and is stored in /results/assemblies.list and run this bash command:
```bash
cut -f 1 data/assemblies.tsv | tail -n +2 > results/assemblies.list
```

######
##Script Download_genomes.sh:

This script does the following:
1. It receives as parameter the file with the list of assembly IDs. 
2. It downloads all the genomes in the list using the curl command:
3. For each new genome downloaded, move the file ${ASSEMBLY_ID}.zip to a new directory with the path results/${ASSEMBLY_ID}.
4. Unzip the ${ASSEMBLY_ID}.zip files.

#Run the script:
Run the download_genomes.sh script, providing the assemblies.list file as an argument:
```bash
./download_genomes.sh /home/2023/intro/alberto.gcalatayud/genome_analysis/preprocessing/results/assemblies.list >> ../logs/download_genomes.out 2>> ../logs/download_genomes.err
```
The genomes shall be downloaded and stored in the results directory. Output messages shall be logged in logs/download_genomes.out, and error messages in logs/download_genomes.err.


## Moving `.fna` files to the `results` folder

This project contains `.fna` files scattered in several directories. The aim of this process is to move these .fna files to the `results` folder.

### Running the script

To perform this task, I have created a script called `move_fna_files.sh` in the scripts directory, which uses the `find` command to find `.fna` files in the directory structure and moves them to the `results` folder. 

#####
## Script move_fna_files.sh:

The script uses the `find` command to search for files with the `.fna` extension. Once it finds a `.fna` file, it uses the `mv` command to move it to the `results` folder. 

You can run it from the `preprocessing` directory as follows:
./scripts/move_fna_files.sh

## Cleaning up directories in `results`.

Once we have moved the `.fna` files to the `results` folder, we want to remove the directories 
starting with "GCA" in that folder, with the exception of the `.fna` files we have moved, as well as 
other important files such as the `README` and files starting with "assemblies".

### How the process works

We use the `find` command to search for directories beginning with `GCA` in the `results` folder, but specifically exclude the `.fna` files, 

```bash
find results -type d -name "GCA*" ! -name "*.fna" ! -name "README.md" ! -name "assemblies*" -exec rm -r {} {} -exec rm -r {} -exec rm -r {} -exec rm -r {};
```

#####
### Script paths_count_seqs.sh 

This script parses .fna files in the results directory and collects information 
about genomic assemblies and the number of sequences in each .fna file.
It performs the following actions:

1. prints a header with the column names: assembly, num_seqs and fasta_path.
2. Iterate over the .fna files in results.
3. Extract the assembly ID from the .fna file name.
4. Count the number of sequences in each .fna file.
5. Produces tabulated results with the assembly ID, the number of sequences and the .fna file name.

Results are stored in results/assemblies_paths_count.tsv, and error messages are logged in logs/paths_count_seqs.err.

## To run the script:
```bash
./scripts/paths_count_seqs.sh > results/assemblies_paths_count.tsv 2> logs/paths_count_seqs.err
```

## Generate table assemblies_data.tsv

To generate this table I have created a script called "merge_tables2" in /preprocessing/scripts/merge_tables2.sh in which the columns of the tables "assemblies_taxa.tsv" and "assemblies_paths_count.tsv" have been joined.
I have done it by means of a join, as in the previous script "merge_tables.sh".

#####
Script merge_tables2.sh:

I have created this script in order to put the header to each column of the assemblies_data.tsv table because the headers of the original tables were deleted because they were giving me problems. 
This way I put them by hand to generate the assemblies_data.tsv table in the results directory.

To run the script from preprocessing:
```bash
./results/merge_tables2.sh 
```

Once the new table has been generated and "assemblies_data.tsv" has been checked, 
the previous tables have been deleted from the terminal in the results directory:
rm assemblies_taxa.tsv assemblies_paths_count.tsv assemblies.list
