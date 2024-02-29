#!/usr/bin/env bash
## Alberto Gonzalez GDAV 2024

# Check if the required number of arguments (3) is provided
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <sample_type> <threshold> <output_filename>"
    exit 1
fi

# Parameters
sample_type="$1"
threshold="$2"
output_filename="$3"

# Input and output directories
input_dir="data"
output_dir="results"
log_dir="logs"

# Input files based on sample type
if [ "$sample_type" = "high" ]; then
    forward_file="${input_dir}/metagenomics-hotspring-hightemp.1.fq.gz"
    reverse_file="${input_dir}/metagenomics-hotspring-hightemp.2.fq.gz"
elif [ "$sample_type" = "normal" ]; then
    forward_file="${input_dir}/metagenomics-hotspring-normaltemp.1.fq.gz"
    reverse_file="${input_dir}/metagenomics-hotspring-normaltemp.2.fq.gz"
else
    echo "Incorrect usage: You must provide 'high' or 'normal' as the first argument."
    exit 1
fi

# Output file
output_file="${output_dir}/${output_filename}"

# Log file
log_file="${log_dir}/${sample_type}_motus.log"

# Run motus profile
#motus profile -f "$forward_file" -r "$reverse_file" -o "$output_file" 2>&1 | tee "$log_file"
motus profile -f "$forward_file" -r "$reverse_file" -g "$threshold" -o "$output_file" 2>&1 | tee "$log_file"

# Count lines where the second field ($F[1]) is greater than the threshold
line_count=$(perl -F"\t" -lane 'print if $F[1] > '"$threshold" "$output_file" | wc -l)

echo "Process completed. Results have been saved to: $output_file"
echo "Line count where field 2 > $threshold: $line_count"

# Create an ordered version of the output file
awk '$NF != 0 {print}' "$output_file" > "${output_file}_ordered"
echo "Ordered output saved as: ${output_file}_ordered"

