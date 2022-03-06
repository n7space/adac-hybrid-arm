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

TOP_DIR?=$(realpath ../../../)

include ../../Common.mk

NAME=managemode

OUT_DIR=${TOP_DIR}/build/test/${NAME}
BINARY_NAME=${OUT_DIR}/${NAME}.elf

SRC= \
	init.c \
	main.adb \
	envstub.adb \
	SDL/code/managemode.adb \
	SDL/wrappers/pus_c.adb \
	SDL/wrappers/taste_basictypes.adb \
	SDL/wrappers/demosat_types.adb

CFLAGS+= \
	-Wgnat,-ISDL/wrappers \
	-Wgnat,-ISDL/code

OBJ= \
	$(SRC:%.adb=${OUT_DIR}/%.o) \
	${OUT_DIR}/utils.o \
	${OUT_DIR}/reporting.o \
	${OUT_DIR}/startup.o \
	${OUT_DIR}/fpu.o

.PHONY: all clean

all: ${BINARY_NAME} test

${BINARY_NAME}: ${OUT_DIR} ${OBJ}
	${ADAC} ${CFLAGS} ${LFLAGS} -o $@ ${OBJ} ${LIBS}

${OUT_DIR}:
	mkdir -p $@
	mkdir -p $@/SDL/code
	mkdir -p $@/SDL/wrappers

${OUT_DIR}/%.o: %.adb
	${ADAC} ${CFLAGS} -o $@ -c $<

${OUT_DIR}/utils.o: ${UTILS_SRC_DIR}/utils.adb ${UTILS_SRC_DIR}/utils.ads
	${ADAC} ${CFLAGS} -o $@ -c $<

${OUT_DIR}/reporting.o: ${UTILS_SRC_DIR}/reporting.adb ${UTILS_SRC_DIR}/reporting.ads
	${ADAC} ${CFLAGS} -o $@ -c $<

${OUT_DIR}/startup.o: ../../startup/bare.c
	${ADAC} ${CFLAGS} -o $@ -c $<

${OUT_DIR}/fpu.o: ${BSP_DIR}/src/Fpu/Fpu.c
	${ADAC} ${CFLAGS} -o $@ -c $<

test: ${BINARY_NAME}
	${UTILS_SRC_DIR}/execute_test.sh ${BINARY_NAME}

clean:
	rm -r -f ${OUT_DIR}

