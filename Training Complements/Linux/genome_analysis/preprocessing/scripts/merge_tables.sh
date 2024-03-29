#!/usr/bin/env bash
#Albergc

#Merge table
cat ../data/taxa.csv | sed '1d; s# *, *#\t#g' > ../data/taxa.tsv
#cat ../data/taxa.csv | sed 's# *, *#\t#g' > ../data/taxa.tsv
#cat ../data/assemblies.tsv | datamash check

join -a 1 -a 2 -e $'-' -o '0,1.2,1.3,1.4,1.5,2.2,2.3,2.4' -t $'\t' \
<(cat ../data/assemblies.tsv | sort) \
<(cat ../data/taxa.tsv | sort) |
tac > ../results/assemblies_taxa_temp.tsv

echo -e "#Assembly\tBioSample\tBioProject\tLevel\tSize(Mb)\tOrganism Name\tOrganism Groups\tStrain" > ../results/assemblies_taxa.tsv

# Concatenates the content of the temporary file to the final filel
cat ../results/assemblies_taxa_temp.tsv >> ../results/assemblies_taxa.tsv

# Deletes the temporary file
rm ../results/assemblies_taxa_temp.tsv

#All the messages generated by the script must be recorded in a file called merge_tables.err within the logs directory
exec &> ../logs/merge_tables.err

#print a message Finished to stderr
echo "Finished" >&2

## END
