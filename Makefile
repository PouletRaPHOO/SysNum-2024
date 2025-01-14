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

test:
	cd netlist
	mkdir test_dos

compil_sim:
	cd netlist; \
	rm -f netlist_simulator.byte; \
	ocamlbuild netlist_simulator.byte

compil_clock:
	./assembly/lovni.exe clock.lv

compil_clock_fast:
	./assembly/lovni.exe clockfast.lv

compil_netlist:
	rm -f main.net
	python3 carotte.py/carotte.py main.py > main.net

run:
	make compil_sim
	make compil_clock
	make compil_netlist
	./netlist/netlist_simulator.byte -ten -sec -clock main.net

runfast:
	make compil_sim
	make compil_clock_fast
	make compil_netlist
	./netlist/netlist_simulator.byte -ten -sec -clock main.net
# end
