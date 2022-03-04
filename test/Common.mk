TOP_DIR=$(realpath ../../)
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

ADAC=${TOP_DIR}/src/arm-elf-adac/arm-elf-adac

GNAT_LIB_DIR?=${TOP_DIR}/src/gnat-runtime/build

LIBS= -lc -lgnatcm7
