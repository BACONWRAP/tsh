# Makefile for the CS:APP Shell Lab

VERSION = 1
DRIVER = ./sdriver.pl
TSH = ./tsh
TSHREF = ./tshref
TSHARGS = "-p"
CC = gcc
CFLAGS = -Wall -O2
FILES = $(TSH) ./myspin ./mysplit ./mystop ./myint

all: $(FILES)

$(TSH): tsh.c
	gcc -Wall -O2 ./tsh.c ./csapp.c -o tsh

##################
# Regression tests
##################

# Run tests using the student's shell program
test01: $(TSH)
	$(DRIVER) -t trace01.txt -s $(TSH) -a $(TSHARGS)
test02: $(TSH)
	$(DRIVER) -t trace02.txt -s $(TSH) -a $(TSHARGS)
test03: $(TSH)
	$(DRIVER) -t trace03.txt -s $(TSH) -a $(TSHARGS)
test04: $(TSH)
	$(DRIVER) -t trace04.txt -s $(TSH) -a $(TSHARGS)
test05: $(TSH)
	$(DRIVER) -t trace05.txt -s $(TSH) -a $(TSHARGS)
test06: $(TSH)
	$(DRIVER) -t trace06.txt -s $(TSH) -a $(TSHARGS)
test07: $(TSH)
	$(DRIVER) -t trace07.txt -s $(TSH) -a $(TSHARGS)
test08: $(TSH)
	$(DRIVER) -t trace08.txt -s $(TSH) -a $(TSHARGS)
test09: $(TSH)
	$(DRIVER) -t trace09.txt -s $(TSH) -a $(TSHARGS)
test10: $(TSH)
	$(DRIVER) -t trace10.txt -s $(TSH) -a $(TSHARGS)
test11: $(TSH)
	$(DRIVER) -t trace11.txt -s $(TSH) -a $(TSHARGS)
test12: $(TSH)
	$(DRIVER) -t trace12.txt -s $(TSH) -a $(TSHARGS)
test13: $(TSH)
	$(DRIVER) -t trace13.txt -s $(TSH) -a $(TSHARGS)
test14: $(TSH)
	$(DRIVER) -t trace14.txt -s $(TSH) -a $(TSHARGS)
test15: $(TSH)
	$(DRIVER) -t trace15.txt -s $(TSH) -a $(TSHARGS)
test16: $(TSH)
	$(DRIVER) -t trace16.txt -s $(TSH) -a $(TSHARGS)

# Run the tests using the reference shell program
rtest01:
	$(DRIVER) -t trace01.txt -s $(TSHREF) -a $(TSHARGS)
rtest02:
	$(DRIVER) -t trace02.txt -s $(TSHREF) -a $(TSHARGS)
rtest03:
	$(DRIVER) -t trace03.txt -s $(TSHREF) -a $(TSHARGS)
rtest04:
	$(DRIVER) -t trace04.txt -s $(TSHREF) -a $(TSHARGS)
rtest05:
	$(DRIVER) -t trace05.txt -s $(TSHREF) -a $(TSHARGS)
rtest06:
	$(DRIVER) -t trace06.txt -s $(TSHREF) -a $(TSHARGS)
rtest07:
	$(DRIVER) -t trace07.txt -s $(TSHREF) -a $(TSHARGS)
rtest08:
	$(DRIVER) -t trace08.txt -s $(TSHREF) -a $(TSHARGS)
rtest09:
	$(DRIVER) -t trace09.txt -s $(TSHREF) -a $(TSHARGS)
rtest10:
	$(DRIVER) -t trace10.txt -s $(TSHREF) -a $(TSHARGS)
rtest11:
	$(DRIVER) -t trace11.txt -s $(TSHREF) -a $(TSHARGS)
rtest12:
	$(DRIVER) -t trace12.txt -s $(TSHREF) -a $(TSHARGS)
rtest13:
	$(DRIVER) -t trace13.txt -s $(TSHREF) -a $(TSHARGS)
rtest14:
	$(DRIVER) -t trace14.txt -s $(TSHREF) -a $(TSHARGS)
rtest15:
	$(DRIVER) -t trace15.txt -s $(TSHREF) -a $(TSHARGS)
rtest16:
	$(DRIVER) -t trace16.txt -s $(TSHREF) -a $(TSHARGS)


# clean up
clean:
	rm -f $(FILES) *.o *~
