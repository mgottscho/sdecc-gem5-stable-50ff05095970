#!/bin/bash
#
# Author: Mark Gottscho
# mgottscho@ucla.edu

# Get the arguments.
BENCHMARK=$1		# String identifier for the SPEC CPU2006 benchmark to run

GEM5_CONFIG_SUBSCRIPT=$PWD/subscripts/gem5-config-subscript_speccpu2006-no-caches.sh			# Full path to the gem5 config bash subscript

ROOT_OUTPUT_DIR=$PWD/m5out												# Full path to the root output directory for all simulations

# Make sure necessary directories exist
mkdir $ROOT_OUTPUT_DIR

BENCHMARK_OUTPUT_DIR=$ROOT_OUTPUT_DIR/$BENCHMARK
mkdir $BENCHMARK_OUTPUT_DIR

./run_gem5_x86_speccpu2006_benchmark.sh $BENCHMARK $GEM5_CONFIG_SUBSCRIPT $BENCHMARK_OUTPUT_DIR
