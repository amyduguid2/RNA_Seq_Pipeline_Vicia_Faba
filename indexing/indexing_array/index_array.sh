#!/bin/bash
#SBATCH --ntasks=4
#SBATCH --time=24:00:00
#SBATCH --qos=bbdefault
#SBATCH --mail-type=ALL 
#SBATCH --mem=64G
#SBATCH --array=2-24%6
#SBATCH --output="slurm-%A_%a.out"

module purge; module load bluebear
module load bear-apps/2022b
module load SAMtools/1.17-GCC-12.2.0

BAM_FILE=$(find . -name "JC_${SLURM_ARRAY_TASK_ID}_alignment.bam")

echo "starting sort for job ${SLURM_ARRAY_TASK_ID}"
# Create the sorted BAM file
samtools sort -o JC_${SLURM_ARRAY_TASK_ID}_alignment_sorted.bam ${BAM_FILE}
echo  "finished sort for job ${SLURM_ARRAY_TASK_ID}"
    

echo "starting index for job ${SLURM_ARRAY_TASK_ID}"
# Create the CSI index for the sorted BAM file
samtools index -c JC_${SLURM_ARRAY_TASK_ID}_alignment_sorted.bam
echo "finished index for job ${SLURM_ARRAY_TASK_ID}"

