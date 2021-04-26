#!/bin/bash


## Script that sets up the necessary directory structure for fMRI processing

## All directories will be placed in home dir

cd ~

mkdir -p research_bin/BIDS/derivatives/fmriprep

mkdir -p research_bin/copied

# create code dir and pull code down from github repo

cd research_bin/code; git clone https://github.com/danielasay/McDonald-Lab-fMRI-Pipeline

cd ~/research_bin/BIDS; touch subjList.txt

### COPY DATA FROM FMRIPREP INTO fmriprep dir. The directory with the data should be called sub-[subname]. Uncomment following line 
## when fmriprep data has been copied

# cd sub

# In addition to the func, anat, log and figures dirs that are already there, create the following dirs

mkdir -p afni_out regressor_files/FN regressor_files/VPA stimuli/FN stimuli/ VPA native_func native_afni_out


echo "The regressor_files directory is for the motion files from fMRIPrep. The stimuli directory is for the timing files. The afni_out and native_afni_out dirs are for the output from afni 3Ddeconvolve. native_func is for functional data output into native space from fmriprep." > README.txt




