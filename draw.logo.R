# draw logo for first and last 10nt of piRNA
library(seqLogo);
library(Biostrings);

# read the data
data = read.delim("../data/piRNA.clones.Girard2006.out.singlebest.fullmatch.uniqmapped.inRNAseq.end10nt.bed", header = F)

png(file="piRNA.clones.Girard2006.out.singlebest.fullmatch.uniqmapped.inRNAseq.end10nt.mapped.head.png")
#split.screen(c(3,2))
#screen(1)
first <- DNAStringSet(as.vector(t(data[data$V7 == "mapped", 8])))  # Sample set of DNA fragments.
t=consensusMatrix(first)[1:4,]
seqLogo(t/sum(t[,1]))
dev.off()

png(file="piRNA.clones.Girard2006.out.singlebest.fullmatch.uniqmapped.inRNAseq.end10nt.mapped.tail.png")

#screen(2)
last <- DNAStringSet(as.vector(t(data[data$V7 == "mapped", 9])))  # Sample set of DNA fragments.
t=consensusMatrix(last)[1:4,]
seqLogo(t/sum(t[,1]))
dev.off()
#screen(3)
png(file="piRNA.clones.Girard2006.out.singlebest.fullmatch.uniqmapped.inRNAseq.end10nt.part.head.png")

first <- DNAStringSet(as.vector(t(data[data$V7 == "part", 8])))  # Sample set of DNA fragments.
t=consensusMatrix(first)[1:4,]
seqLogo(t/sum(t[,1]))
dev.off()

#screen(4)
png(file="piRNA.clones.Girard2006.out.singlebest.fullmatch.uniqmapped.inRNAseq.end10nt.part.tail.png")

last <- DNAStringSet(as.vector(t(data[data$V7 == "part", 9])))  # Sample set of DNA fragments.
t=consensusMatrix(last)[1:4,]
seqLogo(t/sum(t[,1]))
dev.off()

#screen(5)
png(file="piRNA.clones.Girard2006.out.singlebest.fullmatch.uniqmapped.inRNAseq.end10nt.not.head.png")

first <- DNAStringSet(as.vector(t(data[data$V7 == "not", 8])))  # Sample set of DNA fragments.
t=consensusMatrix(first)[1:4,]
seqLogo(t/sum(t[,1]))
dev.off()

#screen(6)
png(file="piRNA.clones.Girard2006.out.singlebest.fullmatch.uniqmapped.inRNAseq.end10nt.not.tail.png")

last <- DNAStringSet(as.vector(t(data[data$V7 == "not", 9])))  # Sample set of DNA fragments.
t=consensusMatrix(last)[1:4,]
seqLogo(t/sum(t[,1]))
dev.off()

#close.screen(all.screens = T)

#pwm <- PWM(first, type="prob") # Computes a PWM for DNA fragments.
#pwm=pwm/sum(pwm[,1]);
#seqLogo(pwm)
