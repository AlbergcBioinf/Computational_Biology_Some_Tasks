#!/usr/bin/env bash
##Albergc


# Print header line
echo -e "#Assembly\tnum_seqs\tfasta_path"


# Iterate over .fna files in the results directory
for fna_file in results/*.fna; do
  # Extract assembly ID from the file name
  assembly_id=$(basename "$fna_file" | sed 's/_ASM.*$//')

  # Count the number of sequences in the .fna file
  num_seqs=$(grep -c '^>' "$fna_file")

  # Output tab-separated columns
  echo -e "${assembly_id}\t${num_seqs}\t$(basename "$fna_file")"
done

## END
