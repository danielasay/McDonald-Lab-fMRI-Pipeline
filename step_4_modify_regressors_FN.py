#### Python Script that appends contents of one text file to another for FN task


######### Step 4 After FMRIPREP ###########

### UPDATE SUBJECT VARIABLE


subject = "sub-"


import pandas as pd

# Run 1

tsv_file=f'{subject}_task-FN_run-1_desc-confounds_timeseries.tsv'
csv_table=pd.read_table(tsv_file, sep='\t')
csv_table.to_csv(f'{subject}-FN_run-1_timeseries.csv', index=False)


col_list = ["trans_x", "trans_y", "trans_z", "rot_x", "rot_y", "rot_z"]

df = pd.read_csv(f"{subject}-FN_run-1_timeseries.csv", usecols=col_list)

df.to_csv (r'FN_run_1.csv', index = False, header=True)

# Run 2

tsv_file=f'{subject}_task-FN_run-2_desc-confounds_timeseries.tsv'
csv_table=pd.read_table(tsv_file, sep='\t')
csv_table.to_csv(f'{subject}-FN_run-2_timeseries.csv', index=False)


col_list = ["trans_x", "trans_y", "trans_z", "rot_x", "rot_y", "rot_z"]

df = pd.read_csv(f"{subject}-FN_run-2_timeseries.csv", usecols=col_list)

df.to_csv (r'FN_run_2.csv', index = False, header=True)



print("Great job! Now run the csv_to_text.sh script if you have run the python program for each task.")

print("If not, go into the VPA directory and run that python script using this command:")

print("python modify_regressors_VPA.py")





