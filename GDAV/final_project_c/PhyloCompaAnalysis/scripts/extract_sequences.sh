#!/usr/bin/env bash

# Define directories
input_dir="../data"
output_dir="../results"
log_dir="../logs"

# Extract sequences from BLAST results and include the query protein
for blast_result in "${output_dir}"/*_blast_results.txt; do
    gene_id=$(basename "${blast_result}" _blast_results.txt)
    query_protein="${input_dir}/${gene_id}.fasta"
    output_file="${output_dir}/${gene_id}_homologs.fasta"
    log_file="${log_dir}/${gene_id}_extract.log"

    # Print the query protein sequence to the output file
    cat "${query_protein}" > "${output_file}"

    # Run Python script to extract sequences and append them to the output file
    python extract_sequences_from_blast_result.py "${blast_result}" "${input_dir}/all_reference_proteomes.faa" >> "${output_file}" 2>> "${log_file}"
done

