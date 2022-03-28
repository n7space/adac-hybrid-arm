## This file is part of the adac-hybrid-arm distribution
## Copyright (C) 2020, European Space Agency
##
## This program is free software: you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation, version 3.
##
## This program is distributed in the hope that it will be useful, but
## WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
## General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with this program. If not, see <http://www.gnu.org/licenses/>.

TOP_DIR=$(shell realpath ../../)
BIN_DIR=${TOP_DIR}/build/bin

.PHONY: all clean

all:
	mkdir -p ${BIN_DIR}
	cp -f arm-elf-adabind ${BIN_DIR}
	cp -f arm-elf-adac ${BIN_DIR}
	chmod +x ${BIN_DIR}/arm-elf-adabind
	chmod +x ${BIN_DIR}/arm-elf-adac

clean:
	rm -f ${BIN_DIR}/arm-elf-adabind
	rm -f ${BIN_DIR}/arm-elf-adac
