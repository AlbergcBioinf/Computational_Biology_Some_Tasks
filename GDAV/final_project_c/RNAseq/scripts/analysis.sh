#!/usr/bin/env bash
## Alberto Gonzalez GDAV 2024


# List of sample names
samples=("hightemp01" "normal01" "hightemp02" "normal02")

# Loop through the samples
for sample in "${samples[@]}"; do
    fq1="data/${sample}.r1.fq"
    fq2="data/${sample}.r2.fq"

    # FastQ format
    # https://en.wikipedia.org/wiki/FASTQ_format
    printf "> Check first and last lines format:\n
    \tForward reads:

    $(head -4 ${fq1})
    \n
    $(tail -4 ${fq1})
    \n
    \tReverse reads:

    $(head -4 ${fq2})

    $(tail -4 ${fq2})
    \n"

    # Ensure both files have the same number of lines
    printf "Both files should have the same number of lines:\n"
    diff \
        <(cat "${fq1}" | wc -l) \
        <(cat "${fq2}" | wc -l) | wc -l
    printf "\n"

    # Check if headers match between R1 and R2
    printf "Both files should have the same reads in the same order (i.e., same headers):\n"
    diff \
        <(cat "${fq1}" | sed -n '1~4p' | sed 's# .*##') \
        <(cat "${fq2}" | sed -n '1~4p' | sed 's# .*##') | wc -l
    printf "\n"

    # Ensure both files have the same number of reads
    printf "Both files should have the same number of reads:\n"
    diff \
        <(cat "${fq1}" | awk 'END{print NR/4}') \
        <(cat "${fq2}" | awk 'END{print NR/4}') | wc -l
    printf "\n"

    # Print the number of reads in both files
    printf "> Number of reads of both files:
    ${fq1} = $(awk 'END{print NR/4}' ${fq1})
    ${fq2} = $(awk 'END{print NR/4}' ${fq2})
    \n"

    # Check the length of reads
    printf "Length of reads:\n"
    cat "${fq1}" | awk '{if (NR%4==2) print length($0)}' | sort -T ./ | uniq -c | sort -k1,1nr | head -4
    printf "\n"
    cat "${fq2}" | awk '{if (NR%4==2) print length($0)}' | sort -T ./ | uniq -c | sort -k1,1nr | head -4
    printf "\n"

    # Compare the distributions of read lengths
    printf "Number of differences in distribution of length of reads:\n"
    diff \
        <(cat "${fq1}" | awk '{if (NR%4==2) print length($0)}' | sort -T ./ | uniq -c | sort -k1,1nr) \
        <(cat "${fq2}" | awk '{if (NR%4==2) print length($0)}' | sort -T ./ | uniq -c | sort -k1,1nr) | 
    wc -l
    printf "\n"

    printf "Basic checks for sample ${sample} finished.\n"
    
    echo "---------------------------------------"
done

echo "Analysis completed for all samples."

