#!/usr/bin/env bash
## Alberto Gonzalez GDAV 2024

# Input and output directories
input_dir="data"
output_dir="results"
log_dir="logs"

# Ensure the log directory exists
mkdir -p "${log_dir}"

# Input files
merged_bam="${output_dir}/merged_samples.bam"
reference_genome="${input_dir}/index/genome.fasta"

# Output file for the first task (specified ploidy)
output_vcf="${output_dir}/variant_calls.vcf"
log_file="${log_dir}/variant_calling.log"

# Output file for the second task (default ploidy)
output_vcf_default_ploidy="${output_dir}/variant_calls_default_ploidy.vcf"
log_file_default_ploidy="${log_dir}/variant_calling_default_ploidy.log"

# Variant calling using bcftools with specified ploidy
bcftools mpileup --threads 1 -f "${reference_genome}" "${merged_bam}" |
bcftools call --threads 1 --ploidy 1 -mv -Ob -o "${output_vcf}" 2> "${log_file}"

if [ $? -eq 0 ]; then
    echo "Variant calling completed successfully. Results saved to ${output_vcf}"
else
    echo "Error during variant calling. Check ${log_file} for details."
fi

# Variant calling using bcftools without specifying ploidy (default)
bcftools mpileup --threads 1 -f "${reference_genome}" "${merged_bam}" |
bcftools call --threads 1 -mv -Ob -o "${output_vcf_default_ploidy}" 2> "${log_file_default_ploidy}"

if [ $? -eq 0 ]; then
    echo "Variant calling (default ploidy) completed successfully. Results saved to ${output_vcf_default_ploidy}"
else
    echo "Error during variant calling (default ploidy). Check ${log_file_default_ploidy} for details."
fi

