#!/usr/bin/env bash
## Alberto Gonzalez GDAV 2024 - Variant Calling on Individual Samples

# Input and output directories
input_dir="../data"
output_dir="../results"
log_dir="../logs"

# Create directories if they don't exist
mkdir -p "${output_dir}"
mkdir -p "${log_dir}"

# Reference genome
reference_genome="${input_dir}/index/genome.fasta"

# Output file for variant calling with specified ploidy on individual samples
output_vcf_ploidy1_indiv="${output_dir}/variants_sep_ploidy1_individual.vcf"
log_file_ploidy1_indiv="${log_dir}/variant_calling_sep_ploidy1_individual.log"

# Output file for variant calling with default ploidy on individual samples
output_vcf_default_ploidy_indiv="${output_dir}/variants_sep_default_ploidy_individual.vcf"
log_file_default_ploidy_indiv="${log_dir}/variant_calling_sep_default_ploidy_individual.log"

# Variant calling on all sorted BAM files with specified ploidy
bcftools mpileup --threads 1 -f "${reference_genome}" ${input_dir}/*_sorted.bam |
bcftools call --threads 1 --ploidy 1 -mv -Ob -o "${output_vcf_ploidy1_indiv}" 2> "${log_file_ploidy1_indiv}"

# Check for success or failure
if [ $? -eq 0 ]; then
    echo "Variant calling with specified ploidy completed successfully. Results saved to ${output_vcf_ploidy1_indiv}"
else
    echo "Error during variant calling with specified ploidy. Check ${log_file_ploidy1_indiv} for details."
fi

# Variant calling on all sorted BAM files with default ploidy
bcftools mpileup --threads 1 -f "${reference_genome}" ${input_dir}/*_sorted.bam |
bcftools call --threads 1 -mv -Ob -o "${output_vcf_default_ploidy_indiv}" 2> "${log_file_default_ploidy_indiv}"

# Check for success or failure
if [ $? -eq 0 ]; then
    echo "Variant calling with default ploidy completed successfully. Results saved to ${output_vcf_default_ploidy_indiv}"
else
    echo "Error during variant calling with default ploidy. Check ${log_file_default_ploidy_indiv} for details."
fi

