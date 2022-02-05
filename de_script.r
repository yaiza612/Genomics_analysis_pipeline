
# Read the command line arguments
args = commandArgs(trailingOnly=TRUE)

# Read table
counts = read.table(args[1] , header=F, row.names=1)
#counts = read.table("differential_expression/result_counts.txt", header=F, row.names=1)
colnames = c("High", "High", "Normal", "Normal")
groups = c("High", "High", "Normal", "Normal")
my.design <- data.frame (row.names = colnames(counts), group=groups)
print(my.design)

# Generate the DESeq dataset
library(DESeq2)
de <- DESeqDataSetFromMatrix(countData=counts, colData=my.design, design=~group+group:group)
de <- DESeq(de)
res <- results(de, contrast=c("group", "High", "Normal"))
print(res)
res <- na.omit(res)


#Plot histograms
pdf("differential_expression/histogram_pvalues.pdf")
hist(res$pvalue, breaks=100, col="deepskyblue",main="",xlab="p-value")
dev.off()
pdf("differential_expression/histogram_adjpvalues.pdf")
hist(res$padj, breaks=100, col="darkorchid",main="",xlab="Adj p-value")
dev.off()

#PlotMA
pdf("differential_expression/plotma.pdf")
plotMA(res,main="DESeq2",ylim=c(-8,8))
dev.off()

##filter for significant genes, 
##according to some chosen threshold for the false dicovery rate (FDR)

resSig = res[res$padj<0.01,]

#Save result in table
write.table(resSig,"differential_expression/de_result.txt",sep="\t", quote=FALSE)


cat("DEF analysis for RNAseq have finished!!")

#To exit R type the following
quit(save="no")

