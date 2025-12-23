%include 'in_out.asm'

SECTION .data
    msg_x db 'x: ', 0
    msg_a db 'a: ', 0
    result db 'f(x)=', 0

SECTION .bss
    x resb 10
    a resb 10

SECTION .text
GLOBAL _start

_start:
    ; Ввод x
    mov eax, msg_x
    call sprint
    mov ecx, x
    mov edx, 10
    call sread

    ; Ввод a
    mov eax, msg_a
    call sprint
    mov ecx, a
    mov edx, 10
    call sread

    ; Преобразование
    mov eax, x
    call atoi
    push eax
    mov eax, a
    call atoi
    mov ebx, eax
    pop eax

    ; Вычисление f(x)
    cmp eax, ebx
    jle .less_equal

    ; x > a: 2(x-a)
    sub eax, ebx
    mov ebx, 2
    mul ebx
    jmp .print

.less_equal:
    ; x <= a: 15
    mov eax, 15

.print:
    push eax
    mov eax, result
    call sprint
    pop eax
    call iprintLF

    call quit
