#!/bin/bash
#SBATCH --ntasks=10
#SBATCH --time=48:00:00
#SBATCH --qos=bbdefault
#SBATCH --mail-type=ALL 

# Combine all the fastq files for each sample together

# Loop through sample prefixes (JC_01 to JC_24)
for sample in JC_{01..24}; do
    # Combine all R1 files for the sample across all lanes
    cat ${sample}_S*L*_paired_R1.fastq.gz > ${sample}_combined_R1.fastq.gz
    
    # Combine all R2 files for the sample across all lanes
    cat ${sample}_S*L*_paired_R2.fastq.gz > ${sample}_combined_R2.fastq.gz
done
