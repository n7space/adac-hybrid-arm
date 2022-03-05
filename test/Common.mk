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

TOP_DIR=$(realpath ../../)
UTILS_SRC_DIR=${TOP_DIR}/test/utils
BSP_DIR=${TOP_DIR}/test/bsp

COMMON_CFLAGS = \
	-ffunction-sections \
	-fdata-sections \
	-march=armv7e-m \
	-mcpu=cortex-m7 \
	-mfloat-abi=hard \
    -mfpu=fpv5-d16 \
    -mlittle-endian \
    -mthumb 

CFLAGS= ${COMMON_CFLAGS} \
	-Wall \
	-Wadac,keep_intermediates \
	-Wgnat,-gnatif \
	-Wgnat,-I../../src/gnat-runtime/src \
	-Wgnat,-I../utils \
	-Wgnat,--function-sections \
	-I${BSP_DIR}/src \
	-g

LFLAGS= \
	-L${GNAT_LIB_DIR} \
	-Wl,--gc-sections \
	-eexception_table \
    -specs=nosys.specs \
	-T../ld/stm32f405.ld

ADAC=${TOP_DIR}/src/arm-elf-adac/arm-elf-adac

GNAT_LIB_DIR?=${TOP_DIR}/src/gnat-runtime/build

LIBS= -lc -lgnatcm7
