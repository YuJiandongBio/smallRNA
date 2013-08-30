# script to calculate/plot R=EST(testis)/EST(all) for spliced and all est.

piRNAcluster = read.delim("../data/piRNA.clusters.both.hg19.bed2", header = F)

est.all = read.table("../data/all_est.in.piRNA.clusters.both.txt", sep="\t", quote="\"")  # with comment filterd
est.spliced = read.table("../data/spliced_est.in.piRNA.clusters.both.txt", sep="\t", quote="\"")

d = piRNAcluster #[1:50,];

in.testis.all = est.all$V10 %in% c("testis","placenta", "prostate");
in.testis.spiced = est.spliced$V10 %in% c("testis","placenta", "prostate")

nonNA.all = (est.all$V10 != "n/a")
nonNA.spliced = (est.spliced$V10 != "n/a")

get_ratio <- function (x){
    print(x)
    chr = x[[1]]
    start = as.numeric(x[2])
    end = as.numeric(x[3])
    strand = x[[6]]
    #print(strand)
    #print(grepl(chr, est.all$V6))
    overlap = grepl(chr, est.all$V6) & (est.all$V8 <= end) & (est.all$V9 >= start) & (est.all$V1 == strand)
    #print(sum(overlap & nonNA.all))
    r1 = sum(overlap & in.testis.all) / sum(overlap & nonNA.all)
    
    overlap = grepl(chr, est.spliced$V6) & (est.spliced$V8 <= end) & (est.spliced$V9 >= start) & est.spliced$V1 == strand
    r2 = sum(overlap & in.testis.spiced) / sum(overlap & nonNA.spliced)
    
    c(r1, r2)
}
r=apply(d, 1, get_ratio)
R=c();
IN = c();
# filter out NaN cases
for(i in 1:ncol(r)){
    if (!is.nan(r[1,i]) & !is.nan(r[2,i])) {
        R=rbind(R, c(r[1,i], r[2,i]))
        IN = c(IN, i);
    }
}
row.names(R)=piRNAcluster[IN,4]
colnames(R) = c("Ratio.allESTs", "Ratio.splicedESTs")
R=as.data.frame(R)
# order according to one col
R.sorted = R[do.call(order, R["Ratio.allESTs"] - R["Ratio.splicedESTs"]), ];

# plot the ratio comparison btw all.est and spliced.est
jpeg("testis.ratio.change.Spliced.vs.allESTs.jpg", width = 600, height = 1200)
split.screen(c(2,1))
screen(1)
plot(R.sorted, xlim=c(0,1),ylim=c(0,1))
abline(a=0, b=1, col="gray60",lty=3)
screen(2)
barplot(sort(R[,1]-R[,2]), xlab="piRNA clusters sorted by Ratio(testis/all) difference", ylab = "Ratio(testis/all).allESTs - Ratio(testis/all).splicedESTs")
close.screen(all.screens = T)
dev.off()

# piRNA are mostly expressed in testis, which is also supported by ESTs.
sum(in.testis.all)/length(in.testis.all)
sum(in.testis.spiced)/length(in.testis.spiced)

#[1] 0.09228371
#[1] 0.1280078


# background ratio
spliced_est.tissue = (28056+12525+6407) / 420165  #0.1118323
all_est.tissue = (20529+11144+36675) / 417875 # 0.1635609
