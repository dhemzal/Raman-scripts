


CUMMULATION

  perl cummulation.pl -v -i<inifile> <output> <file1>,..,<fileN> <weigh1>,..,<weighN>

Accumulates <files> into an <output> with given <weighs>. Since there is no sense in accumulating unequal spectral points, cummulation.pl does not check and works blindly point by point.

Since write to <output> takes place only after all <files> are read, construction

  perl cummulation.pl <output> <output>,<file1>,..,<fileN> <weigh0>,<weigh1>,..<weighN>

will work allowing for incremental addition of many files (which is more preferable than to construct extremely long command line). In this case (ie when <output> coincides with first of the <files>) <output> is checked for existence, and if not found, it is skipped.

Optional switches: -v (verbose), -i (inifile, without .ini suffix)




Examples of use

Simple accumulation of data:
  perl cummulation.pl Si_15s Si_10s,Si_5s 1.0,1.0

Background subtraction:
  perl cummulation.pl analyte analyte_in_capillary,capillary 1.0,-1.0
(for automatic fine-tuning of the background scale see advanced/normalise.pl)


Bash addition:
  for partial in [files]; do perl cummulation.pl result result,partial 1.0,1.0; done




