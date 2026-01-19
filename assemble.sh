#!/bin/bash

# Assemble the kernel entry with NASM (not GAS)
nasm -f elf32 kernel_entry.asm -o kernel_entry.o

# Compile the C kernel
i686-elf-gcc -m32 -c kernel.c -o kernel.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra

# Link the kernel
i686-elf-ld -m elf_i386 -T linker.ld kernel_entry.o kernel.o -o kernel.bin

# Create ISO directory
mkdir -p isofiles/boot/grub
cp kernel.bin isofiles/boot/kernel.bin

# Create grub.cfg
cat > isofiles/boot/grub/grub.cfg <<EOF
set timeout=5
set default=0

menuentry "bootkit" {
    multiboot /boot/kernel.bin
    boot
}
EOF

# Make bootable ISO
grub-mkrescue -o hello.iso isofiles

# Run in QEMU
qemu-system-i386 -cdrom hello.iso
