#!/usr/bin/perl


# perl split.pl -i inifile -v file1,..,fileN
# ver 1.0




use Getopt::Std;
getopts('vi:');





# INI file read
$topen="split.ini";
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









@tosplit=split(/,/, $ARGV[0]);


foreach $partial(@tosplit){
  
  if ($opt_v){print "$partial: "}
  $which=0;

  open(INPUT, "$ini{prefix}"."$partial"."$ini{suffix}") or die;
  $rrow=<INPUT>; 
  if($rrow =~ m/([^\t]*)\t(.*)/){$beg=$1;$end=$2;}
  if ($opt_v){print "$which "}
  if ($which<10){
    open(OUTPUT, ">".$ini{prefix}."0".$which."_"."$partial$ini{suffix}") or die;
  }else{
    open(OUTPUT, ">".$ini{prefix}.$which."_"."$partial$ini{suffix}") or die;
  }
  print OUTPUT  "$end\n";

  while ($rrow=<INPUT>){
    $old=$beg;
    if($rrow =~ m/([^\t]*)\t(.*)/){$beg=$1;$end=$2;}
    if ($old ne $beg){
       close OUTPUT; $which++;
       if ($which<10){
          open(OUTPUT, ">".$ini{prefix}."0".$which."_"."$partial$ini{suffix}") or die;
          if ($opt_v){print "$which "}
       }else{
          open(OUTPUT, ">".$ini{prefix}.$which."_".$partial."$ini{suffix}") or die;
          if ($opt_v){print "$which "}
       }
    }
    print OUTPUT "$end\n";
  }
  if ($opt_v){print "\n"}
  close OUTPUT;
}






exit(0)
