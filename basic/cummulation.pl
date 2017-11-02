#!/usr/bin/perl


open(INIT,"cummulation.ini") or die;
while ($radek=<INIT>){
chomp($radek);

if (($radek !~/^\%/) and ($radek ne "")){
  @pomo=split(/#/,$radek);
  $ini{$pomo[0]}=$pomo[1];
  }
}
close INIT;







@znormovat=split(/,/,$ARGV[1]);
@vahy=split(/,/,$ARGV[2]);


$preskok=0;
$soubor="$ini{prefix}"."$znormovat[0]"."$ini{suffix}";
open(VYSTUP, "$soubor") or $preskok=1;




print "$ARGV[0]:\n";


for ($cykl=$preskok;$cykl<@znormovat;$cykl++){

print " $vahy[$cykl]x $znormovat[$cykl]\n";

$soubor="$ini{prefix}"."$znormovat[$cykl]"."$ini{suffix}";
open(VSTUP,"$soubor") or die;

$i=0;
while ($radek=<VSTUP>){
chomp($radek);($x[$i],$y[$i])=split(/\t/,$radek);
if ($cykl == 0){$kumul[$i]=0}
$kumul[$i]+=$y[$i]*$vahy[$cykl];
$i++
}

$imax=$i;

close(VSTUP);


}




$soubor="$ini{prefix}"."$ARGV[0]"."$ini{suffix}";
open(VYSTUP, ">$soubor") or $preskok=1;

for ($i=0;$i<$imax;$i++){
  print VYSTUP "$x[$i]\t$kumul[$i]\n";
}

close (VYSTUP);




exit(0);
