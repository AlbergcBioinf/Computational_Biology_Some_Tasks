#!/usr/bin/env bash
## Alberto Gonzalez -Read-count

# Path to the GFF file
GFF_FILE="data/genome.gff"

# Path to the results folder
RESULTS_DIR="results"

# Path to the error logs folder
LOGS_DIR="logs"

# List of BAM files
BAM_FILES=("hightemp01_sorted.bam" "hightemp02_sorted.bam" "normal01_sorted.bam" "normal02_sorted.bam")

# Loop through the BAM files
for BAM_FILE in "${BAM_FILES[@]}"; do
    SAMPLE_ID=$(basename "$BAM_FILE" _sorted.bam)
    OUTPUT_FILE="$RESULTS_DIR/$SAMPLE_ID.count"
    ERROR_LOG="$LOGS_DIR/$SAMPLE_ID.log"

    # Run htseq-count for each BAM file
    htseq-count -f bam -i locus_tag -t CDS -r pos -s no -a 10 "data/$BAM_FILE" "$GFF_FILE" > "$OUTPUT_FILE" 2> "$ERROR_LOG"

    echo "Read counting completed for $SAMPLE_ID"
done

echo "Read counting process finished."

