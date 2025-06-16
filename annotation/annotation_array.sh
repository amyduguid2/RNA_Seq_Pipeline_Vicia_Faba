#!/bin/bash
#SBATCH --ntasks=4
#SBATCH --time=24:00:00
#SBATCH --qos=bbdefault
#SBATCH --mail-type=ALL 
#SBATCH --mem=122G
#SBATCH --array=22-24%5
#SBATCH --output="slurm-%A_%a.out"

module purge; module load bluebear
module load HTSeq/0.13.5-foss-2020a-Python-3.8.2

BAM=$(find . -name "JC_${SLURM_ARRAY_TASK_ID}_alignment_sorted.bam")

echo "Running htseq count on ${SLURM_JOB_ID}: Job ${SLURM_ARRAY_TASK_ID} of ${SLURM_ARRAY_TASK_MAX} in the array"

htseq-count -f bam -r pos -s no -t gene --idattr ID  --nonunique none ${BAM} HEDIN_TMP5.check.renamed.phase.complete.gff3  > JC_${SLURM_ARRAY_TASK_ID}_alignment_sorted_counts.txt

echo "htseq completed for Job ${SLURM_ARRAY_TASK_ID} of ${SLURM_ARRAY_TASK_MAX} in the array"

