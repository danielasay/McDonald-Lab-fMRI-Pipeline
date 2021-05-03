
########## Step 5 After fmriprep ##################

# UPDATE FOR LOOP WITH SUBJECT OR LIST OF SUBJECTS

# THERE SHOULD BE THE SAME NUMBER OF MOTION FIES AS FUNCTIONAL RUNS. EDIT ACCORDINGLY

subj=""

for sub in ${subj}; do

regress_dir=~/fmri_processing/afni/${sub}/regressor_files
func_dir=~/fmri_processing/afni/${sub}/func

cd ${regress_dir}

####### Convert the csv files into text files for 3dDeconvolve

	for task in FN; do
		for i in 1 2; do
			awk '{print $1,$2,$3,$4,$5,$6}' ${regress_dir}/${task}/${task}_run_${i}.csv > ${task}_run_${i}_motion.txt
			tail -n +2 "${task}_run_${i}_motion.txt" > "${task}_run_${i}_motion.tmp.txt" && mv "${task}_run_${i}_motion.tmp.txt" "${task}_run_${i}_motion.txt" 
			mv "${task}_run_${i}_motion.txt" ${func_dir}
			cat ${func_dir}/${task}_run_1_motion.txt ${func_dir}/${task}_run_2_motion.txt > ${func_dir}/${task}_motion.txt
		done
	done

done



