#!/usr/bin/env bash
## Alberto Gonzalez GDAV 2024 - Sort BAM files script

# Input and log directories
input_dir="../data"
log_dir="../logs"

mkdir -p "${log_dir}"

# Sort BAM files
for bam_file in ${input_dir}/*.bam; do
    base_name=$(basename "${bam_file}" .bam)
    sorted_bam="${input_dir}/${base_name}_sorted.bam"
    log_file="${log_dir}/sort_${base_name}.log"  

    # Sort BAM file and log errors
    samtools sort -o "${sorted_bam}" "${bam_file}" 2> "${log_file}"

    # Check if sorting was successful and remove the unsorted file
    if [ $? -eq 0 ]; then
        echo "Successfully sorted ${bam_file} to ${sorted_bam}"
        rm "${bam_file}"  # Remove the unsorted BAM file
    else
        echo "Error sorting ${bam_file}. Check ${log_file} for details."
    fi
done

echo "All BAM files have been sorted and original files removed."

