#!/usr/bin/env bash

# Define directories
output_dir="../results"
log_dir="../logs"

# Align sequences and build phylogenetic tree
for homologs_fasta in "${output_dir}"/*_homologs.fasta; do
    gene_id=$(basename "${homologs_fasta}" _homologs.fasta)
    aligned_file="${output_dir}/${gene_id}_aligned.fasta"
    tree_file="${output_dir}/${gene_id}_tree"
    log_file="${log_dir}/${gene_id}_phylo.log"

    # Run MAFFT for sequence alignment
    mafft --auto "${homologs_fasta}" > "${aligned_file}" 2>> "${log_file}"

    # Run IQ-TREE for phylogenetic tree construction
    iqtree -s "${aligned_file}" -m LG -pre "${tree_file}" --fast 2>> "${log_file}"
done

