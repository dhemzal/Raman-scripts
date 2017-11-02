#!/usr/bin/perl










open(INIT,"luminescence.ini") or die;
while ($radek=<INIT>){

chomp($radek);


if (($radek !~/^\%/) and ($radek ne "")){
  @pomo=split(/#/,$radek);
$ini{$pomo[0]}=$pomo[1];
}


}


close INIT;



@poradi=split(/,/,$ARGV[0]);
$pocet=@poradi;


for ($i=0;$i<$pocet;$i++){
$soubor="$ini{prefix}"."$poradi[$i]"."$ini{suffix}";
print "\n".$soubor.": ";
open(VSTUP,$soubor) or die;
$bod=0;
while ($radek=<VSTUP>){
chomp($radek);
@pole=split(/\t/,$radek);
$vlnocet[$i][$bod]=$pole[0];
$hodnota[$i][$bod]=$pole[1];$orig[$i][$bod]=$pole[1];
$bod++;
}
$bodu[$i]=$bod;
$hodnota[$i][0]=$hodnota[$i][1];$orig[$i][0]=$orig[$i][1];
print "$bod bodu\n";
close VSTUP;
}
print "\n";










for ($i=0;$i<$pocet;$i++){


for ($j=0;$j<$ini{iterations};$j++){


#$odkud=$ini{window};
#while ($vlnocet[$odkud-$ini{window}]>$ini{xmax}){$odkud++}
#$kam=$bodu-$ini{window}-1;
#while ($vlnocet[$kam+$ini{window}]<$ini{xmin}){$kam--}

#print "$vlnocet[$odkud-$ini{window}] $vlnocet[$kam+$ini{window}] \n";

$okno=0;
for ($body=0;$body<$bodu[$i];$body++){
  $prumer=0;
  for ($y=0;$y<(2*$okno+1);$y++){$prumer+=$hodnota[$i][$body-$okno+$y];}
  $prumer=$prumer/(2*$okno+1);
  if ($prumer<$hodnota[$i][$body]){$hodnota[$i][$body]=$prumer}
  if ($okno<$ini{window}){$okno++}
  while ($body+$okno > $bodu[$i]-2){$okno--}
}



}





open(VYSTUP,">$ini{prefix}"."$poradi[$i]_lumin"."$ini{suffix}") or die;

for ($body=10;$body<$bodu[$i]-10;$body++){
printf VYSTUP "$vlnocet[$i][$body]\t%1.6f\n",$orig[$i][$body]-$hodnota[$i][$body-1];
}
close VYSTUP;



open(VYSTUP,">$ini{prefix}"."$poradi[$i]_luminescence"."$ini{suffix}") or die;

printf VYSTUP "$vlnocet[$i][0]\t$hodnota[$i][0]\n";
for ($body=1;$body<$bodu[$i];$body++){
printf VYSTUP "$vlnocet[$i][$body]\t$hodnota[$i][$body-1]\n";
}
close VYSTUP;





}








exit(0)
