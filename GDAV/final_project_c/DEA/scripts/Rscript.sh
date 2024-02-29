#!/usr/bin/env Rscript
# Alberto Gonzalez

library(DESeq2)
library(tibble)

# Directory containing the HTSeq count files:
directory <- "../results/"  # Asegúrate de que esta ruta sea correcta

# List the files in the directory matching the pattern ".*count"
sampleFiles <- list.files(directory, pattern = ".*count", full.names = TRUE)

# Vector of sample names.
sampleNames <- c("hightemp01", "hightemp02", "normal01", "normal02")

# Vector of conditions.
sampleCondition <- c("hightemp", "hightemp", "normal", "normal")

# Now create a data frame from these vectors.
sampleTable <- data.frame(
    sampleName = sampleNames,
    fileName = sampleFiles,
    condition = sampleCondition)

sampleTable

# Make DESeq2 object from counts and metadata
ddsHTSeq <- DESeqDataSetFromHTSeqCount(
  sampleTable = sampleTable,
  directory = directory,
  design = ~condition)

# Specify the reference level
ddsHTSeq$condition <- relevel(ddsHTSeq$condition, ref = "normal")

# sum counts for each gene across samples
sumcounts <- rowSums(counts(ddsHTSeq))

# get genes with summed counts greater than 10; remove lowly expressed genes
keep <- sumcounts > 10

# keep only the genes for which the vector "keep" is TRUE
ddsHTSeq_filter <- ddsHTSeq[keep,]

# Run DESeq and results functions
dds <- DESeq(ddsHTSeq_filter)

# Get results table
res <- results(dds, pAdjustMethod = "BH")

# Summary of the results
summary(res)

# Check out the first few lines of results
head(res)

# Metadata columns of results
mcols(res, use.names = TRUE)

# Create normalized read counts
normalized_counts <- counts(dds, normalized = TRUE)
normalized_counts_mad <- apply(normalized_counts, 1, mad)
normalized_counts <- normalized_counts[order(normalized_counts_mad, decreasing = TRUE), ]

# DESeq get results table
Res_A_X_total <- results(dds, name = "condition_hightemp_vs_normal", pAdjustMethod = "BH")
Res_A_X_total <- Res_A_X_total[order(Res_A_X_total$padj), ]
Res_A_X_total <- data.frame(Res_A_X_total)
Res_A_X_total <- rownames_to_column(Res_A_X_total, var = "ensembl_gene_id")
Res_A_X_total$sig <- ifelse(Res_A_X_total$padj <= 0.05, "yes", "no")
Res_A_X_total_0.05 <- subset(Res_A_X_total, padj <= 0.05)

# Export output files
write.csv(normalized_counts, "deseq2_normcounts.csv")
write.csv(Res_A_X_total, "deseq2_results_total.csv")
write.csv(Res_A_X_total_0.05, "deseq2_results_padj_0.05.csv")

