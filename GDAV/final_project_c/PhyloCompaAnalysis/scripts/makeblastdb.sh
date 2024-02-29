#!/usr/bin/env bash

# Define directories
data_dir="../data"
log_dir="../logs"

# Input proteome file
proteome_file="${data_dir}/all_reference_proteomes.faa"

# Check if input file exists
if [ ! -f "${proteome_file}" ]; then
    echo "Error: Proteome file not found." > "${log_dir}/makeblastdb_error.log"
    exit 1
fi

# Run makeblastdb
makeblastdb -in "${proteome_file}" -dbtype prot -out "${proteome_file%.faa}" 2> "${log_dir}/makeblastdb_error.log"

if [ $? -ne 0 ]; then
    echo "Error in makeblastdb execution, check log for details." >> "${log_dir}/makeblastdb_error.log"
else
    echo "BLAST database created successfully."
fi

