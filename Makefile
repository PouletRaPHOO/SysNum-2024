##
# Netlist
#
# @file
# @version 1.0

main:
	ocamlbuild netlist/scheduler_test.byte
	ocamlbuild netlist/netlist_simulator.byte

schedule :
	ocamlbuild netlist/scheduler_test.byte

netlist_:
	rm test.net
	python3 carotte.py/carotte.py test.py > test.net

exec:
	./netlist_simulator.byte test.net
# end
