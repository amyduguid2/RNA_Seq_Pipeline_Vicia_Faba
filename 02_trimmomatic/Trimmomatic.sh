#!/bin/bash
#SBATCH --ntasks=4
#SBATCH --time=24:00:00
#SBATCH --qos=bbdefault
#SBATCH --mail-type=ALL 

module purge; module load bluebear
module load Trimmomatic/0.39-Java-11
# Define directories
FASTQ_DIR="/rds/projects/f/foyerch-rnaseq-data-faba-bean/raw_reads/"  # Directory containing the fastq files
OUTPUT_DIR="/rds/projects/f/foyerch-rnaseq-data-faba-bean/Trimmomatic_all_files/"  # Directory to save the output files
ADAPTERS="/rds/bear-apps/2021b/EL8-ice/software/Trimmomatic/0.39-Java-11/adapters/TruSeq3-PE.fa"  # Path to the adapter sequences file
TRIMMOMATIC_JAR="rds/bear-apps/2021b/EL8-ice/software/Trimmomatic/0.39-Java-11/trimmomatic-0.39.jar"  # Path to the Trimmomatic jar file

# Loop through all forward read files (_R1_001.fastq.gz)
for R1 in "$FASTQ_DIR"/*_R1_001.fastq.gz; do
    #Identify the corresponding reverse read file (_R2_001.fastq.gz)
    R2="${R1/_R1_001.fastq.gz/_R2_001/fastq.gz}"

    # Extract the base sample name (e.g., JC_10_S10_L001)
    SAMPLE_NAME=$(basename "$R1" _R1_001.fastq.gz)

    #Check both files exist
    if [[ -f "$R1" && -f "$R2" ]]; then
        echo "Found paired reads for sample: $SAMPLE_NAME"

        # Define output file names
        PAIRED_R1_OUT="$OUTPUT_DIR/${SAMPLE_NAME}_paired_R1.fastq.gz"
        UNPAIRED_R1_OUT="$OUTPUT_DIR/${SAMPLE_NAME}_unpaired_R1.fastq.gz"
        PAIRED_R2_OUT="$OUTPUT_DIR/${SAMPLE_NAME}_paired_R2.fastq.gz"
        UNAPIRED_R"_OUT="$OUTPUT_DIR/${SAMPLE_NAME}_unpaired_R2.fastq.gz"

        # Run Trimmomatic
        java -jar "$TRIMMOMATIC_JAR" PE \
            -threads 4 \
            "$R1" "$R2" \
            "$PAIRED_R1_OUT" "$UNPAIRED_R1_OUT" \
            "$PAIRED_R2_OUT" "$UNPAIRED_R2_OUT" \
            ILLUMINACLIP:"$ADAPTERS":2:30:10 \
            SLIDINGWINDOW:4:20 MINLEN:75
    else 
        echo "Missing paired reads for sample: $SAMPLE_NAME"
    fi
done