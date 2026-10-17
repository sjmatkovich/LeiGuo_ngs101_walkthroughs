# 2026-10-17

# Installing Required Packages for tutorial 10 (cell-cell communication with NicheNet)

# Install devtools if not already installed
if (!requireNamespace("devtools", quietly = TRUE))
  install.packages("devtools")
 
# Install BiocManager if needed
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
 
# Install Bioconductor dependencies
BiocManager::install("ComplexHeatmap")
 
# Install CRAN packages needed alongside nichenetr
install.packages(c("tidyverse", "circlize", "ggrepel", "igraph", "ggraph"))
 
# Install nichenetr from GitHub (use the saeyslab fork — the actively maintained version)
devtools::install_github("saeyslab/nichenetr")
