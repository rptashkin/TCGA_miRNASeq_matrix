# TCGA_miRNASeq_matrix
This repository will contain support scripts and files to generate a matrix file using miRNASeq data downloaded from TCGA (https://tcga-data.nci.nih.gov/tcga/dataAccessMatrix.htm) 

The R code "get_mature_miR_matrix.R" in conjunction with the lookup txt file "hsa_miR_accessionTOname.txt" may be used to convert individual sample isoform level miRNA RNA-seq data (downloaded via TCGA Data Matrix data portal) to a matrix file for all samples, using mature miRNA names. There are two main outputs for this code:
  
  1) A *sumSort.txt file for each sample *isoform.quantification.txt file. This file collapes to mature miRNA names and provides the sum of the read_count for all miRNA_region IDs that map to a give mature miRNA. 
  
  2)The final output: "miR_counts_matrix.txt". This file is a matrix file of each sumSort.txt file generated earlier in the script.


Questions: r.ptashkin@gmail.com
