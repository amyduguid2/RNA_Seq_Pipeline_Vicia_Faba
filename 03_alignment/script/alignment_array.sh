#!/bin/bash
#SBATCH --ntasks=10
#SBATCH --time=48:00:00
#SBATCH --qos=bbdefault
#SBATCH --mail-type=ALL
#SBATCH --mem=122G
#SBATCH --array=7-23%5
#SBATCH --output="slurm-%A_%a.out"

module purge; module load bluebear
module load bear-apps/2022b
module load Python/3.10.8-GCCcore-12.2.0
module load HISAT2/2.2.1-gompi-2022b
module load SAMtools/1.17-GCC-12.2.0

# 1) Run the alignment using HISAT2 (created a loop to run the alignment on all the samples at the same time)


echo "Running Hisat2 on ${SLURM_JOB_ID}: Job ${SLURM_ARRAY_TASK_ID} of ${SLURM_ARRAY_TASK_MAX} in the array"

# Collect all R1 and R2 files for the sample across different lanes
r1_files=$(find . -name "JC_${SLURM_ARRAY_TASK_ID}_S*_L*_paired_R1.fastq.gz" | sort | tr '\n' ',')
r2_files=$(find . -name "JC_${SLURM_ARRAY_TASK_ID}_S*_L*_paired_R2.fastq.gz" | sort | tr '\n' ',')

echo "R1 files: ${r1_files}"
echo "R2 files: ${r2_files}"

# Run HISAT2 with the collected R1 and R2 files for the sample
hisat2 -p 10 -x pseudomolecules_only_hedin -1 ${r1_files%,} -2 ${r2_files%,} -S JC_${SLURM_ARRAY_TASK_ID}_alignment.sam

# 2) Convert the SAM files into BAM files
samtools view -bS JC_${SLURM_ARRAY_TASK_ID}_alignment.sam > JC_${SLURM_ARRAY_TASK_ID}_alignment.bam
rm JC_${SLURM_ARRAY_TASK_ID}_alignment.sam

echo "HISAT2 completed for echo Job ${SLURM_ARRAY_TASK_ID} of ${SLURM_ARRAY_TASK_MAX} in the array"
