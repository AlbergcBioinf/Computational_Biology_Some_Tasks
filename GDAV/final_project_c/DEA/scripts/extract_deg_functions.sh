#!/usr/bin/env bash
## Alberto Gonzalez

# Results directory
results_dir="../results"

# DESeq2 results file
deseq_results="$results_dir/deseq2_results_padj_0.05.csv"

# Genome.gff file
genome_gff="../data/genome.gff"

# Output file for DEGs functions
output_file="$results_dir/degs_functions.txt"

# Log file for errors
log_file="../logs/error_log.txt"

# Get DEGs gene IDs
degs_ids=$(tail -n +2 "$deseq_results" | cut -d',' -f2 | sed 's/"//g')

# Function to extract function value from genome.gff file
get_function() {
  local gene_id="$1"
  local function_line=$(grep -P "ID=${gene_id};" "$genome_gff")
  local function=$(echo "$function_line" | awk -F 'product=' '{print $2}' | awk -F ';' '{print $1}')
  echo "$function"
}

# Search for functions in genome.gff file and save them in the output file
> "$output_file" 
while IFS= read -r gene_id; do
  function=$(get_function "$gene_id")
  if [ -n "$function" ]; then
    echo "Gene ID: \"$gene_id\"" >> "$output_file"
    echo "Function: $function" >> "$output_file"
    echo "" >> "$output_file"
  else
    # Log errors to the log_file
    echo "Error: No function found for Gene ID \"$gene_id\"" >> "$log_file"
  fi
done <<< "$degs_ids"

echo "Functions of DEGs retrieved and saved in $output_file"

