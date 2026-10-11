# Code notebooks to implement tutorials from ngs101 website

Started 2026-05, **last upated** 2026-10-10

Follow-along coding for tutorials from [Lei Guo's ngs101 website](https://ngs101.com/tutorials/)

While 'ngs101' may seem like a name for a beginner's site, there are also more advanced topics in single-cell and spatial omics work on offer, not to mention workflows beyond tissue or cell omics (such as GWAS).

I have found the workflows suggested by these tutorials to be helpful, and have prepared R markdown notebooks to encapsulate the code presented at the above website and to render parts of it to be more modular, facilitating implementation into a production environment.

## Additions to scRNAseq tutorial code

While the [scRNAseq_tutorial_1_data_ingestion](./scRNAseq_tutorial_1_data_ingestion) folder provides code needed to perform Cellranger processing of fastq files from the `GSE174609` repository, this requires compute cluster resources for efficient work.

Instead, an alternative is to ignore the `scRNAseq_tutorial_1` folder and begin with `scRNAeq_tutorial_2` and its `_part1_alternate.Rmd` notebook to analyze previously downloaded count matrices.

Bash commands for data download and unpack tar archive to `.csv.gz` files for each sample. Run these in a terminal in which the working directory is set to the desired data storage location.

```
mkdir -p GSE174609_scRNA # desired subdirectory name
wget -qO- "https://ftp.ncbi.nlm.nih.gov/geo/series/GSE174nnn/GSE174609/suppl/GSE174609_RAW.tar" | tar -xvf - -C GSE174609_scRNA
```

I added code to easily loop over multiple samples to generate QC metrics in tutorial 2.

I also modified some of the integration code in tutorial 3 to:
- use `SCTransform` normalization (**note 2026-10-10**: alter this to offer `SCTransform` in a parallel notebook series, but keep the main notebooks on standard Seurat log-normalization)
- preserve all reductions within the same Seurat object, rather than creating a separate object for each integration method.

## R environment

The `renv.lock` file maintained in this repo corresponds to R 4.5.1, Ubuntu 22.04 LTS, P3M dated to 2026-04-20


