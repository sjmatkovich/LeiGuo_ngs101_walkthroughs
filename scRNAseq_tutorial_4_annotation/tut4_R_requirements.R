# 2026-07-17

# System Requirements
# R version: >=4.0.0 (R >=4.3.0 recommended)
# RAM: 8GB minimum, 16GB+ recommended
# Storage: minimal beyond what Parts 1-3 already required
# Operating System: Windows, macOS, or Linux

#-----------------------------------------------
# Installation: Cell type annotation packages
#-----------------------------------------------

# Set CRAN mirror
options(repos = c(CRAN = "https://cloud.r-project.org"))

# Core packages (already installed for Parts 1-3)
# Seurat, SeuratObject, ggplot2, dplyr, patchwork, glmGamPoi

# Speeds up FindAllMarkers (Wilcoxon rank-sum test) within Seurat
if (!require("presto", quietly = TRUE))
  pak::pak('immunogenomics/presto')

# Install Bioconductor manager
if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

# SingleR and reference datasets (reference-based annotation)
BiocManager::install(c(
  "SingleR",
  "celldex",
  "SingleCellExperiment"
), update = FALSE, ask = FALSE)

# scCATCH (tissue-specific automated annotation)
install.packages("scCATCH")

# scType dependencies (gene symbol validation, Excel marker database)
install.packages(c(
  "HGNChelper",
  "openxlsx"
))

# Visualization and utilities for method comparison
install.packages(c(
  "ggalluvial",  # Sankey/alluvial diagrams
  "scales",
  "viridis"
))

# Note: scType itself is not an installable package - its two small R scripts
# are sourced directly from GitHub at the point of use (see Part 1 .Rmd,
# "scType: marker-based gene set scoring" section).
