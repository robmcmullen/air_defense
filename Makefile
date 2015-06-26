.PHONY: test copy default clean
.SUFFIXES: .s .xex

.s.xex:
	atasm -o$@ $<

default: game.xex

game.xex: game.s

clean:
	$(RM) game.xex
