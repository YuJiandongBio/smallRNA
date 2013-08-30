mkdir ~/scratch/small.rna.term.libs.102512
cd ~/scratch/small.rna.term.libs.102512
# piRNA + 23nt
for i in /home/royc/scratch/small.rna.term.libs.102512/smallRNA-term.*/*uniqmap.xkxh.norm.bed.gz;
do
    zcat $i | grep -v track | awk '{OFS="\t"; for(i=1;i<=$6;i++) print $1,$2,$3,$5,$6,$4;}' > ~/scratch/small.rna.term.libs.102512/`basename $i`.bed;
    bam2bw ~/scratch/small.rna.term.libs.102512/`basename $i`.bed &
done


# when it's done (change arrary size in the script below)
qsub bigWigAverageOverBed_81bins.sh ../data/controlSet2/controlSet2.alluniq.bed.81bins 81
