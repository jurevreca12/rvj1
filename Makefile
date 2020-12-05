all: vivado sim doc


doc:
	cd docs && $(MAKE)

vivado:
	cd impl && $(MAKE) vivado

synth:
	qflow synthesize top.v

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

