# Fastq-Reads-simulator
# Script takes Genome as input argument and generate Single end fastq file with a error rate of 1 % ( Mismatch )
# Usage $ 
# perl Random_FatsQ_simulator.pl hg19.fa
# bwa mem -t 10 hg19.fa reads.fastq >Align.sam
# samtools stats Align.sam | grep "SN" >Alignment_Stats.txt

