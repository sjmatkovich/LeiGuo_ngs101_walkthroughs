# 2026-10-17

# Installing Required Packages for tutorial 12 (hdWGCNA co-expression networks)

# Source: article code block 1, verbatim

# Step 1: Install BiocManager for Bioconductor packages
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
 
# Step 2: Install Bioconductor dependencies
BiocManager::install("WGCNA")       # Core network analysis engine
BiocManager::install("UCell")       # Single-cell module scoring
BiocManager::install("GeneOverlap") # Required for module overlap statistics
 
# Step 3: Install CRAN dependencies
install.packages(c("tidyverse", "cowplot", "patchwork", "igraph", "harmony"))
 
# Step 4: Install devtools if needed
if (!requireNamespace("devtools", quietly = TRUE))
  install.packages("devtools")
 
# Step 5: Install enrichR from GitHub (the CRAN version is outdated)
devtools::install_github("wjawaid/enrichR")
 
# Step 6: Install hdWGCNA from the dev branch on GitHub
devtools::install_github("smorabit/hdWGCNA", ref = "dev")
