#!/bin/bash

#-----------------------------------------------
# STEP 8: Run Cell Ranger count on all samples via SLURM
# make executable with chmod +x and run on slurm with sbatch script.sh command
#-----------------------------------------------

#SBATCH --partition=partition_name              # Adjust based on your HPC partitions
#SBATCH --cpus-per-task=16             # Number of CPU cores
#SBATCH --mem=120G                     # Memory allocation (120GB recommended for human genome)
#SBATCH --job-name=cellranger_array
#SBATCH --array=1-12                   # Process samples 1-12 in parallel
#SBATCH --output=logs/cellranger_%A_%a.out    # %A = job ID, %a = array task ID
#SBATCH --error=logs/cellranger_%A_%a.err
#SBATCH --mail-user=your.email@institution.edu
#SBATCH --mail-type=END,FAIL
#SBATCH --time=0-4:00:00               # Time limit per sample
 
#-----------------------------------------------
# Cell Ranger Count - Array Job for Multiple Samples
#-----------------------------------------------
 
# Activate conda environment with Cell Ranger
source ~/miniforge3/etc/profile.d/conda.sh
conda activate ~/Env_scRNA
 
# Define all sample names
SAMPLES=("Healthy_1" "Healthy_2" "Healthy_3" "Healthy_4" \
         "Pre_Patient_1" "Pre_Patient_2" "Pre_Patient_3" "Pre_Patient_4" \
         "Post_Patient_1" "Post_Patient_2" "Post_Patient_3" "Post_Patient_4")
 
# Map SLURM array task ID to sample name
# SLURM arrays are 1-indexed, bash arrays are 0-indexed
SAMPLE_ID=${SAMPLES[$SLURM_ARRAY_TASK_ID-1]}
 
# Define paths
PROJECT_DIR=~/GSE174609                # Main project directory
FASTQ_DIR=${PROJECT_DIR}/fastq         # Directory containing FASTQ files
OUTPUT_DIR=${PROJECT_DIR}/cellranger_output
REFERENCE=~/references/cellranger/refdata-gex-GRCh38-2024-A
 
# Cell Ranger parameters
EXPECTED_CELLS=5000                    # Expected number of cells (adjust based on experiment)
LOCALCORES=16                          # Must match --cpus-per-task
LOCALMEM=110                           # Leave ~10GB buffer for system (120 - 10 = 110)
 
# Create necessary directories
mkdir -p ${OUTPUT_DIR}
mkdir -p ${PROJECT_DIR}/logs
 
# Change to output directory (Cell Ranger creates subdirectories here)
cd ${OUTPUT_DIR}
 
# Run Cell Ranger Count
cellranger count \
    --id=${SAMPLE_ID} \
    --fastqs=${FASTQ_DIR} \
    --sample=${SAMPLE_ID} \
    --transcriptome=${REFERENCE} \
    --expect-cells=${EXPECTED_CELLS} \
    --localcores=${LOCALCORES} \
    --localmem=${LOCALMEM} \
    --chemistry=auto \
    --create-bam=false