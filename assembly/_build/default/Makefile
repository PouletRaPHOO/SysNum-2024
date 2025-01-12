


all:
	dune build

run:
	rm -f roms/actual_op
	./lovni.exe clock.lv

explain:
	menhir --base /tmp/parser --dump --explain parser.mly
	cat /tmp/parser.conflicts

clean:
	dune clean
