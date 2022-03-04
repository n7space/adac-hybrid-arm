#!/bin/sh

ELF_NAME="$(basename $1)"
LOG_FILE="${ELF_NAME}.log"

echo "Testing $1"

echo "Starting QEMU with the binary"
./simulate_on_qemu.sh $1 &
sleep 1
echo "Executing GDB script logging breakpoint hits"
arm-eabi-gdb -quiet -batch -x execute_test.gdb $1 > ${LOG_FILE}
echo "Killing QEMU"
killall qemu-system-arm
if [[ $(grep < ${LOG_FILE} Success ) = "\$1 = \"Success\"" ]]; then
echo "SUCCESS: Success found in log"
exit 0
else
echo "FAILURE: No Success found in log"
exit 1
fi