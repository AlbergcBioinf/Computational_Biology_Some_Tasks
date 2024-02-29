#!/usr/bin/env bash
##Albergc


# Browse for .fna files and move them to the results folder
#find . -type f -name "*.fna" -exec mv {} results/ \;

# Delete directories that start with "GCA" and are not .fna files
find results -type d -name "GCA*" ! -name "*.fna" ! -name "README.md" ! -name "assemblies*" -exec rm -r {} \;

## END
