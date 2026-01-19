/* linker.ld */

ENTRY(start_kernel)
OUTPUT_FORMAT(binary)

SECTIONS
{
    . = 1M; /* load at 1MB */

    .multiboot ALIGN(4) :
    {
        *(.multiboot)
    }

    .text ALIGN(4) :
    {
        *(.text)
        *(.rodata)
        *(.data)
    }

    .bss ALIGN(4) :
    {
        *(.bss)
    }
}