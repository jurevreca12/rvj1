all: lint sim vivado doc


doc:
	cd docs && $(MAKE)

vivado:
	cd impl && $(MAKE) vivado

synth:
	qflow synthesize top.v

lint:
	verilator -I./rtl/inc/ -lint-only -Wall ./rtl/inc/jedro_1_defines.v ./rtl/*.v 

clean:
	rm source/*.ys
	rm source/*.blif
	rm -rf env/

sim:
	$(MAKE) -C sim/ sim 


envinst: 
	virtualenv --python=/usr/bin/python3 env
	source env/bin/activate
	python -m pip install cocotb

envact:
	source env/bin/activate

