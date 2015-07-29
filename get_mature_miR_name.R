
#INPUT: 1) Lookup table of mature miR names and accession #s (hsa_miR_accessionTOname.txt)
#       2) a directpry of individual miRNA "isofom" level TCGA data matrices downloaded using TCGA-Assembler... i.e:
#################################################################################
#OUTPUT: an udpated data matrix with full miRNA names.
#################################################################################

#change directory to a directory containing files to update and accessionTOname file i.e.: > setwd("Desktop/miRdata/")

library(splitstackshape)
library(qdap)
library(plyr)
library(reshape)

filenames = dir(pattern="*isoform.quantification.txt")

update_miRname = function(infile)
{
tempFile = read.table(infile, header=TRUE, stringsAsFactors=FALSE)
tempFile =cSplit(tempFile, "miRNA_region", sep=",")
full_list = read.table("hsa_miR_accessionTOname.txt", header=TRUE, stringsAsFactors=FALSE)

tempFile$fullName = lookup(tempFile$miRNA_region_2, full_list$Alias, full_list$Name)
temp2 = data.frame(tempFile$fullName, tempFile$read_count)
colnames(temp2) = c("miRNA", "Count")
write.table(tempFile, file=paste(infile, ".names.txt", sep=""),sep="\t",col.names=TRUE, row.names=FALSE)
write.table(temp2, file=paste(infile, ".counts.txt", sep=""),sep="\t",col.names=TRUE, row.names=FALSE)


temp3 = temp2[!(is.na(temp2[,1])),]
temp3 = temp3[order(temp3[,1]), ]
temp3 = aggregate(data=temp3, temp3[,2] ~ temp3[,1], FUN=sum)
colnames(temp3) = c("miRNA", infile)
write.table(temp3, file=paste(infile, ".sumSort.txt", sep=""),sep="\t",col.names=TRUE, row.names=FALSE)

}

lapply(filenames, update_miRname)

#next need to join all the data matrix files into one matrix


mergeFiles = list.files(pattern="*sumSort.txt")
for (file in mergeFiles){
    if(!exists("mirNames")){
        mirNames = read.table(file, header=TRUE, stringsAsFactors=FALSE)
    }
    if(exists("mirNames")){
        temp_dataset = read.table(file, header=TRUE, stringsAsFactors=FALSE)
        mirNames = rbind.fill(mirNames, temp_dataset)
        rm(temp_dataset)
    }

}

mirNames = as.matrix(mirNames[,1])
mirNames = as.data.frame((sort(unique(mirNames))))
colnames(mirNames) = "miRNA"



# merge each file with this generated names column, putting zero if no match


import.list <- llply(mergeFiles, read.table, header=TRUE)

data_matrix =join(mirNames, as.data.frame(import.list[1]), by= "miRNA", type="left")

for(i in 2:length(mergeFiles)){
    data_matrix =join(data_matrix, as.data.frame(import.list[i]), by= "miRNA", type="left")
}


data_matrix[is.na(data_matrix)] = 0

write.table(data_matrix, file="miR_counts_matrix.txt", sep="\t", col.names=TRUE, row.names=FALSE)
