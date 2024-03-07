# Variant Calling Analysis Directory

This directory contains scripts and data for variant calling analysis, focusing on identifying genetic mutations that may relate to the proliferation of organisms under varying temperature conditions.

## Directory Information

- **User**: Alberto Gonzalez Calatayud
- **Date Created**: 23/01/2024
- **Description**: The directory is structured to support the workflow for variant calling analysis. This includes sorting BAM files, preparing them for variant calling, and subsequent analysis steps.

## Script Overview

### sort_bam.sh
- **Purpose**: This script sorts BAM files generated from RNA-seq data. Sorting is a prerequisite step for efficient and accurate variant calling analysis.
- **Usage**: 
    1. Ensure that `samtools` is installed and accessible in your environment.
    2. Execute the script by running `./sort_bam.sh` from the `scripts` directory.
- **Functionality**: The script iterates through BAM files in the `data` directory, sorts them using `samtools sort`, and replaces the original BAM files with their sorted versions. Errors and process information are logged in the `logs` directory.
- **Output**: Sorted BAM files are stored back in the `data` directory, replacing the original unsorted BAM files.

### merge_bam.sh
- **Purpose**: This script merges sorted BAM files from different samples into a single BAM file. It is useful for combining sequencing data from multiple samples for a unified analysis.
- **Usage**: 
    1. Execute the script: `./merge_bam.sh`.
- **Output**: The script generates a single merged BAM file in the `results` directory, keeping the individual sorted BAM files intact on the data directory.

### variant_calling.sh
- **Purpose**: Performs variant calling on the merged BAM file using `bcftools mpileup` and `bcftools call`. The script runs two variant calling processes: one with specified ploidy and one with the default ploidy setting.
- **Usage**: 
    1. Ensure `bcftools` is installed and accessible.
    2. Execute the script: `./variant_calling.sh`.
- **Output**: Two VCF files are created in the `results` directory. One for the variant calling with specified ploidy (`variant_calls.vcf`) and another with the default ploidy (`variant_calls_default_ploidy.vcf`).

### variant_calling_s.sh
- **Purpose**: This script performs variant calling on all sorted BAM files simultaneously. It is designed to analyze each sample separately but within a single run, providing a comprehensive overview of the variants across all samples.
- **Usage**: 
    1. Ensure `bcftools` is needed.
    2. Execute the script: `./variant_calling_s.sh`.
- **Output**: The script generates a single VCF file (`combined_variants.vcf`) in the `results` directory, containing variant calls from all the sorted BAM files. The process log is saved in the `logs` directory.

# Variant Calling Analysis Commands

Details the commands used for the variant calling analysis and their purposes.

## Identifying High-Quality Variants

To find the highest quality variant in the VCF files:

```bash
bcftools view variant_calls_default_ploidy.vcf.gz | grep -v "^#" | sort -k6 -nr | head -1
bcftools view variants_sep.vcf.gz | grep -v "^#" | sort -k6 -nr | head -1
```

## snps and indels check
```bash
bcftools view -H -v snps file | wc -l
bcftools view -H -v indels file | wc -l
```

## Quality check
bcftools filter -i “QUAL>100” file.vcf | bcftools view -H | wc -l
bcftools filter -i "DP>100" file.vcf | bcftools view -H | wc -l

## To obtain the .bai file of each of the sorted.bam in order to perform the VGI use the following command:
```bash
for sorted in *_sorted.bam; do
samtools index "$sorted"
done
```

## Comparing Variant Position with Genome Annotations
To check if the high-quality variant affects any gene:

```bash
awk '$1 == "Aquifex_genome" && $4 <= 1265060 && $5 >= 1265060' data/genome.gff
```

The commands and analyses provided a comprehensive understanding of the potential impact of the high-quality variant on the gene nifA, highlighting the importance of integrating genomic data with functional annotations.


