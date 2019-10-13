all:


synth:
	qflow synthesize top.v

clean2:
	rm source/*.ys
	rm source/*.blif

sim:
	$(MAKE) -C sim/ sim 
