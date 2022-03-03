NAME=ads

TOP_DIR=$(realpath ../../)
OUT_DIR=${TOP_DIR}/build/test/${NAME}
UTILS_SRC_DIR=${TOP_DIR}/test/utils
BSP_DIR=${TOP_DIR}/test/bsp/

COMMON_CFLAGS = \
	-ffunction-sections \
	-fdata-sections \
	-march=armv7e-m \
	-mcpu=cortex-m7 \
	-mfloat-abi=hard \
    -mfpu=fpv5-d16 \
    -mlittle-endian \
    -mthumb 

ADAC=${TOP_DIR}/src/arm-elf-adac/arm-elf-adac

GNAT_LIB_DIR?=${TOP_DIR}/src/gnat-runtime/build


LIBS= -lc -lgnatcm7

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
	-Wl,-Map=main.map \
	-T../ld/stm32f405.ld 

SRC= \
	main.c \
	bodylessmodule.ads

OBJ=$(SRC:%.adb=${OUT_DIR}/%.o) ${OUT_DIR}/utils.o ${OUT_DIR}/reporting.o ${OUT_DIR}/nvic.o ${OUT_DIR}/startup.o

.PHONY: all clean

all: ${OUT_DIR}/${NAME}.elf

${OUT_DIR}/${NAME}.elf: ${OUT_DIR} ${OBJ}
	${ADAC} ${CFLAGS} ${LFLAGS} -o $@ ${OBJ} ${LIBS}

${OUT_DIR}:
	mkdir -p $@

${OUT_DIR}/%.o: %.adb
	${ADAC} ${CFLAGS} -o $@ -c $<

${OUT_DIR}/utils.o: ${UTILS_SRC_DIR}/utils.adb ${UTILS_SRC_DIR}/utils.ads
	${ADAC} ${CFLAGS} -o $@ -c $<

${OUT_DIR}/reporting.o: ${UTILS_SRC_DIR}/reporting.adb ${UTILS_SRC_DIR}/reporting.ads
	${ADAC} ${CFLAGS} -o $@ -c $<

${OUT_DIR}/nvic.o: ${BSP_DIR}/src/Nvic/Nvic.c
	${ADAC} ${CFLAGS} -o $@ -c $<

${OUT_DIR}/startup.o: ../startup/bare.c
	${ADAC} ${CFLAGS} -o $@ -c $<


clean:
	rm -r -f ${OUT_DIR}
