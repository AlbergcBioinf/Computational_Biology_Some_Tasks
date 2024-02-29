#!/usr/bin/env bash
##Albergc


if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <assembly_list_file>"
  exit 1
fi

#Receives as the firts parameter the file with the list of assemblies IDs.

assembly_list_file="$1"

if [ ! -f "$assembly_list_file" ]; then
  echo "Error: Assembly list file '$assembly_list_file' not found."
  exit 1
fi

while IFS= read -r ASSEMBLY_ID; do

	#curl -OJX GET "https://api.ncbi.nlm.nih.gov/datasets/v2alpha/genome/accession/${ASSEMBLY_ID}/download?include_annotation_type=GENOME_FASTA&filename=${ASSEMBLY_ID}.zip" -H "Accept: application/zip"
	#mv "${ASSEMBLY_ID}.zip" "/home/2023/intro/alberto.gcalatayud/genome_analysis/preprocessing/results/"
	
	  # Unzip the file to the corresponding directory
	echo "Descomprimiendo ${ASSEMBLY_ID}.zip en /home/2023/intro/alberto.gcalatayud/genome_analysis/preprocessing/results/${ASSEMBLY_ID}"
	unzip -d "/home/2023/intro/alberto.gcalatayud/genome_analysis/preprocessing/results/${ASSEMBLY_ID}" "${ASSEMBLY_ID}.zip"
	
	#echo "Downloaded and unzipped ${ASSEMBLY_ID}"
done < "$assembly_list_file"

## END
