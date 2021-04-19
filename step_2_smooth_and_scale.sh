#!/bin/bash

# ====================== STEP 2 AFTER FMRIPREP ========================

## This scipt will do 4 things: 1) Change info in the structural data header file 2) Smooth/blur the functional data to 4mm kernel
## 3) Scale the functional data 4) Take a union of the masks from each functional run.


for sub in sub*; do

cd #PATH TO SUB'S FUNCTIONAL DATA IN NATIVE SPACE

# Change the header file to say that it's in native space rather than tlrc space. This well fix downstream problems w/ AFNI viewer

  for run in 1 2; do
    3drefit -space ORIG ${sub}_task-FN_run-${run}_space-T1w_desc-preproc_bold.nii.gz
    3drefit -space ORIG ${sub}_task-FN_run-${run}_space-T1w_desc-brain_mask.nii.gz
  done


#Smooth the fmriprep output with a 4mm kernel. The 3dBlurToFWHM will only blur things to the 4mm kernel, not apply 4mm of blur to everything.

# All 3 FN func

  for run in 1 2 3; do
    3dBlurToFWHM -FWHM 4.0 -prefix FN_r${run}_blur.nii -mask ${sub}_task-FN_run-${run}_space-T1w_desc-brain_mask.nii.gz \
          ${sub}_task-FN_run-${run}_space-T1w_desc-preproc_bold.nii.gz
  done


#Scale the data to 100

#all 3 FN func

  for run in 1 2 3; do
  	3dTstat -prefix rm._FN_mean_r${run}.nii FN_r${run}_blur.nii
  	3dcalc -a FN_r${run}_blur.nii -b rm._FN_mean_r${run}.nii \
         -c ${sub}_task-FN_run-${run}_space-T1w_desc-brain_mask.nii.gz                            \
         -expr 'c * min(200, a/b*100)*step(a)*step(b)'       \
         -prefix FN_r${run}_scale.nii
  done
rm rm*

# Take a Union of masks created 

3dmask_tool -inputs *FN*mask.nii.gz -union -prefix FN_full_mask.nii

done

echo "Step 2 is complete! Take a look at the output printed to the terminal and check for errors."
echo "If there aren't any, go ahead to move on to step 3: Extract Motion Parameters"
