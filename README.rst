Air Defense
===========

This is an incomplete game, a port of Sabotage that I started work on back
in 1984 or 1985.  I was able to rescue the source off of one of my old 5.25"
floppy disks, and found that I had used a pretty common source code control
system of the day: including the version number of the game in the filename.

I found the files GAME, then GAME1 through GAME11.  Then there were some versions missing but the versions resumed in GAME18 through GAME21.

The source code was in Mac/65 tokenized format, which was described in an
ANALOG magazine that I can't find the reference to at the moment, but was
also coded up into a `C program that can translate Mac/65 tokenized files
into plain text files <http://atariage.com/forums/blog/293/entry-6765-demac65-
detokenize-mac65- files/ >`_ by AtariAge user ivop.

I used this program to convert the code to text, added the changes one-by-
one to the file game.s, and committed each to this git repository.

I found the program `ATasm <http://atari.miribilist.com/atasm/>`_, a cross
compiler for Mac/65 code, and was able to test the code.  I found that
versions 19 through 21 were crashy and/or didn't work, so I put those in a
separate branch called broken_dev.

The last version, 18, is the basis of the master branch, which includes the
base cannon, firing, collisions, enemy planes, explosions, parachuting boxes,
randomly generated terrain, and a score.

There would be lots of stuff to do to make this a complete game and I'm not
sure I'll ever do it, but at least it's here.
