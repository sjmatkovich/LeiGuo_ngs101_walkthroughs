# 2026-10-17

# Installing Required Packages for tutorial 5 (cell-type-specific differential analysis)

#-----------------------------------------------
# Install required packages (run once)
#-----------------------------------------------

# Install BiocManager if needed
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

# Install CRAN packages
# Core packages (Seurat, ggplot2, dplyr, patchwork) already installed in tutorials 2-4
install.packages(c("Seurat", "msigdbr", "ggplot2", "pheatmap",
                   "ggridges", "ggrepel", "patchwork", "dplyr", "tidyr"))

# Install Bioconductor packages
# Notebooks use: DESeq2, limma, speckle. edgeR, fgsea, EnhancedVolcano and pheatmap
# are loaded in the source article but not needed by the code in these notebooks.
BiocManager::install(c("DESeq2", "edgeR", "limma", "speckle", "fgsea", "EnhancedVolcano"))

# Faster FindMarkers (optional; Seurat uses it automatically when installed)
# install.packages("devtools")
devtools::install_github("immunogenomics/presto")
