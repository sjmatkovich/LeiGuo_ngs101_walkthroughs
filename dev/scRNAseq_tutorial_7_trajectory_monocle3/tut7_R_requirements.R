# 2026-10-17

# Installing Required Packages for tutorial 7 (Monocle 3 trajectory analysis)

#-----------------------------------------------
# Installation: Monocle 3 and dependencies
#-----------------------------------------------

# Set CRAN mirror
options(repos = c(CRAN = "https://cloud.r-project.org"))

# Install BiocManager for Bioconductor dependencies
if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

# Install Bioconductor dependencies for Monocle 3
BiocManager::install(c(
  "BiocGenerics",
  "DelayedArray",
  "DelayedMatrixStats",
  "limma",
  "lme4",
  "S4Vectors",
  "SingleCellExperiment",
  "SummarizedExperiment",
  "batchelor",
  "Matrix.utils",
  "HDF5Array",
  "terra",
  "ggrastr"
))

# Install CRAN packages
install.packages(c(
  "Seurat",         # Already installed from previous parts
  "SeuratObject",   # Seurat object infrastructure
  "dplyr",          # Data manipulation
  "ggplot2",        # Visualization
  "patchwork",      # Combine plots
  "RColorBrewer",   # Color palettes
  "viridis",        # Perceptually uniform colors
  "Matrix",         # Sparse matrix operations
  "renv",           # Required for Monocle 3 installation
  "remotes"         # Required for SeuratWrappers installation
))

# Install grr (archived CRAN package required by Monocle 3)
install.packages("https://cran.r-project.org/src/contrib/Archive/grr/grr_0.9.5.tar.gz",
                 repos = NULL, type = "source")

# Install Monocle 3 from GitHub
renv::install('cole-trapnell-lab/monocle3')

# Install SeuratWrappers from GitHub (for Seurat <-> Monocle conversion)
remotes::install_github('satijalab/seurat-wrappers')
