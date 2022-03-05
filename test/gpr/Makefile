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

include ../Common.mk

NAME=gpr

OUT_DIR=${TOP_DIR}/build/test/${NAME}
BINARY_NAME=${OUT_DIR}/${NAME}.elf

GPRBUILD=gprbuild


.PHONY: all clean test

all: ${BINARY_NAME} test

# Target specific variable just for gprbuild invocation, as it cannot
# resolve the MSP430 path on its own

${BINARY_NAME}: ${OUT_DIR} GprBuildBasedProject.gpr
	${GPRBUILD} -vh -R GprBuildBasedProject.gpr

${OUT_DIR}:
	mkdir -p $@

test: ${BINARY_NAME}
	${UTILS_SRC_DIR}/execute_test.sh ${BINARY_NAME}

clean:
	rm -r -f ${OUT_DIR}
