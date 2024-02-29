#!/usr/bin/env bash
## Alberto Gonzalez GDAV 2024 - Merge BAM files script

# Input and output directories
input_dir="../data"
output_dir="../results"
log_dir="../logs"

mkdir -p "${output_dir}"
mkdir -p "${log_dir}"

merged_bam="${output_dir}/merged_samples.bam"
merged_log="${log_dir}/merge.log"

# Merge the sorted BAM files
samtools merge "${merged_bam}" ${input_dir}/*_sorted.bam 2> "${merged_log}"

if [ $? -eq 0 ]; then
    echo "Successfully merged sorted BAM files into ${merged_bam}"
else
    echo "Error merging sorted BAM files. Check ${merged_log} for details."
fi

