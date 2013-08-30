#!/usr/bin/perl

# script to get the distribution of 1st nt of mature piRNA
# input bed file of piRNA clone

while(<STDIN>){
    split;
    $acc = $_[3];
    print $acc, "\n";
}