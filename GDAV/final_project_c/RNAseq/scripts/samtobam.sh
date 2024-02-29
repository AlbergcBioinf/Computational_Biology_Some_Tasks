#!/usr/bin/env bash
## Alberto Gonzalez GDAV 2024 - Convert SAM to BAM

# List of sample names
samples=("hightemp01" "hightemp02" "normal01" "normal02")

# Directories
output_dir="results"
log_dir="logs"

# Loop through each sample
for sample in "${samples[@]}"; do
    sam_file="${output_dir}/${sample}.sam"
    bam_file="${output_dir}/${sample}.bam"
    log_file="${log_dir}/${sample}_conversion.log"

    # Convert SAM to BAM and log errors
    samtools view -bS "${sam_file}" > "${bam_file}" 2> "${log_file}"

    # Check if the conversion was successful
    if [ $? -eq 0 ]; then
        echo "Successfully converted ${sam_file} to ${bam_file}"
    else
        echo "Error converting ${sam_file} to ${bam_file}. Check ${log_file} for details."
    fi
done

echo "SAM to BAM conversion completed for all samples."

