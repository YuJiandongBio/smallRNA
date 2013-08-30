#!/bin/bash

#echo "please enter your output dir (full path)"
dir="/home/wangw1/nearline/Za1"
#read dir
#if test ! -d $dir
#then
#mkdir $dir
#fi

#1.extract the inserts
#echo "Please enter the input directory (full path)"
#read inputdir
#if test ! -d $inputdir
#then 
#echo "Error: $inputdir does not exist!!"
#exit 1
#fi
inputdir="$dir"
echo Please enter the raw reads file
read inserts
if test ! -e "$inputdir/$inserts"
then
echo "Error: $inputdir/$inserts does not exist!!"
exit 1
fi


#2.map to the genome 
echo "Map to the genome"
echo "Indexes name"
read indexes
echo "Mismatch? (enter 0 or 1)"
read mm

echo "Name your sample"
read sample_name

#echo "Your email address (when it's done, it would automatically send an email to your account)"
#read EMAIL
EMAIL="weiwanghhq\@gmail\.com"
#inputdir2=${inputdir##*/}
echo "#!/bin/sh
#$ -V
#$ -pe single 8
#$ -o \$HOME/sge_jobs_output/sge_job.\$JOB_ID.out -j y
#$ -M zzpipeline.admin@gmail.com
#$ -S /bin/bash
#$ -m e 
      
export PIPELINEDIR=/home/lees2/pipeline:/home/xuj1/pipeline_mmu:/home/xuj1/pipeline:/home/wangw1/PIPELINE
export OUTPUTDIR=$dir
export PATH=\$PATH:\$PIPELINEDIR
export PATH=/share/bin/R/bin:/share/bin/R/share:\$PATH
export LD_LIBRARY_PATH=/share/bin/R/lib64:\$LD_LIBRARY_PATH
mkdir \$HOME/scratch/jobid_\$JOB_ID
mkdir \$HOME/scratch/jobid_\$JOB_ID/output
ssh hpcc03 \"cp $inputdir/$inserts \$HOME/scratch/jobid_\$JOB_ID/$sample_name\"
/home/wangw1/bowtie-0.12.5/bowtie $indexes -f -v $mm -a --best --strata -p 8 \$HOME/scratch/jobid_\$JOB_ID/$sample_name -t > \$HOME/scratch/jobid_\$JOB_ID/output/$inserts.bowtie.mm_$mm.$indexes.out

mail -s "Your job_\$JOB_ID has completed" $EMAIL < /home/xuj1/pipeline/common/job_complete_message 

ssh hpcc03 \"cp -r \$HOME/scratch/jobid_\$JOB_ID/output \$OUTPUTDIR/$sample_name\"
">/home/wangw1/sge_scripts/submit_$inserts.sge

qsub /home/wangw1/sge_scripts/submit_$inserts.sge



