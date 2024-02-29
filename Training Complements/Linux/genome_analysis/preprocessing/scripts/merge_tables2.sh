#!/usr/bin/env bash
##Albergc

#Merge table

join -a 1 -a 2 -e $'-' -o '0,1.2,1.3,1.4,1.5,1.6,1.7,1.8,2.2,2.3' -t $'\t' \
<(cat ../results/assemblies_taxa.tsv | sort) \
<(cat ../results/assemblies_paths_count.tsv | sort) |
tac > ../results/assemblies_data_temp.tsv

echo -e "#Assembly\tBioSample\tBioProject\tLevel\tSize(Mb)\tOrganism Name\tOrganism Groups\tStrain\tnum_seqs\tfasta_path" > ../results/assemblies_data.tsv

# Concatenates the content of the temporary file to the final file
cat ../results/assemblies_data_temp.tsv >> ../results/assemblies_data.tsv

# Deletes the temporary file
rm ../results/assemblies_data_temp.tsv


#print a message Finished
echo "Finished" 

## END
