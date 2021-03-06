$GEM5_DIR/build/$ISA/gem5.fast\
 \
 --outdir=$OUTPUT_DIR\
 \
 $GEM5_DIR/configs/example/my_se.py\
 \
 --cpu-type=timing\
 --num-cpus=1\
 --sys-clock="2GHz"\
 --cpu-clock="2GHz"\
 --sys-voltage="1V"\
 \
 --mem-type=ddr3_1600_x64\
 --mem-channels=1\
 --mem-size="2048MB"\
 \
 --program=$PROGRAM\
 --program_stdout=$OUTPUT_DIR/$PROGRAM.out\
 --program_stderr=$OUTPUT_DIR/$PROGRAM.err\
 \
 --maxinsts=2000000000\
 --fast-forward=2000000000\
 --at-instruction
