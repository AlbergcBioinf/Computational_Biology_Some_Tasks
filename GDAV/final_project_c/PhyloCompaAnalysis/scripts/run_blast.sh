#!/usr/bin/env bash

# Define directories
input_dir="../data"
output_dir="../results"
log_dir="../logs"

# Run BLASTp for each overexpressed gene against all reference proteomes
for gene_file in "${input_dir}"/AQUIFEX_*.fasta; do
    gene_id=$(basename "${gene_file}" .fasta)
    output_file="${output_dir}/${gene_id}_blast_results.txt"
    log_file="${log_dir}/${gene_id}_blast.log"

    # Run BLASTp
    blastp -query "${gene_file}" -db "${input_dir}/all_reference_proteomes" -evalue 0.001 -outfmt 6 -out "${output_file}" 2> "${log_file}"
done

