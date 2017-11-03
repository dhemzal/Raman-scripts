# Raman-scripts

This repository contains some generic perl scripts that can be used to handle Raman data prior to their visualisation in several directions:
   
   - basic: accumulation/scaling, background subtraction, dataset splitting
   - advanced: smoothing, luminescence treatment, peak picking/fitting, derivative spectra
   - statistic: covariance analysis, spectra decompostion (PCA)
   
 THE REPOSITORY IS YET IN SET-UP PHASE

Motivation is to allow for codified treatment of the spectra by different users and to track the actual version of the scripts.
The repository is used in education.

Intention is to keep things simple; the scripts do not attempt to check user's sanity.

Actually, the only data structure constraint is a tab-separated two-column text file; three-column (time snapshots) and four column (mapping measurements) can be handled too via dataset splitting.

Most of the scripts use a combination of ini-file and command-line parameters/switches construction that allows users to handle the more complex data treatment in an on-the-fly fashion. 
