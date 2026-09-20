# Code walkthroughs from ngs101 website

Started 2026-05, **last upated** 2026-09-20

Follow-along coding for tutorials from [Lei Guo's ngs101 website](https://ngs101.com/tutorials/)

While 'ngs101' may seem like a name for a beginner's site, there are also more advanced topics in single-cell and spatial omics work on offer, not to mention workflows beyond single-cell (such as GWAS).

## Additions to scRNAseq tutorials

I added code to easily loop over multiple samples to generate QC metrics in tutorial 2.

I also modified some of the integration code in tutorial 3 to use `SCTransform` normalization and to preserve all reductions within the same Seurat object, rather than creating a separate object for each integration method.

## R environment

The `renv.lock` file maintained in this repo corresponds to R 4.5.1, Ubuntu 22.04 LTS, P3M dated to 2026-04-20


