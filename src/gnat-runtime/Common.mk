##--------------------------------------------------------------------------##
##                                                                          ##
##                          GNAT RUN-TIME COMPONENTS                        ##
##                                                                          ##
##                  S Y S T E M . G C C _ B U I L T I N S                   ##
##                                                                          ##
##                                 S p e c                                  ##
##                                                                          ##
##                 Copyright (C) 2020, European Space Agency                ##
##                                                                          ##
## GNAT is free software;  you can  redistribute it  and/or modify it under ##
## terms of the  GNU General Public License as published  by the Free Soft- ##
## ware  Foundation;  either version 3,  or (at your option) any later ver- ##
## sion.  GNAT is distributed in the hope that it will be useful, but WITH- ##
## OUT ANY WARRANTY;  without even the  implied warranty of MERCHANTABILITY ##
## or FITNESS FOR A PARTICULAR PURPOSE.                                     ##
##                                                                          ##
## As a special exception under Section 7 of GPL version 3, you are granted ##
## additional permissions described in the GCC Runtime Library Exception,   ##
## version 3.1, as published by the Free Software Foundation.               ##
##                                                                          ##
## You should have received a copy of the GNU General Public License and    ##
## a copy of the GCC Runtime Library Exception along with this program;     ##
## see the files COPYING3 and COPYING.RUNTIME respectively.  If not, see    ##
## <http://www.gnu.org/licenses/>.                                          ##
##                                                                          ##
## GNAT was originally developed  by the GNAT team at  New York University. ##
## Extensive contributions were provided by Ada Core Technologies Inc.      ##
##                                                                          ##
##--------------------------------------------------------------------------##

ADA_CC=arm-eabi-gcc
ADA_CFLAGS=-gnatpg \
	-gnatwns \
	${COMMON_CFLAGS}

ARM_CC=arm-none-eabi-gcc
ARM_AR=arm-none-eabi-ar

ARM_CFLAGS=${COMMON_CFLAGS}
	

.PHONY: all clean

all: ${GNAT_CRT_ARM}

SRC= $(wildcard *.adb)
OBJ=$(SRC:%.adb=%.o)

C_SRC=$(wildcard *.c)
C_OBJ=$(C_SRC:%.c=%.o)

%.s: %.adb
	$(ADA_CC) $(ADA_CFLAGS) -S $<

%.o: %.s
	$(ARM_CC) $(ARM_CFLAGS) -c $< -o $@

%.o: %.c
	$(ARM_CC) $(ARM_CFLAGS) -c $< -o $@

${GNAT_CRT_ARM}: ${OBJ} ${C_OBJ}
	${AR} cr $@ ${OBJ} ${C_OBJ}

clean:
	rm -f *.o
	rm -f *.ali
	rm -f ${GNAT_CRT_ARM}