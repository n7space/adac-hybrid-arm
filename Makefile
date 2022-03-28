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

SRC_DIR=src
BUILD_DIR=build
INSTALL_DIR=/opt/arm-elf-adac
SUDO=sudo

.PHONY: all test adac rt clean install

all: adac rt test

adac:
	( ${MAKE} -C ${SRC_DIR}/arm-elf-adac) || exit $$?;

rt:
	( ${MAKE} -C ${SRC_DIR}/gnat-runtime) || exit $$?;

test:
	( ${MAKE} -C test ) || exit $$?; 

clean:
	( ${MAKE} -C test clean ) || exit $$?;
	( ${MAKE} -C ${SRC_DIR}/arm-elf-adac clean ) || exit $$?;
	( ${MAKE} -C ${SRC_DIR}/gnat-runtime clean ) || exit $$?;

install: adac rt
	${SUDO} mkdir -p ${INSTALL_DIR}
	${SUDO} cp -f -r ${BUILD_DIR}/bin ${INSTALL_DIR}
	${SUDO} cp -f -r ${BUILD_DIR}/include ${INSTALL_DIR}
	${SUDO} cp -f -r ${BUILD_DIR}/lib ${INSTALL_DIR}
