# Gene Expression Analysis Project

- **User:** Alberto Gonzalez Calatayud
- **Date:** 24/01/2024
- **Description:** Differential Expression Analysis Workout

## Scripts

### `read_count.sh`

This script, `read_count.sh`, performs read counting using `htseq-count`. It requires sorted BAM files and the accompanying .gff file as input. To execute the script, navigate to the "final_project" directory and run it from there. The results will be saved in the "results" folder. This script is a crucial step in the analysis pipeline, allowing for the quantification of gene expression levels from aligned sequencing data.

## Rscript.sh

This script is designed to facilitate Differential Expression Analysis (DEA) using the Bioconductor and R packages DESeq2 and tibble. It performs the following essential tasks:

- **Creating DESeq2 Object:** It generates a DESeq2 object by utilizing count data and associated metadata, with careful consideration given to specifying the reference level.

- **Pre-filtering:** The script applies minimal pre-filtering to retain only those rows with a minimum of 10 reads in total, ensuring a robust analysis.

- **DESeq and Results:** DESeq and results functions are executed to perform the differential expression analysis, enabling the identification of genes with significant expression differences.

- **Contrast Design:** Optionally, you can use the script to check the contrast design by employing the `resultsNames(dds)` function.

It plays a crucial role in understanding the impact of environmental changes on gene expression.

## extract_deg_functions.sh

This script leverages the `genome.gff` file located in the `DEA/data/` directory to retrieve potential functions of Differentially Expressed Genes (DEGs) identified through Differential Expression Analysis (DEA). It performs the following essential tasks:

- **Mapping DEGs to Functions:** The script matches DEGs based on their unique identifiers (IDs) to corresponding functions within the `genome.gff` file.

- **Function Retrieval:** It extracts and associates potential gene functions with the identified DEGs, helping to elucidate the roles these genes may play.

This information contributes to a comprehensive analysis of the impact of environmental changes on gene functionality.

