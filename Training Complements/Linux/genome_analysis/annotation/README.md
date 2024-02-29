-**User**: alberto.gcalatayud
-**Date**: 27-09-2023
-**Description**: Annotation of bacterial genome ${ASSEMBLY_ID} using Prokka.

## Symbolic link
A symbolic link has been created from ../../genome_analysis/annotation/data to ../../genome_analysis/preprocessing/results/GCA_000006925.2_ASM692v2_genomic.fna for easier access to the genome to be annotated.

In the terminal:

```bash
ln -s ../../preprocessing/results/GCA_000006925.2_ASM692v2_genomic.fna GCA_000006925.2_ASM692v2_genomic.fna

## File ${ASSEMBLY_ID}.1000.fna
The following command has been used to extract the first 1000 lines of the file GCA_000006925.2_ASM692v2_genomic.fna GCA_000006925.2_ASM692v2_genomic.fna and move them to a new file named ${ASSEMBLY_ID}.1000.fna in the data directory.

In the terminal:

```bash
head -n 1000 GCA_000006925.2_ASM692v2_genomic.fna > ${ASSEMBLY_ID}.1000.fna


##Installation of prokka. 

First a new conda environment called prokka_latest was created and then the latest version of conda-forge or bioconda was searched for.
The latest version of bioconda has been installed:

```bash
mamba install -n prokka_latest -c bioconda prokka=1.14.6

Next, the environment has been exported to a YAML file hanging from the annotation directory:
conda env export -n prokka_latest > environment.yml

## Run prokka using the ${ASSEMBLY_ID}.1000.fna file as input. Redirect prokka's stdout to a file called prokka.out and its stderr to a file called prokka.err, both within the logs directory. This will create a PROKKA_DDMMYYYYY directory.

```bash
prokka data/${ASSEMBLY_ID}.1000.fna --outdir PROKKA_$(date + '%m%d%Y)' --force > logs/prokka.out 2> logs/prokka.err

The new directory has now been moved into results/:

```bash
mv PROKKA_09282023 results/

## Removes the .gff headers (lines starting with #).
## Removes all the lines starting with >, as well as all the lines after them up to the end of the file (i.e. it removes the FASTA part)
```bash
grep -v '^#' PROKKA_09282023.gff > PROKKA_09282023_without_comments.gff

## Saves the result to a new file called ${ASSEMBLY_ID}.gff under the results directory.
```bash
awk '/^>/{exit}{print $0}' PROKKA_09282023_without_comments.gff > results/PROKKA_09282023.gff
rm PROKKA_09282023_without_comments.gff 

# Genomic Annotation Exercise

In this genomic annotation exercise, I performed several tasks using the provided GFF file (${ASSEMBLY_ID}.gff).

## Tasks Performed

### 1. Genomic Chromosome Counting

To determine how many different genomic chromosomes have been annotated, I used the following command:

```bash
awk '{chromosomes[$1] = 1} END {print "Number of different genomic chromosomes annotated: " length(chromosomes)}' ${ASSEMBLY_ID}.gff >> ${ASSEMBLY_ID}.gff.stats

This command counted the unique chromosomes present in column 1 of the GFF file.

### 2. Counting Feature Types
To determine how many different feature types have been annotated, I used the following command:

```bash
'{feature_types[$3] = 1} END {print "Number of different feature types annotated: " length(feature_types)}' awk '{feature_types[$3] = 1} END {print "Number of different feature types annotated: " length(feature_types)}' GCA_000006925.2.gff >> GCA_000006925.2.gff.stats

This command counted the unique feature types present in column 3 of the GFF file.

### 3. Annotated Product Names
To extract and count the product names found in column 9 of the GFF file, I performed the following steps:

```bash
awk -F '\t' '{print $9}' GCA_000006925.2.gff | tr ';' '\t' > temp_list.txt
grep -o -P 'product=\K[^\t]+' temp_list.txt | sort -u > product_names.txt
product_count=$$(wc -l < product_names.txt)
echo "Number of unique product names: $product_count" >> GCA_000006925.2.gff.stats
cat product_names.txt >> GCA_000006925.2.gff.stats

I had problems with extracting the product and gene names (next exercise) with a single command, so I generated temporary files to store them and then send them to the final archive.
What I do is to change the separation by ";" of the different parameters in column 9 and put it in a temporary file. 
Then I search for 'product= with grep using the regular expression 'K' to reset the match on each line and I keep the value of each one and put it in the temporary file product_names.txt.
Finally I take the number of values from the list and enter it in the final file GCA_000006925.2.gff.stats and then put the list with the names.

### 4. Annotated Gene Names
To extract and count the gene names found in column 9 of the GFF file, I performed the same steps as above but for the genes:

```bash
grep -o -P 'gene=\K[^\t]+' temp_list.txt | sort -u > genes_names.txt
genes_count=$(wc -l < genes_names.txt)
echo "Number of unique gene names: $genes_count" >> GCA_000006925.2.gff.stats
cat genes_names.txt >> GCA_000006925.2.gff.stats

