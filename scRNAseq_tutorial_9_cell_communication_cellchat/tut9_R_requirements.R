# 2026-10-17

# Installing Required Packages for tutorial 9 (CellChat cell-cell communication)

# Step 1: Install BiocManager if needed (for Bioconductor packages)
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
 
# Step 2: Install Bioconductor dependencies
BiocManager::install(c("BiocNeighbors", "ComplexHeatmap"))
 
# Step 3: Install NMF (>= 0.23.0) — required for communication pattern analysis
install.packages("NMF")
 
# Step 4: Install circlize from CRAN (chord diagrams)
# If the CRAN version is too old, use: devtools::install_github("jokergoo/circlize")
install.packages("circlize")
 
# Step 5: Install ggalluvial — required for river/Sankey plots (netAnalysis_river)
install.packages("ggalluvial")
 
# Step 6: Install devtools if not already installed
if (!requireNamespace("devtools", quietly = TRUE))
  install.packages("devtools")
 
# Step 7: Install CellChat from GitHub
devtools::install_github("jinworks/CellChat")
 
# Step 8: Install reticulate (Python bridge — required by netEmbedding)
if (!requireNamespace("reticulate", quietly = TRUE))
  install.packages("reticulate")
