#!/usr/bin/perl



# perl smooth.pl -i inifile -v outfile file1,..,fileN
# ver 1.0




use Getopt::Std;
getopts('vi:');




# INI file read
$topen="smooth.ini";
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







@tosmooth=split(/,/,$ARGV[0]);
$count=@tosmooth;




# read all data
for ($i=0;$i<$count;$i++){
  $datfile="$ini{prefix}"."$tosmooth[$i]"."$ini{suffix}";
  $opt_v and print "\n".$datfile.": ";
  open(INPUT,$datfile) or die;
  $point=0;
  while ($rrow=<INPUT>){
    chomp($rrow);
    @pole=split(/\t/,$rrow);
    $wnumber[$point]=$pole[0];
    $orig[$i][$point]=$pole[1];
    $point++;
  }
  $points=$point;
  $opt_v and print "$point points\n";
  close INPUT;
}
print "\n";









# smoothing
for ($i=0;$i<$count;$i++){

  open(OUTPUT,">$ini{prefix}"."$tosmooth[$i]_smooth"."$ini{suffix}") or die;
  $window=0;

  for ($pointy=0;$pointy<$points;$pointy++){

    if ((($pointy-$window-1)>=0)and($pointy+$window+1)<$points){
      $window++;
    }
    while (($window>$ini{window})or($pointy+$window>=$points)){$window--}

    $average=0;
    for ($y=$pointy-$window;$y<=$pointy+$window;$y++){
      $average+=$orig[$i][$y];
    }
    printf OUTPUT "$wnumber[$pointy]\t%1.6f\n",$average/(2*$window+1);
  }

  close OUTPUT;

}








exit(0)
