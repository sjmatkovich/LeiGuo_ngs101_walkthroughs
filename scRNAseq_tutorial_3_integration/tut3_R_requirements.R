# 2026-04-24

# System Requirements
# R version: ≥4.0.0 (R ≥4.3.0 recommended)
# RAM: 8GB minimum, 16GB+ recommended
# Storage: ~2GB for this single sample
# Operating System: Windows, macOS, or Linux
# Installing Required Packages

#-----------------------------------------------
# Installation: Integration-specific packages
#-----------------------------------------------

# Set CRAN mirror
options(repos = c(CRAN = "https://cloud.r-project.org"))

# Core packages (already installed in Part 2)
# Seurat, ggplot2, dplyr, patchwork

# Install Bioconductor packages for advanced integration
if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install('glmGamPoi') # speeds up SCTransform

BiocManager::install(c(
  "batchelor",  # FastMNN integration (used by Seurat's IntegrateLayers)
  "scran"       # Additional normalization methods
))

# Install Harmony for integration
install.packages("harmony")

# Install additional visualization and utility packages
install.packages(c(
  "remotes",         # Install R packages stored in GitHub
  "ggrepel",         # Non-overlapping text labels
  "RColorBrewer",    # Color palettes
  "viridis"          # Perceptually uniform color scales
))

# Wrapper functions for integration methods
remotes::install_github('satijalab/seurat-wrappers')

# Install future for parallel processing (used by RPCA integration)
install.packages("future")

# Install FNN for k-nearest neighbor calculations (used in quality metrics)
install.packages("FNN")

# Install cluster for clustering quality metrics (silhouette scores)
install.packages("cluster")

# Install reshape2 for data reshaping (used in cluster quality assessment)
install.packages("reshape2")