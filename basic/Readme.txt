

SPLIT

  perl split.pl -v -i <inifile> <file1>,..,<fileN>

Detaches first column from <files> and saves as many subfiles with the remaining columns to each of <filei> as there are jumps in the values within their first column. 
The newly created subfiles are prefixed, using 00_<file1>, 01_<file1> etc. (ie the actual values from the first column are discarded)

Optional switches: -v (verbose), -i (inifile, without .ini suffix)


Examples of use

Extraction of time resolved measurements (three-column files with repeating block of individual measurements,
the first column is used to mark the individual datasets (eg. by time stamp of particular measurement start):
    perl split.pl  time_measurement

Extraction of mapping measurements (four-column files with repeating block of individual measurements,
the first two columns are used to mark the individual datasets (eg by x-y coordinates of the measured spot):
   perl split.pl  mapping_measurement
   for file in [*_mapping_measurement]; do perl split.pl file;done






CUMMULATION

  perl cummulation.pl -v -i <inifile> <output> <file1>,..,<fileN> <weigh1>,..,<weighN>

Accumulates <files> into an <output> with given <weighs>. Since there is no sense in accumulating unequal spectral points,
cummulation.pl does not check and works blindly point by point.

Since write to <output> takes place only after all <files> are read, construction

  perl cummulation.pl <output> <output>,<file1>,..,<fileN> <weigh0>,<weigh1>,..<weighN>

will work allowing for incremental addition of many files (which is more preferable than to construct extremely long command line).
In this case (ie when <output> coincides with first of the <files>) <output> is checked for existence, and if not found, it is skipped.
In all other cases <output> is created from scratch.

Optional switches: -v (verbose), -i (inifile, without .ini suffix)



Examples of use

Simple accumulation of data:
  perl cummulation.pl spectrum_15s spectrum_10s,spectrum_5s 1.0,1.0

Scaling of a spectrum:
  perl cummulation.pl scaled spectrum 1.45

Background subtraction:
  perl cummulation.pl analyte analyte_in_capillary,capillary 1.0,-1.0
(for automatic fine-tuning of the background scale see advanced/normalise.pl)

Bash addition:
  for partial in [files]; do perl cummulation.pl result result,partial 1.0,1.0; done







SMOOTH

  perl smooth.pl -v -i <inifile> <file1>,..,<fileN>

Moving average smoothing of the spectrum, the (half)length of the window is read from the initial file. Multiple files can be used 
only for spectra with identical sampling. To keep to length of the data, smoothing window is being shortened close the edges of the spetrum.
The smoothed spectra are suffixed as <filei>_smooth.

Optional switches: -v (verbose), -i (inifile, without .ini suffix)



Examples of use

perl smooth.pl spectrum




