# 2026-04-24

# System Requirements
# R version: ≥4.0.0 (R ≥4.3.0 recommended)
# RAM: 8GB minimum, 16GB+ recommended
# Storage: ~2GB for this single sample
# Operating System: Windows, macOS, or Linux
# Installing Required Packages

#-----------------------------------------------
# Installation: Required packages for single-sample QC
#-----------------------------------------------

# Set CRAN mirror
options(repos = c(CRAN = "https://cloud.r-project.org"))

# Install Seurat 5 (the star of this tutorial!)
install.packages("Seurat")

# Install SeuratObject (Seurat's data structure package)
install.packages("SeuratObject")

# Install visualization packages
install.packages(c(
  "ggplot2",        # For custom plots when needed
  "patchwork",      # For combining Seurat plots
  "dplyr"           # Data manipulation
))

# Install Bioconductor manager
if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

# Install Bioconductor packages for QC
BiocManager::install(c(
  "DropletUtils",           # Empty droplet detection
  "scDblFinder",            # Doublet detection (better than DoubletFinder for Seurat 5)
  "SingleCellExperiment"    # Data structure for some QC tools
))

# Install SoupX for ambient RNA correction
install.packages("SoupX")