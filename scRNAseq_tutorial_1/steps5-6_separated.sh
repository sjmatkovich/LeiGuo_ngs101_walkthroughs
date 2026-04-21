#!/bin/bash

source ~/miniforge3/etc/profile.d/conda.sh
conda activate ~/Env_scRNA

SRRS=("SRR14575500" "SRR14575501" "SRR14575502" "SRR14575503" "SRR14575504" "SRR14575505" "SRR14575506" "SRR14575507" "SRR14575508" "SRR14575509" "SRR14575510" "SRR14575511")
SAMPLES=("Healthy_1" "Healthy_2" "Healthy_3" "Healthy_4" "Pre_Patient_1" "Pre_Patient_2" "Pre_Patient_3" "Pre_Patient_4" "Post_Patient_1" "Post_Patient_2" "Post_Patient_3" "Post_Patient_4")

#-----------------------------------------------
# STEP 5: Rename files with biological sample name
#-----------------------------------------------
 
cd ~/GSE174609_scRNA/raw_data

## Remove any prefixes to SRR if necessary (e.g. leftover from nfcore-fetchngs)
# for file in SRX*.fastq.gz; do
#     new_name="${file#*_}"
#     mv -- "$file" "$new_name"
# done

# SRR14575500 corresponds to Healthy donor #1
# Cell Ranger expects format: SampleName_S1_L001_R1_001.fastq.gz
 
# Rename R1 (cell barcodes + UMIs)
# mv SRR14575500_1.fastq.gz Healthy_1_S1_L001_R1_001.fastq.gz
 
# Rename R2 (cDNA sequences)
# mv SRR14575500_2.fastq.gz Healthy_1_S1_L001_R2_001.fastq.gz

# Code suggested by Claude 2026-04-20 to perform prefix and suffix renaming

old_prefixes=("${SRRS[@]}")
new_prefixes=("${SAMPLES[@]}")

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