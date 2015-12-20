#!/bin/bash
#
# Author: Mark Gottscho
# mgottscho@ucla.edu

################## DIRECTORY VARIABLES: MODIFY ACCORDINGLY #######
GEM5_DIR=/u/home/m/mgottsch/project-puneet/eccgrp-gem5-stable-50ff05095970	# Install location of gem5
GEM5_CONFIG_SUBSCRIPT=$PWD/subscripts/gem5-config-subscript-no-caches.sh			# Path to the gem5 configuration shell script
##################################################################

ARGC=$# # Get number of arguments excluding arg0 (the script itself). Check for help message condition.
if [[ "$ARGC" != 3 ]]; then # Bad number of arguments. 
	echo "Author: Mark Gottscho"
	echo "mgottscho@ucla.edu"
	echo ""
	echo "This script runs a single gem5 simulation of a program."
	echo ""
	echo "USAGE: run_gem5.sh <ISA> <PROGRAM> <OUTPUT_DIR>"
	echo "EXAMPLE: ./run_gem5.sh X86 dhrystone m5out/dhrystone"
	echo ""
	echo "A single --help help or -h argument will bring this message back."
	exit
fi

# Get command line input. We will need to check these.
PROGRAM=$1						# Program binary to run
ISA=$2                          # Instruction set to simulate.
OUTPUT_DIR=$3					# Directory to place run output. Make sure this exists!

# Check OUTPUT_DIR existence
if [[ !(-d "$OUTPUT_DIR") ]]; then
	echo "Output directory $OUTPUT_DIR does not exist! Creating it."
	mkdir -p $OUTPUT_DIR
fi

SCRIPT_OUT=$OUTPUT_DIR/runscript.log															# File log for this script's stdout henceforth

################## REPORT SCRIPT CONFIGURATION ###################

echo "Command line:"								| tee $SCRIPT_OUT
echo "$0 $*"										| tee -a $SCRIPT_OUT
echo "================= Hardcoded directories ==================" | tee -a $SCRIPT_OUT
echo "GEM5_DIR:                                     $GEM5_DIR" | tee -a $SCRIPT_OUT
echo "==================== Script inputs =======================" | tee -a $SCRIPT_OUT
echo "PROGRAM:                                      $PROGRAM" | tee -a $SCRIPT_OUT
echo "OUTPUT_DIR:                                   $OUTPUT_DIR" | tee -a $SCRIPT_OUT
echo "==========================================================" | tee -a $SCRIPT_OUT
##################################################################


#################### LAUNCH GEM5 SIMULATION ######################
echo "" | tee -a $SCRIPT_OUT
echo "" | tee -a $SCRIPT_OUT
echo "--------- Here goes nothing! Starting gem5! ------------" | tee -a $SCRIPT_OUT
echo "" | tee -a $SCRIPT_OUT
echo "" | tee -a $SCRIPT_OUT

# Actually launch gem5. We trust the subscript completely that you write. Please don't do something silly.
source $GEM5_CONFIG_SUBSCRIPT | tee -a $SCRIPT_OUT
