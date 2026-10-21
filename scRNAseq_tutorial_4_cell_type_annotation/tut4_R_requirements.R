# 2026-10-17

# Installing Required Packages for tutorial 4 (cell type annotation)

#-----------------------------------------------
# Installation: annotation-specific packages
#-----------------------------------------------

# Set CRAN mirror
options(repos = c(CRAN = "https://cloud.r-project.org"))

# Core packages (already installed in Tutorials 2-3)
# Seurat, ggplot2, dplyr, patchwork

if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

# Reference-based annotation (SingleR) and reference datasets
BiocManager::install(c("SingleR", "celldex", "SingleCellExperiment"), update = FALSE, ask = FALSE)

# Marker-based annotation
install.packages("scCATCH")
install.packages(c("HGNChelper", "openxlsx")) # scType dependencies

# Visualization
install.packages(c("ggalluvial", "scales", "viridis"))
