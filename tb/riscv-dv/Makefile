.PHONY: all clean

all:
	PYTHONPATH=${RISCV_DV}/pygen:$PYTHONPATH python ${RISCV_DV}/run.py --custom_target ../riscv-dv-cfg/ --target rv32i --seed 42 --iterations 1 --isa rv32i_zicsr --simulator pyflow -v

clean:
	rm -rf out*/
