NAME=mosfet

all: sim

magic:
	# for rcfile to work PDK_ROOT must be set correctly
	magic -rcfile $(PDK_ROOT)/sky130A/libs.tech/magic/sky130A.magicrc $(NAME).mag

mosfet.spice: $(NAME).mag
	magic -noconsole -dnull extract.tcl mosfet

sim: $(NAME).spice
	# run the simulation
	ngspice simulation.spice


check: $(NAME).spice simulation.spice
	ngspice ci.spice
	python3 check.py check.txt

clean:
	rm -f $(NAME).spice $(NAME).ext

phony: clean
