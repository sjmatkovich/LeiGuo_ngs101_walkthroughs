#-----------------------------------------------
# STEP 0: Install Cell Ranger
#-----------------------------------------------
 
# Create a directory for Cell Ranger installation
mkdir -p ~/software
cd ~/software
 
# Download Cell Ranger (version 10.0.0)
# Note: Check https://www.10xgenomics.com/support/software/cell-ranger/downloads#download-links for the most current version
wget -O cellranger-10.0.0.tar.gz "https://cf.10xgenomics.com/releases/cell-exp/cellranger-10.0.0.tar.gz?Expires=1776761307&Key-Pair-Id=APKAI7S6A5RYOXBWRPDA&Signature=DsZy17ey9Ouw2SzU9dJ0vWDCA7ut-QfNHzkhWscK658AEcuog3Kudf6SwaeWmtN7rKwWCQhuNvD7U17b3-IUkmB~U7XTjRgsABF1dMd5TVsReQztqOQZL-2J-q7ZJkFBAzhUB1exUZC-fp6AIBOPYBQq5O6B7qOgCzENOdDs0qgdvgxsReuNnolQoiJYRd6Eo--Yb6NT82VL~T0FfxR7JmMDYeyp6VT45ci~YIlZWWXgf-~m6XFj1qsHSfPoBJFp8kC62oXvfeMDwHbT4sWH~KEe99HCzgkHXw3BzYw3Zji2YqvI-wLpq4VPEtYIi5z79gBM-M9Njje94JUICwRjdw__"
 
# Extract the tarball
tar -xzvf cellranger-10.0.0.tar.gz
 
# Add Cell Ranger to PATH (optional: add to ~/.bashrc for permanent access)
export PATH=$HOME/software/cellranger-10.0.0:$PATH
 
# To make this permanent, add to your ~/.bashrc:
# echo 'export PATH=$HOME/software/cellranger-10.0.0:$PATH' >> ~/.bashrc
# source ~/.bashrc
 
# Check Cell Ranger components
cellranger -h

#-----------------------------------------------
# STEP 1: Install supporting software using Conda
#-----------------------------------------------
 
# Create a dedicated conda environment for single-cell analysis
conda create -p ~/Env_scRNA python=3.10
 
# Activate the environment
conda activate ~/Env_scRNA
 
# Configure conda channels
conda config --add channels defaults
conda config --add channels bioconda
conda config --add channels conda-forge
conda config --set channel_priority strict
 
# Install required tools
conda install -y \
    sra-tools \          # For downloading data from SRA
    fastqc \             # For quality control
    multiqc \            # For aggregating QC reports
    wget \               # For downloading files
    samtools             # For BAM file manipulation
 
# Verify installations
fastqc --version         # FastQC v0.12.1
multiqc --version        # multiqc, version 1.19
prefetch --version       # prefetch : 3.0.10

#-----------------------------------------------
# STEP 2: Download Cell Ranger reference genome
#-----------------------------------------------
 
# Create a directory for reference genomes
mkdir -p ~/references/cellranger
cd ~/references/cellranger
 
# Download human reference genome (GRCh38/hg38)
wget https://cf.10xgenomics.com/supp/cell-exp/refdata-gex-GRCh38-2024-A.tar.gz
 
# Download mouse reference genome (GRCm39)
# wget "https://cf.10xgenomics.com/supp/cell-exp/refdata-gex-GRCm39-2024-A.tar.gz"
 
# Download rat reference genome (mRatBN7.2)
# wget "https://cf.10xgenomics.com/supp/cell-exp/refdata-gex-mRatBN7-2-2024-A.tar.gz"
 
# Extract the reference
tar -xzvf refdata-gex-GRCh38-2024-A.tar.gz
 
# The extracted directory contains:
# - genome.fa: Reference genome FASTA
# - genes.gtf: Gene annotations
# - star/: Pre-built STAR aligner index

#-----------------------------------------------
# STEP 3: Create project directory structure
#-----------------------------------------------
 
# Create main project directory
mkdir -p ~/GSE174609_scRNA
cd ~/GSE174609_scRNA
 
# Create subdirectories for organization
mkdir -p raw_data          # For downloaded FASTQ files
mkdir -p fastqc_reports    # For quality control reports
mkdir -p cellranger_output # For Cell Ranger results
mkdir -p scripts           # For analysis scripts
mkdir -p logs              # For log files
 
# Verify structure
tree -L 1 .
# Expected output:
# .
# ├── raw_data
# ├── fastqc_reports
# ├── cellranger_output
# ├── scripts
# └── logs

#-----------------------------------------------
# STEP 4: Download samples from GSE174609
#-----------------------------------------------
 
cd ~/GSE174609_scRNA/raw_data
 
