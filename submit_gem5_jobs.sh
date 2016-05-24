#!/bin/bash
#
# Author: Mark Gottscho
# mgottscho@ucla.edu

ARGC=$# # Get number of arguments excluding arg0 (the script itself). Check for help message condition.
if [[ "$ARGC" != 0 ]]; then # Bad number of arguments. 
	echo "Author: Mark Gottscho"
	echo "mgottscho@ucla.edu"
	echo ""
	echo "USAGE: ./submit_gem5_jobs.sh"
	exit
fi

########################## FEEL FREE TO CHANGE THESE OPTIONS ##################################
ISA=ALPHA    # Set the target ISA for gem5. benchmarks must be compiled for this as well
#SPEC_BENCHMARKS="perlbench bzip2 gcc bwaves zeusmp gromacs leslie3d namd gobmk povray sjeng GemsFDTD h264ref lbm astar sphinx3"		# String of SPEC CPU2006 benchmark names to run, delimited by spaces.
SPEC_BENCHMARKS="perlbench bzip2 mcf povray h264ref"		# String of SPEC CPU2006 benchmark names to run, delimited by spaces.
#BENCHMARKS="dhrystone"
GEM5_CONFIG_SUBSCRIPT_SPEC=$PWD/subscripts/gem5-config-subscript_speccpu2006-no-caches.sh			# Full path to the gem5 config bash subscript


ROOT_OUTPUT_DIR=~/project/m5out												# Full path to the root output directory for all simulations

# qsub options used:
# -V: export environment variables from this calling script to each job
# -N: name the job. I made these so that each job will be uniquely identified by its benchmark running as well as the output file string ID
# -l: resource allocation flags for maximum time requested as well as maximum memory requested.
# -M: cluster username(s) to email with updates on job status
# -m: mailing rules for job status. b = begin, e = end, a = abort
MAX_TIME_PER_RUN=23:00:00 	# Maximum time of each script that will be invoked, HH:MM:SS. If this is exceeded, job will be killed.
MAX_MEM_PER_RUN=4096M 		# Maximum memory needed per script that will be invoked. If this is exceeded, job will be killed.
MAILING_LIST=mgottsch 		# List of users to email with status updates, separated by commas
###############################################################################################

# Make sure necessary directories exist
mkdir $ROOT_OUTPUT_DIR

# Submit all the SPEC CPU2006 benchmarks
echo "Submitting gem5 jobs for SPEC CPU2006 benchmarks..."
echo ""
for SPEC_BENCHMARK in $SPEC_BENCHMARKS; do
	echo "$SPEC_BENCHMARK..."
	SPEC_BENCHMARK_OUTPUT_DIR=$ROOT_OUTPUT_DIR/$SPEC_BENCHMARK
	mkdir $SPEC_BENCHMARK_OUTPUT_DIR
	
	JOB_NAME="gem5-SPECCPU2006-$SPEC_BENCHMARK"
	SIM_OUTPUT_DIR=$SPEC_BENCHMARK_OUTPUT_DIR
	mkdir $SIM_OUTPUT_DIR

	qsub -V -N $JOB_NAME -l h_rt=$MAX_TIME_PER_RUN,h_data=$MAX_MEM_PER_RUN -M $MAILING_LIST ./run_gem5_speccpu2006_benchmark.sh $ISA $SPEC_BENCHMARK $GEM5_CONFIG_SUBSCRIPT_SPEC $SIM_OUTPUT_DIR
done

# Submit all the generic benchmarks
#echo "Submitting gem5 jobs for misc. benchmarks..."
#echo ""
#for BENCHMARK in $BENCHMARKS; do
#	echo "$BENCHMARK..."
#	BENCHMARK_OUTPUT_DIR=$ROOT_OUTPUT_DIR/$BENCHMARK
#	mkdir $BENCHMARK_OUTPUT_DIR
#	
#	JOB_NAME="gem5-$BENCHMARK"
#	SIM_OUTPUT_DIR=$BENCHMARK_OUTPUT_DIR
#	mkdir $SIM_OUTPUT_DIR
#
#   qsub -V -N $JOB_NAME -l h_rt=$MAX_TIME_PER_RUN,h_data=$MAX_MEM_PER_RUN -M $MAILING_LIST ./run_gem5.sh $ISA $BENCHMARK $SIM_OUTPUT_DIR
#done


echo "Done submitting gem5 jobs."
echo "Use qstat to track job status and qdel to kill jobs. Job output can be found in your home directory."
