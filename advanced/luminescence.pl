#!/usr/bin/perl


# perl luminescence.pl -i inifile -v file1,..,fileN
# ver 1.0




use Getopt::Std;
getopts('vi:');




# INI file read
$topen="luminescence.ini";
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










@tolumin=split(/,/,$ARGV[0]);
$count=@tolumin;


# read all data
for ($i=0;$i<$count;$i++){
  $datfile="$ini{prefix}"."$tolumin[$i]"."$ini{suffix}";
  $opt_v and print "\n".$datfile.": ";
  open(INPUT,$datfile) or die;
  $point=0;
  while ($rrow=<INPUT>){
    chomp($rrow);
    @pole=split(/\t/,$rrow);
    $wnumber[$i][$point]=$pole[0];
    $value[$i][$point]=$pole[1];$orig[$i][$point]=$pole[1];
    $point++;
  }
  $points[$i]=$point;
  $value[$i][0]=$value[$i][1];$orig[$i][0]=$orig[$i][1];
  $value[$i][$points-1]=$value[$i][$points-2];$orig[$i][$points-1]=$orig[$i][$points-2];
  $opt_v and print "$point points\n";
  close INPUT;
}
print "\n";









# luminescence removal
for ($i=0;$i<$count;$i++){


  for ($j=0;$j<$ini{iterations};$j++){
    $window=0;

    for ($pointy=0;$pointy<$points[$i];$pointy++){
      if ((($pointy-$window-1)>=0)and($pointy+$window+1)<$points[$i]){$window++;}
      while (($window>$ini{window})or($pointy+$window>=$points[$i])){$window--}

      $average=0;
      for ($y=$pointy-$window;$y<=$pointy+$window;$y++){$average+=$orig[$i][$y];}
      $average=$average/(2*$window+1);
      if ($average<$value[$i][$pointy]){$value[$i][$pointy]=$average}
    }
  }

  open(OUTPUT,">$ini{prefix}"."$tolumin[$i]_lumin"."$ini{suffix}") or die;
  printf OUTPUT "$wnumber[$i][0]\t%1.6f\n",$orig[$i][0]-$value[$i][0];
  for ($pointy=1;$pointy<$points[$i];$pointy++){
    printf OUTPUT "$wnumber[$i][$pointy]\t%1.6f\n",$orig[$i][$pointy]-$value[$i][$pointy-1];
  }
  close OUTPUT;

  open(OUTPUT,">$ini{prefix}"."$tolumin[$i]_luminescence"."$ini{suffix}") or die;
  printf OUTPUT "$wnumber[$i][0]\t$value[$i][0]\n";
  for ($pointy=1;$pointy<$points[$i];$pointy++){
    printf OUTPUT "$wnumber[$i][$pointy]\t$value[$i][$pointy-1]\n";
  }
  close OUTPUT;



}








exit(0)
