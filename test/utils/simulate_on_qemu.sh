#!/bin/sh
qemu-system-arm -cpu cortex-m7 -machine netduinoplus2 -nographic -S -gdb tcp::1234 -kernel $1