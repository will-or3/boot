; bootloader.asm
[ORG 0x7C00]       ; BIOS loads MBR here

start:
    ; Print "HELLO OS"
    mov si, msg       ; load address of string
.print_char:
    lodsb             ; load byte from [SI] into AL
    cmp al, 0
    je .done
    mov ah, 0x0E      ; teletype output
    mov bh, 0x00      ; page 0
    mov bl, 0x07      ; text color
    int 0x10          ; BIOS video interrupt
    jmp .print_char

.done:
    cli               ; disable interrupts
    hlt               ; halt CPU

msg db 'Hello world',0

; Fill to 510 bytes
times 510-($-$$) db 0
dw 0xAA55           ; boot signature