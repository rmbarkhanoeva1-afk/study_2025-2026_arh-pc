%include 'in_out.asm'

SECTION .data
msg db 'Введите строку: ', 0h

SECTION .bss
buf resb 80

SECTION .text
GLOBAL _start

_start:
    mov eax, msg
    call sprint

    mov ecx, buf
    mov edx, 80
    call sread

    call quit
