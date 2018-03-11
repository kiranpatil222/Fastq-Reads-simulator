#!/usr/bin/perl -w	
use strict;
use List::Util qw(shuffle);

my $hg19 = $ARGV[0];	#Input is genome file
open(IN,"$hg19") || die "cannot open file";
open(OUT,">reads.fastq") || die "cannot open file";

#-----------Reading genome file in to hash-------------
my %hash = ();
my $id = ();
while(<IN>) {
	chomp();
	if($_=~/>(.*)/) {
		$id = $1;
		$hash{$id}="";
	} else {
		$hash{$id}.=$_;
	}
}

my @val = values(%hash);
my $str = "@val";
my $len = length($str);
print "$len\n";

# #-------Random Alphanumeric value as Phred score-------
my @score_symb = ("7","A","F","7","-","F","F","-","J","<","-","A","F","J","F","A","J","-","0","2","2","-","2","8","7","5","8","4","(","&","^","^","#","W","@","@","#",")",")",")","!","!","@","#","?","%","&","&","*","~");

my ($base, $seq, $rand_num);
my (@chars, @phred, @phred2);

my $i=0;
while ( $i < 100000) {
	$rand_num = int(rand(500)) + 100;
	#print "$rand_num\n";
	@chars = ("A","T","G","C");
	$base = $chars[rand @chars];
	$seq=substr($str,$rand_num,49).$base; # Adding a single base mismatch to a read
	#print "$seq\n";
	
	
	@phred = shuffle @score_symb;
	@phred2 = join ("", @phred);

	print OUT "\@E00530:143:HKNV2CCXY:2:1101:"."$i"."1942 1:N:0:NCTTGAAT"."\n$seq\n";
	print OUT "+\n@phred2\n";
	$i++;
}
close(OUT);


