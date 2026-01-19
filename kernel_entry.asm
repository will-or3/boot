; 32-bit kernel entry
[bits 32]
[extern kernel_main]

section .multiboot
align 4
dd 0x1BADB002       ; magic number
dd 0x00             ; flags
dd -(0x1BADB002 + 0x00) ; checksum

section .text
global start_kernel
start_kernel:
    cli                 ; disable interrupts
    mov esp, stack_top   ; set up stack
    call kernel_main
    hlt                 ; if kernel returns, halt

section .bss
resb 8192              ; 8 KB stack
stack_top:
