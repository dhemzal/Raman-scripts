#!/usr/bin/perl

# version 1.1



open(INIT,"rozdelsady.ini") or die;
while ($radek=<INIT>){
chomp($radek);

if (($radek !~/^\%/) and ($radek ne "")){
  @pomo=split(/#/,$radek);
  $ini{$pomo[0]}=$pomo[1];
  }
}
close INIT;





@pole=split(/,/, $ARGV[0]);


foreach $postupne(@pole){

  $ktery=0;

  open(VSTUP, "$ini{prefix}"."$postupne"."$ini{suffix}") or die;
  $radek=<VSTUP>; @pomo=split(/\t/,$radek);

  if ($ktery<10){
  open(VYSTUP, ">".$ini{prefix}."0".$ktery."_"."$postupne$ini{suffix}") or die;
  }else{
  open(VYSTUP, ">".$ini{prefix}.$ktery."_"."$postupne$ini{suffix}") or die;
  }
  print VYSTUP  $pomo[1]."\t".$pomo[2];

  while ($radek=<VSTUP>){
    $old=$pomo[0];@pomo=split(/\t/,$radek);

    if ($old ne $pomo[0]){
       close VYSTUP; $ktery++;
       if ($ktery<10){
          open(VYSTUP, ">".$ini{prefix}."0".$ktery."_"."$postupne$ini{suffix}") or die;
       }else{
          open(VYSTUP, ">".$ini{prefix}.$ktery."_".$postupne."$ini{suffix}");
       }
    }
    print VYSTUP $pomo[1]."\t".$pomo[2] or die;
  }

  close VYSTUP;
}





exit(0)
