#include <Fpu/Fpu.h>

void initFpu() {
    Fpu fpu;
    Fpu_init(&fpu);
    Fpu_startup(&fpu);
}
