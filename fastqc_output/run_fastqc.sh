#!/bin/bash
#SBATCH --ntasks=4
#SBATCH --time=24:00:00
#SBATCH --qos=bbdefault
#SBATCH --mail-type=ALL 

set -e

module purge; module load bluebear
module load FastQC/0.11.9-Java-11

fastqc ../raw_reads/*.fastq.gz


