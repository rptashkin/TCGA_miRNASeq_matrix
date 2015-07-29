# TCGA-Assembler_support
Support scripts for TCGA-Assembler (www.compgenome.org/TCGA-Assembler/). TCGA-Assembler is an open-source, freely available tool that automatically downloads, assembles and processes public The Cancer Genome Atlas (TCGA).

The R code "get_mature_miR_name.R" in conjunction with the lookup txt file "hsa_miR_accessionTOname.txt" may be used to convert individual sample isoform level miRNA  RNA-seq data downloaded via TCGA-Assembler to a matrix file for all samples, using mature miRNA names. For more information on downloading miRNA RNA-seq data, please see the TCGA-Assembler package linked above.

################
#Example download of miR data using TCGA-Assembler and matrix file creation: 

>source("Module_A.r")
>source("Module_B.r")

>READ_miRNASeqRawData = DownloadmiRNASeqData(traverseResultFile = "./DirectoryTraverseResult_Mar-12-2014.rda", "~/Desktop/BRCA/miRNA_Data", cancerType = "BRCA", assayPlatform = "miRNASeq",
inputPatientIDs = c("TCGA-BH-A18F-11A",...))

**make sure you have copied "hsa_miR_accessionTOname.txt" file to the "~/Desktop/BRCA/miRNA_Data" working directory**

>setwd("~/Desktop/BRCA/miRNA_Data")

*THEN RUN the "get_mature_miR_name.R" code 

Questions: r.ptashkin@gmail.com
