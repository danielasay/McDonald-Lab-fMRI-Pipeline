#!/bin/bash

## Script that sets up the necessary directory structure for fMRI processing on CMIG server

## Pass the subject's ID when running this script (e.g.bash setup.sh sub-pilot01)

if [ $# -eq 0 ]
  then
    echo "No arguments supplied..."
    echo "Please supply subject ID."
    echo "Example: bash setup.sh sub-pilot01"
    exit
else
	echo "Subject ID is" $1
	echo "Runnning script..."
	echo "Setting up file structure..."
fi

#: <<'END'

sub=$1
workdir=/home/mmilmcd2/fmri_processing/afni
subjdir=/home/mmilmcd2/fmri_processing/afni/$sub
fmriprepdir=/home/mmilmcd2/fmri_processing/fmriprep/derivatives/fmriprep/$sub

# create code dir and pull code down from github repo

mkdir -p $subjdir/code

cd $subjdir/code; git clone https://github.com/danielasay/McDonald-Lab-fMRI-Pipeline; 

cd McDonald-Lab-fMRI-Pipeline; cp * ..; cd ..; mv McDonald-Lab-fMRI-Pipeline backup

cd $subjdir

mkdir -p afni_out regressor_files/FN regressor_files/VPA stimuli/FN stimuli/VPA native_func native_afni_out

echo $sub >> $workdir/subjList.txt

### COPY DATA FROM FMRIPREP INTO subject's dir.

cd $fmriprepdir
cp -r * $subjdir

# In addition to the func, anat, log and figures dirs that are already there, create the following dirs

echo "Done!"
echo "The regressor_files directory is for the motion files from fMRIPrep. The stimuli directory is for the timing files. The afni_out and native_afni_out dirs are for the output from afni 3Ddeconvolve. native_func is for functional data output into native space from fmriprep." > README.txt




