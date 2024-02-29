### Final task information

-**User**: alberto.gcalatayud

-**Date**: 23-09-2023

-**Description**: Preliminary work with RefSeq's reference bacterial genomes

## Preprocessing Dir:** See Preprocessing in [preprocessing](./preprocessing/README.md) to get more details.
- [data](data/): Contains input data files.
- [logs](logs/): Stores log files.
- [results](results/): Stores analysis results.
- [scripts](scripts/): Contains analysis scripts.


## Annotation

annotation: see Annotation in [annotation](./annotation/README.md) to get more details.


## Assembly_ID
The BioProject I have been assigned to annotate is PJRNA310.

The assembly ID associated to this BioProject is GCA_000006925.2

This value has been stored in a bash variable called ASSEMBLY_ID as follows:

TABLE_FILE="genome_analysis/preprocessing/assemblies_data.tsv"
BIOPROJECT="PRJNA310"
ASSEMBLY_ID=$$(grep "$BIOPROJECT" "$TABLE_FILE" | cut -f 2)
echo "The Assembly ID for the BioProject $BIOPROJECT is: $ASSEMBLY_ID"
