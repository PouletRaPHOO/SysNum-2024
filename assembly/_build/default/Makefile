


all:
	dune build

explain:
	menhir --base /tmp/parser --dump --explain parser.mly
	cat /tmp/parser.conflicts

clean:
	dune clean
