#-----------------------------------------------
# STEP 8: Run Cell Ranger count on all samples
#-----------------------------------------------

source ~/miniforge3/etc/profile.d/conda.sh
conda activate ~/Env_scRNA

cd ~/GSE174609_scRNA/cellranger_output
 
# Configuration
FASTQ_DIR=~/GSE174609_scRNA/raw_data
TRANSCRIPTOME=~/references/cellranger/refdata-gex-GRCh38-2024-A
# Create sample list
SAMPLES=("Healthy_1" "Healthy_2" "Healthy_3" "Healthy_4" \
         "Pre_Patient_1" "Pre_Patient_2" "Pre_Patient_3" "Pre_Patient_4" \
         "Post_Patient_1" "Post_Patient_2" "Post_Patient_3" "Post_Patient_4")
 
# System resources (adjust based on your system)
CORES=16
MEM=64
 
# Expected cells for PBMC samples (typically 3,000-8,000 cells)
EXPECTED_CELLS=5000

# Loop through all samples
for SAMPLE in "${SAMPLES[@]}"; do
    cellranger count \
        --id=${SAMPLE} \
        --output-dir ~/GSE174609_scRNA/cellranger_output \
        --fastqs=${FASTQ_DIR} \
        --sample=${SAMPLE} \
        --transcriptome=${TRANSCRIPTOME} \
        --expect-cells=5000 \
        --localcores=16 \
        --localmem=64 \
        --chemistry=SC3Pv3 \
        --create-bam=false
done