# We'll download all samples
SRRS=("SRR14575500" "SRR14575501" "SRR14575502" "SRR14575503" "SRR14575504" "SRR14575505" "SRR14575506" "SRR14575507" "SRR14575508" "SRR14575509" "SRR14575510" "SRR14575511")
SAMPLES=("Healthy_1" "Healthy_2" "Healthy_3" "Healthy_4" "Pre_Patient_1" "Pre_Patient_2" "Pre_Patient_3" "Pre_Patient_4" "Post_Patient_1" "Post_Patient_2" "Post_Patient_3" "Post_Patient_4")

for SRR in "${SRRS[@]}"; do
# Step 1: Download SRA file
# This creates a directory ~/ncbi/public/sra/SRR14575500.sra
prefetch $SRR
 
# Step 2: Convert to FASTQ with split files
# --split-files: Create separate R1 and R2 files
# --include-technical: Include index reads if present (I1, I2)
# --threads: Use multiple cores for faster conversion
# --progress: Show progress bar
fasterq-dump --split-files \
             --include-technical \
             --threads 8 \
             --progress \
             --outdir . \
             $SRR/${SRR}.sra
 
# Step 3: Compress FASTQ files to save space
# gzip reduces file size by ~70%
gzip ${SRR}*.fastq
 
# Step 4: Clean up SRA file to save disk space
rm -rf $SRR

done

#-----------------------------------------------
# STEP 5: Rename files with biological sample name
#-----------------------------------------------
 
cd ~/GSE174609_scRNA/raw_data
 
# SRR14575500 corresponds to Healthy donor #1
# Cell Ranger expects format: SampleName_S1_L001_R1_001.fastq.gz
 
# Rename R1 (cell barcodes + UMIs)
# mv SRR14575500_1.fastq.gz Healthy_1_S1_L001_R1_001.fastq.gz
 
# Rename R2 (cDNA sequences)
# mv SRR14575500_2.fastq.gz Healthy_1_S1_L001_R2_001.fastq.gz

# Code suggested by Claude 2026-04-20 to perform prefix and suffix renaming

old_prefixes=SRRS
new_prefixes=SAMPLES

old_suffixes=("_1.fastq.gz" "_2.fastq.gz")
new_suffixes=("_S1_L001_R1_001.fastq.gz" "_S1_L001_R2_001.fastq.gz")

for p in "${!old_prefixes[@]}"; do
    op="${old_prefixes[$p]}"
    np="${new_prefixes[$p]}"

    for s in "${!old_suffixes[@]}"; do
        os="${old_suffixes[$s]}"
        ns="${new_suffixes[$s]}"

        for file in "${op}"*"${os}"; do
            [[ -e "$file" ]] || continue

            stem="${file#${op}}"       # strip old prefix
            stem="${stem%${os}}"       # strip old suffix
            new_name="${np}${stem}${ns}"

            echo "Renaming: $file -> $new_name"
            mv -- "$file" "$new_name"
        done
    done
done

#-----------------------------------------------
# STEP 6: Quality control with FastQC
#-----------------------------------------------
 
cd ~/GSE174609_scRNA
 
# Create output directory
mkdir -p fastqc_reports
 
# Run FastQC on all FASTQ files
# We'll run on R2 only (cDNA reads)
fastqc raw_data/*_R2_001.fastq.gz \
    --outdir fastqc_reports \
    --threads 8 \
    --quiet
 
# Aggregate results with MultiQC
multiqc fastqc_reports \
    --outdir fastqc_reports \
    --filename multiqc_report \
    --title "GSE174609 Quality Control"
    
# Why We Focus on R2:
# 
# R1 (Cell Barcode + UMI): Expected to have low sequence complexity
# Will “fail” several FastQC modules (this is normal!)
# Per-base sequence content will be uneven (expected)
# Sequence duplication will be high (expected – only 750K possible barcodes)
# R2 (cDNA): Should look like good RNA-seq data
# High per-base quality (>Q30)
# Diverse sequence content
# Should pass most FastQC modules
# Interpreting FastQC Results
# Key Metrics to Evaluate:
# 
# 1. Per Base Sequence Quality
# 
# Good: Green across all bases, Q scores >28
# Acceptable: Yellow in the first few bases or at the end
# Poor: Red zones, Q scores <20
# For our data: Should see high quality (>Q30) across most of the read
# 2. Per Sequence Quality Scores
# 
# Good: Sharp peak at Q35-40
# Poor: Broad distribution or peak at low quality
# For our data: Expect peak around Q36-38
# 3. Adapter Content
# 
# Good: No adapters detected
# Poor: Adapters present (>5%)
# For our data: Should be minimal (<1%) as facilities remove adapters