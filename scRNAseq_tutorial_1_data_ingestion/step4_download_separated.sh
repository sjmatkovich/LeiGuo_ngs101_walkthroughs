#!/bin/bash

#-----------------------------------------------
# STEP 4: Download samples from GSE174609
#-----------------------------------------------

# Activate conda environment with Cell Ranger
source ~/miniforge3/etc/profile.d/conda.sh
conda activate ~/Env_scRNA

cd ~/GSE174609_scRNA/raw_data

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