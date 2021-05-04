#!/bin/bash


# ============================ STEP 3 AFTER FMRIPREP ========================

# This script will take the regressor files that fmriprep outputs and put them into the regress_dir. It will also copy the relevant 
## Python scripts into the regress_dir. The python scripts extract the information we're interested in from the regressor files.

workdir=~/fmri_processing/afni
subj=$( tail -n 1 $workdir/subjlist.txt )

for sub in ${subj}; do

func_dir=~/fmri_processsing/afni/${sub}/func
regress_dir=~/fmri_processsing/afni/${sub}/regressor_files
code_dir=~/fmri_processsing/afni/${sub}/code

cd ${func_dir}


### Copy each regressor file to regressor_file directory. Copy relevant python scripts as well. Sometimes it is a timeseries.tsv file
### and others it's regressors. Not sure why, just be ready to modify the script.

	for task in FN; do
		for run in 1 2; do
			cp ${sub}_task-${task}_run-${run}_desc-confounds_timeseries.tsv ../regressor_files/${task}/
			cp ${code_dir}/step_4_modify_regressors_${task}.py ${regress_dir}/${task}
		done
	done


echo "Now run the Python Scripts for each task. They are found in their respective directories."

cd ${regress_dir}/FN

echo "Run with this command: python modify_regressors_FN.py"

done








