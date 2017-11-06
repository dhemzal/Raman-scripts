#!/usr/bin/perl


# perl cummulation.pl -i inifile -v outfile file1,..,fileN weigh1,..,weighN
# ver 1.0




use Getopt::Std;
getopts('vi:');

$topen="cummulation.ini";
if ($opt_i ne ""){$topen=$opt_i.".ini"};

open(INIT,$topen) or die;
while ($rrow=<INIT>){
  chomp($rrow);

  if (($rrow !~/^\%/) and ($rrow ne "")){
    @pomo=split(/#/,$rrow);
    $ini{$pomo[0]}=$pomo[1];
  }
}
close INIT;







@tonorm=split(/,/,$ARGV[1]);
@weighs=split(/,/,$ARGV[2]);


$skip=0;
if ($ARGV[0]==$tonorm[0]){
  $datfile="$ini{prefix}"."$tonorm[0]"."$ini{suffix}";
  unless (-f $datfile){$skip=1};
}



$opt_v and print "$ARGV[0]:\n";


for ($cycl=$skip;$cycl<@tonorm;$cycl++){

$opt_v and print " $weighs[$cycl]x $tonorm[$cycl]\n";

  $datfile="$ini{prefix}"."$tonorm[$cycl]"."$ini{suffix}";
  open(INPUT,"$datfile") or die;

  $i=0;
  while ($rrow=<INPUT>){
    chomp($rrow);($x[$i],$y[$i])=split(/\t/,$rrow);
    if ($cycl == 0){$cummul[$i]=0}
    $cummul[$i]+=$y[$i]*$weighs[$cycl];
    $i++
  }
  $imax=$i;

  close(INPUT);
}

$datfile="$ini{prefix}"."$ARGV[0]"."$ini{suffix}";
open(OUTPUT, ">$datfile") or die;

for ($i=0;$i<$imax;$i++){
  print OUTPUT "$x[$i]\t$cummul[$i]\n";
}

close (OUTPUT);




exit(0);
