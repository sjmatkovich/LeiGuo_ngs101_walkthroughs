# Code notebooks to implement tutorials from ngs101 website

Started 2026-05, **last updated** 2026-10-10

Follow-along coding for tutorials from [Lei Guo's ngs101 website](https://ngs101.com/tutorials/)

While 'ngs101' may seem like a name for a beginner's site, there are also more advanced topics in single-cell and spatial omics work on offer, not to mention workflows beyond tissue or cell omics (such as GWAS).

I have found the workflows suggested by these tutorials to be helpful, and have prepared R markdown notebooks to encapsulate the code presented at the above website and to render parts of it to be more modular, facilitating implementation into a production environment.

---

## Cloning the repo and setting up the same R environment

A `renv.lock` file is provided in this repo and encodes package versions used in R 4.5.1, Ubuntu 22.04 LTS, P3M (Posit Public Package Manager) dated to 2026-04-20.

Ideally, you will have set up or will be using the same version of Ubuntu and will have installed the same version of R with [Rig](https://rig.r-lib.org/). However, the same `renv.lock` file will work for other R versions and environments, just with some warnings and requests from `renv` to update configuration.

From a bash terminal, run:

```
cd ~/github # or wherever the rpo should be stored
git clone https://github.com/sjmatkovich/LeiGuo_ngs101_walkthroughs.git
```

Or fork the above repository first and then `git clone` your fork.

For ease of configuring R, create an R project in RStudio in the resulting `~/github/LeiGuo_ngs101_walkthroughs` directory, or open this directory in Positron or VSCode. Open an R console and run:

```
install.packages('renv') # only necessary if you don't have `renv` installed
renv::restore()
```

`renv` will install packages specified in the `renv.lock` files and notify you of any required system dependencies that may need to be separately installed.

---

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



