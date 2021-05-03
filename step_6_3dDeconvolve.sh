#!/bin/bash

# 3dDeconvolve script that creates GLM. This was written to analyze block design data. 29.9 seconds is the length of each block
# The baseline comparison (arrow task in this case) is implicit in the model since it is not specified. 

sub="sub-pilot02" 

func_dir=~/fmri_processing/afni/${sub}/func
stim_dir=~/fmri_processing/afni/${sub}/stimuli

cd $func_dir

#3dDeconvolve script to create GLM for FN data

3dDeconvolve -input FN_r?_scale.nii                            \
    -mask FN_full_mask.nii						     \
    -polort A                                                                \
    -num_stimts 9                                                           \
    -stim_times 1 ${stim_dir}/FN/FN_novel.1D 'BLOCK(29.9, 1)'              \
    -stim_label 1 Novel                                                 \
    -stim_times 2 ${stim_dir}/FN/FN_repeated.1D 'BLOCK(29.9, 1)'                \
    -stim_label 2 Repeated                                                 \
    -stim_times 3 ${stim_dir}/FN/FN_arrow.1D 'BLOCK(13, 1)'                  \
    -stim_label 3 Baseline                                                  \
    -stim_file 4 FN_motion.txt'[0]' -stim_base 4 -stim_label 4 transverse_x   \
    -stim_file 5 FN_motion.txt'[1]' -stim_base 5 -stim_label 5 transverse_y  \
    -stim_file 6 FN_motion.txt'[2]' -stim_base 6 -stim_label 6 transverse_z   \
    -stim_file 7 FN_motion.txt'[3]' -stim_base 7 -stim_label 7 rot_x    \
    -stim_file 8 FN_motion.txt'[4]' -stim_base 8 -stim_label 8 rot_y     \
    -stim_file 9 FN_motion.txt'[5]' -stim_base 9 -stim_label 9 rot_z    \
    -jobs 3                                                      \
    -num_glt 6                                                  \
    -gltsym 'SYM: +Novel +Repeated'                              \
    -glt_label 1 Everything                                      \
    -gltsym 'SYM: +Novel -Repeated'                             \
    -glt_label 2 Novel-Repeated                             \
    -gltsym 'SYM: +Novel'                               \
    -glt_label 3 Novel                                  \
    -gltsym 'SYM: +Repeated'                                \
    -glt_label 4 Repeated                               \
    -gltsym 'SYM: +Novel -Baseline'                     \
    -glt_label 5 Novel-Baseline                         \
    -gltsym 'SYM: +Repeated -Baseline'                 \
    -glt_label 6 Repeated-Baseline                      \
    -fout -tout -x1D X.FN.xmat.1D -xjpeg X.FN.${sub}-native.jpg     \
    -x1D_uncensored X.nocensor.xmat.${sub}-native.1D                 \
    -fitts fitts.FN.${sub}-native                                    \
    -errts errts.FN.${sub}-native                                     \
    -bucket stats.FN.${sub}-native



cp -v *.FN.${sub}* ../native_afni_out

