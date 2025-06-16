# RNA-seq Analysis of Faba Bean (Vicia faba) Cold Response

This repository contains scripts and documentation for RNA-seq analysis of **two Vicia faba genotypes**—**cold tolerant (TOL)** and **cold susceptible (SUS)**—subjected to **three experimental conditions**:

- **C** – Control
- **F** – Control + Freezing
- **AF** – Cold Acclimated + Freezing

The pipeline includes quality control, trimming, alignment to the faba bean genome, quantification, differential expression analysis, PCA, and GO enrichment using soybean orthologs.

---

## 📂 Project Structure

.
├── fastqc_output/ # Quality reports from FastQC
├── Trimmomatic_all_files/ # Cleaned reads from Trimmomatic
├── alignment/script/ # HISAT2 alignment + SAM to BAM conversion
├── indexing/indexing_array/ # SAMtools indexing script and outputs
├── annotation/ # HTSeq-count script and gene count files
├── PCA/ # PCA R scripts and plots
├── DEG_analysis/ # DESeq2 scripts, DEG lists, and volcano plots
├── GO_analysis/ # GO enrichment scripts and pathway figures
└── README.md # This file

---

## 🧪 Experimental Design

- **Genotypes**: Cold Tolerant (TOL) and Cold Susceptible (SUS)
- **Conditions**:
  - Control (C)
  - Control + Freezing (F)
  - Cold Acclimated + Freezing (AF)
- **Groups**: 2 genotypes × 3 conditions = 6 groups

---

## 🔬 Analysis Pipeline

### 1. Quality Control — FastQC

- Tool: [`FastQC`](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/)
- Run on raw reads to identify poor quality regions and adapter contamination
- Output: `.html` and `.zip` reports

---

### 2. Read Trimming — Trimmomatic

- Tool: [`Trimmomatic`](http://www.usadellab.org/cms/?page=trimmomatic)
- Removes Illumina adapters, low-quality regions, and short reads
- Output: Paired/unpaired cleaned FASTQ files

--- 

### 3. Alignment — HISAT2

- Tool: HISAT2
- Reference genome: Faba bean (Faba Bean Genome Consortium)
- Output: .sam alignment files

--- 

### 4. SAM to BAM Conversion & Indexing — SAMtools

- Tool: SAMtools
- Converts SAM to BAM, sorts, and indexes alignments

--- 

### 5. Read Counting — HTSeq-count

- Tool: HTSeq
- Uses aligned .bam files and GTF annotation to generate gene-level counts

---

### 6. PCA — Principal Component Analysis

- Tool: DESeq2 or prcomp() in R
- Visualizes variation between genotypes and conditions

### 7. Differential Expression — DESeq2

- Tool: DESeq2
- Design formula: ~ genotype + condition + genotype:condition
- Output: DEGs and volcano plots

---

### 8. GO Analysis

- 🧬 8.1 Ortholog Mapping
    - Tool: Ensembl Plants BioMart
    - Faba bean gene IDs converted to Glycine max orthologs for better annotation

- 🌱 8.2 Enrichment Analysis
    - Tool: GeneOntology.org
    - Input: up/downregulated gene lists
    - Output: enriched GO terms and pathway figures

- 📎 Dependencies
    - FastQC
    - Trimmomatic
    - HISAT2
    - SAMtools
    - HTSeq
    - R (DESeq2, ggplot2, biomaRt, pheatmap)
    - Internet access or scripts for BioMart/GO.org

- 🧠 Key Findings
    - PCA showed clear separation by genotype and condition.
    - Cold tolerant genotypes had unique transcriptomic signatures under freezing.
    - GO analysis highlighted pathways related to cold response, oxidative stress, and membrane stabilization.

- ✍️ Author
    - This pipeline was developed for an MSc Bioinformatics group project on identifying transcriptomic cold tolerance mechanisms in Vicia faba.


