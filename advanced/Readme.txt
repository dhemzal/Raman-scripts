


LUMINESCENCE

  perl luminescence.pl -v -i <inifile> <file1>,..,<fileN>

Moving average removal of the spectrum background, the (half)length of the averaging window and number of iterations are read from the initial file. Multiple files can be used only for spectra with identical sampling. To keep to length of the data, smoothing window is being shortened close the edges of the spetrum; the noise is recovered.
The spectra background are suffixed as <filei>_luminiscence and, for convenience, the background corrected spectrum is also saved, as <filei>_lumin.

Optional switches: -v (verbose), -i (inifile, without .ini suffix)



Examples of use

perl luminiscence.pl spectrum1,spectrum2




