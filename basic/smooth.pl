#!/usr/bin/perl










open(INIT,"smooth.ini") or die;
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
$vlnocet[$bod]=$pole[0];
$hodnota[$i][$bod]=$pole[1];$orig[$i][$bod]=$pole[1];
$bod++;
}
$bodu=$bod;
print "$bod bodu\n";
close VSTUP;
}
print "\n";










for ($i=0;$i<$pocet;$i++){





$odkud=$ini{window};
while ($vlnocet[$odkud-$ini{window}]>$ini{xmax}){$odkud++}
$kam=$bodu-$ini{window}-1;
while ($vlnocet[$kam+$ini{window}]<$ini{xmin}){$kam--}

#print "$vlnocet[$odkud-$ini{window}] $vlnocet[$kam+$ini{window}] \n";


for ($body=$odkud;$body<$kam;$body++){
$prumer=0;
for ($y=0;$y<(2*$ini{window}+1);$y++){$prumer+=$hodnota[$i][$body+$y-$ini{window}];}
$prumer=$prumer/(2*$ini{window}+1);
$hodnota[$i][$body]=$prumer;
}





open(VYSTUP,">$ini{prefix}"."$poradi[$i]_smooth"."$ini{suffix}") or die;

for ($body=$odkud;$body<$kam;$body++){
printf VYSTUP "$vlnocet[$body]\t%1.6f\n",$hodnota[$i][$body+1];
}
close VYSTUP;








}








exit(0)
