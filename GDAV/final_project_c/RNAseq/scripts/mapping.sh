#!/usr/bin/env bash
## Alberto Gonzalez GDAV 2024 - BWA Mapping Script

# Input directory
input_dir="data"

# Output directory
output_dir="results"

# Error log directory
log_dir="logs"

# Reference genome
reference_genome="${input_dir}/index/genome.fasta"

# Loop through samples
for direction in "hightemp" "normal"; do
    for number in "01" "02"; do
        # Input file names for forward and reverse reads
        input_file_r1="${input_dir}/${direction}${number}.r1.fq"
        input_file_r2="${input_dir}/${direction}${number}.r2.fq"

        # Output file name
        output_file="${output_dir}/${direction}${number}.sam"

        # Error log file name
        log_file="${log_dir}/${direction}${number}_bwa.log"

        # Run BWA for paired-end reads
        bwa mem -t 4 "${reference_genome}" "${input_file_r1}" "${input_file_r2}" > "${output_file}" 2> "${log_file}"

        echo "Finished mapping ${input_file_r1} and ${input_file_r2} to ${output_file}"
    done
done

echo "All mapping jobs completed."

