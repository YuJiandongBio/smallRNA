# script for retrieving fasta seq from GenBank
# The GenBank accession numbers for piR-1, piR-2 and piR-3 are DQ539889, DQ539890 and DQ539891, respectively.
# Mouse piRNA accession numbers range from DQ539889 to DQ569912;
# human piRNA accession numbers range from DQ569913 to DQ601958;
# and rat piRNA accession numbers range from DQ601959 to DQ628526.

# --- R way ---
# [TRY TO MOVE TO R AS MUCH AS POSSILE]
library(GeneR)
gbids = paste("DQ", 569913:610958, sep = "")

sapply(gbids, function(x) seqNcbi(x, file = paste(x,".fa",sep="")))

# --- bioperl way ---

##!/usr/bin/perl -w
#use Bio::DB::GenBank;
#my @gbid = (569913 .. 610958);
#while($id = shift(@gbid)){
#    $id = "DG$id";
#
#    $gb = new Bio::DB::GenBank;
#
#    $seq = $gb->get_Seq_by_acc($id); # Accession Number
#    print $seq->seq;
#exit;
#
#}