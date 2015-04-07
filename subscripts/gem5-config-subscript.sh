$GEM5_DIR/build/X86/gem5.opt\
 \
 --outdir=$OUTPUT_DIR\
 \
 $GEM5_DIR/configs/example/my_se.py\
 \
 --cpu-type=detailed\
 --num-cpus=2\
 --sys-clock="2GHz"\
 --cpu-clock="2GHz"\
 --sys-voltage="1V"\
 \
 --caches\
 --cacheline_size="64"\
 \
 --l1d_size="64kB"\
 --l1i_size="64kB"\
 --l1d_assoc=4\
 --l1i_assoc=4\
 \
 --l2cache\
 --num-l2caches=2\
 --l2_size="512kB"\
 --l2_assoc=8\
 \
 --num-l3caches=1\
 --l3_size="4MB"\
 --l3_assoc=16\
 \
 --mem-type=ddr3_1600_x64\
 --mem-channels=1\
 --mem-size="2048MB"\
 \
 --benchmark=$BENCHMARK\
 --benchmark_stdout=$OUTPUT_DIR/$BENCHMARK.out\
 --benchmark_stderr=$OUTPUT_DIR/$BENCHMARK.err\
 \
 --fast-forward=1000000\
 --maxinsts=1000000\
 --at-instruction
