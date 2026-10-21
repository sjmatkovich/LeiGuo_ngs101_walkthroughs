# 2026-10-17

# Installing Required Packages for tutorial 7-2 (Slingshot trajectory analysis)

#-----------------------------------------------
# Installation: Slingshot and dependencies
#-----------------------------------------------

# Set CRAN mirror
options(repos = c(CRAN = "https://cloud.r-project.org"))

# Install BiocManager for Bioconductor package management
if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

# Install Slingshot and its Bioconductor dependencies
BiocManager::install(c(
  "slingshot",             # Main trajectory inference package
  "SingleCellExperiment",  # SCE object infrastructure
  "princurve",             # Principal curve algorithm
  "TrajectoryUtils",       # Trajectory data structures and utilities
  "DelayedArray",          # Efficient large matrix operations
  "S4Vectors"              # S4 class system support
))

# Install additional CRAN packages for analysis and visualization
install.packages(c(
  "Seurat",         # Already installed from Parts 1-6
  "SeuratObject",   # Seurat object infrastructure
  "dplyr",          # Data manipulation
  "tidyr",          # Data tidying
  "ggplot2",        # Visualization
  "patchwork",      # Combine plots
  "RColorBrewer",   # Color palettes
  "viridis",        # Perceptually uniform colors
  "scales",         # Scale functions for ggplot2
  "Matrix",         # Sparse matrix operations
  "grDevices"       # Color and graphics utilities
))
