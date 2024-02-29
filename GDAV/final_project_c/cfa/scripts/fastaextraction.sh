#!/usr/bin/env bash
# Alberto Gonzalez --Extracts specified sequences from a FASTA file

# Define directories
input_dir="../data"
output_dir="../results"
log_dir="../logs"

# Input proteome file
proteome_file="${input_dir}/proteome.faa"

# Overexpressed genes
genes=("AQUIFEX_01423" "AQUIFEX_01759" "AQUIFEX_01761")

# Check if input file exists
if [ ! -f "${proteome_file}" ]; then
    echo "Error: Proteome file not found." > "${log_dir}/fasta_extraction_error.log"
    exit 1
fi

# Function to extract and save gene sequences
extract_sequence() {
    local gene_id=$1
    local output_file="${output_dir}/${gene_id}.fasta"
    awk -v gene_id="${gene_id}" '
    BEGIN {print_sequence = 0}
    /^>/ {
        if (print_sequence) {
            exit
        } else {
            print_sequence = ($0 ~ gene_id)
        }
    }
    print_sequence' "${proteome_file}" > "${output_file}"
}

# Extract and save sequences for each gene
for gene in "${genes[@]}"; do
    extract_sequence "${gene}"
    if [ $? -ne 0 ]; then
        echo "Error extracting sequence for ${gene}" >> "${log_dir}/fasta_extraction_error.log"
    else
        echo "Extracted sequence for ${gene}"
    fi
done

