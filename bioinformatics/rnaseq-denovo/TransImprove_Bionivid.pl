use strict;
#use warnings;
#Read Length is considered as 100 bp. Please change it below as and when required !!!

# Command to generate idxstats file
# samtools idxstats <Sample1.bowtie.csorted.bam> >Sample1.idxstats

# Command to generate bed file
# genomeCoverageBed -ibam <Sample1.bowtie.csorted.bam> -bga >Sample1.bed

# Coverage BED File Format Should be as below: Sample.bed
 
#TRINITY_DN40251_c0_g1_i1	0	2	2
#TRINITY_DN40251_c0_g1_i1	2	7	3
#TRINITY_DN40251_c0_g1_i1	7	8	7
#TRINITY_DN40251_c0_g1_i1	8	13	8
#TRINITY_DN40251_c0_g1_i1	13	18	9
#TRINITY_DN40251_c0_g1_i1	18	19	10
#TRINITY_DN40251_c0_g1_i1	19	23	11
#TRINITY_DN40251_c0_g1_i1	23	27	14
#TRINITY_DN40251_c0_g1_i1	27	30	15
#TRINITY_DN40251_c0_g1_i1	30	31	16

my $gapL;my @tmp;my $depth;my $cov;my $AverageDepth;my $ReadLength;

print "\n Enter the Sample Prefix Name: ";
my $prefix= <STDIN>;
chomp($prefix);

print "\n Enter the Sample IdxStat File Name: ";
my $idxstatfile= <STDIN>;
chomp($idxstatfile);

print "\n Enter the Sample BED Coverage File Name: ";
my $bedfile= <STDIN>;
chomp($bedfile);

print "\n Enter the Sample Read Length: ";
my $ReadLength= <STDIN>;
chomp($ReadLength);

print "\n Enter the desired Average Transcript Depth CuttOff ( >1 & <15) : ";
my $AverageDepth= <STDIN>;
chomp($AverageDepth);

print "\n Enter the desired Transcript Alignment Coverage CuttOff ( >60 & <=100) : ";
my $CovCut= <STDIN>;
chomp($CovCut);

my $outfile=$prefix.".CoverageOUT";
open(IN1,"<",$idxstatfile) || die("\nFile $idxstatfile not found!!!\n"); # Idxstats
open(IN2,"<",$bedfile) || die("\nFile $bedfile not found!!!\n"); # bam2BED
open(OUT,">",$outfile); # Output File

# Variables

my %MasterTable=();

# Read IDxstats File

while(<IN1>)
{
	chomp();
	my @tmp1=split("\t",$_);
	unless($tmp1[0] eq '*')
	{
		$MasterTable{$tmp1[0]}{'Length'}=$tmp1[1];
		$MasterTable{$tmp1[0]}{'MAPPED_READS'}=$tmp1[2];
		$MasterTable{$tmp1[0]}{'#_GAPS_LENTH_gt30'}=0;
		$MasterTable{$tmp1[0]}{'Instance'}=0;
	}
	

}
close(IN1);

# Read BedCoverage File

while(<IN2>)
{
	
	chomp($_);
	@tmp=split(/\t/,$_);	#c3_g1_i1_len=247	102	108	6

	if(exists $MasterTable{$tmp[0]})
	{
			
			if($tmp[3] > 0)
			{
				my $alinementLength=($tmp[2] - $tmp[1]);
				$MasterTable{$tmp[0]}{'CoverageLength'}+=$alinementLength;
			}

			if($MasterTable{$tmp[0]}{'Instance'} == 0)
			
			{		
					$MasterTable{$tmp[0]}{'PrevEnd'}=$tmp[2];
					$MasterTable{$tmp[0]}{'CurStart'} =0;
					$MasterTable{$tmp[0]}{'Instance'}++;next;
			}

			if($MasterTable{$tmp[0]}{'Instance'} != 0)

			{		
			 		$MasterTable{$tmp[0]}{'CurStart'} = $tmp[1];
			 		$gapL=$MasterTable{$tmp[0]}{'CurStart'} - $MasterTable{$tmp[0]}{'PrevEnd'};
			 		$MasterTable{$tmp[0]}{'PrevEnd'}=$tmp[2];				
			}
			
			if($gapL >= 30)
			
			{		#print $gapL; exit 0;
					$MasterTable{$tmp[0]}{'#_GAPS_LENTH_gt30'}++;$gapL=0;
			}	
	}
	
}
close(IN2);

print "\n**** Printing Results *****\n";
my $fals; my $tru;my $all;
print OUT "TrID\tLength\tMAPPED_READS\tAvgDepth\tCoverageLength\tCov\tNoOfGAPS_GT-30\tTRANSCRIPT_TYPE\n";

foreach my $trID (keys %MasterTable)
{
	$all++;
	if($MasterTable{$trID}{'MAPPED_READS'} == 0)
	{
		$MasterTable{$trID}{'CoverageLength'}=0;
		$depth=0;$cov=0;
	}

	if($MasterTable{$trID}{'MAPPED_READS'} > 0 && $MasterTable{$trID}{'CoverageLength'} > 0)
	{
	   $cov= (( $MasterTable{$trID}{'CoverageLength'} / $MasterTable{$trID}{'Length'}) * 100);
	   $cov = sprintf "%.2f", $cov;

	   $depth= (( $MasterTable{$trID}{'MAPPED_READS'}) * $ReadLength / $MasterTable{$trID}{'CoverageLength'});
	   $depth = sprintf "%.2f", $depth;
	}   
	
	if($depth >= $AverageDepth && $cov >= $CovCut && $MasterTable{$trID}{'#_GAPS_LENTH_gt30'} == 0)
	{
		$MasterTable{$trID}{'TRANSCRIPT_TYPE'}='TRUE';$tru++;
	}
	else
	{
		$MasterTable{$trID}{'TRANSCRIPT_TYPE'}='FALSE';$fals++;
	}
	
	print OUT "$trID\t$MasterTable{$trID}{'Length'}\t$MasterTable{$trID}{'MAPPED_READS'}\t$depth\t$MasterTable{$trID}{'CoverageLength'}\t$cov\t$MasterTable{$trID}{'#_GAPS_LENTH_gt30'}\t$MasterTable{$trID}{'TRANSCRIPT_TYPE'}\n";
	
}

print "\n**** Analysis Summary ****\n";
print "Total No. of Transcripts Processed: $all \n";
print "Total No. of True Positive Transcripts: $tru \n";
print "Total No. of False Positive Transcripts: $fals \n";
print "\n**** Thank you for using Bionivid's TransImprove Application!!! ****\n\n\n";
