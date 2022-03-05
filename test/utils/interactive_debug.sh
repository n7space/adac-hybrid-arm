#!/bin/sh

ELF_NAME="$(basename $1)"
ELF_DIR="$(dirname $1)"
LOG_FILE="${ELF_DIR}/${ELF_NAME}.log"
SCRIPT_DIR="$(dirname $0)"

echo "Testing $1"

echo "Starting QEMU with the binary"
${SCRIPT_DIR}/simulate_on_qemu.sh $1 &
sleep 1
echo "Starting debug session, type \"quit\" to exit..."
arm-eabi-gdb -ex "target remote :1234" -ex "layout split" -ex "break main" -ex "c" $1
echo "Killing QEMU"
killall qemu-system-arm
