SECTION .data
msg db 'Введите строку: ', 10
msg_len equ $ - msg

SECTION .bss
buf resb 80

SECTION .text
GLOBAL _start

_start:
    ; вывод приглашения
    mov eax, 4          ; sys_write
    mov ebx, 1          ; stdout
    mov ecx, msg
    mov edx, msg_len
    int 80h

    ; ввод строки
    mov eax, 3          ; sys_read
    mov ebx, 0          ; stdin
    mov ecx, buf
    mov edx, 80
    int 80h

    ; вывод введённой строки
    mov eax, 4
    mov ebx, 1
    mov ecx, buf
    mov edx, 80
    int 80h

    ; выход
    mov eax, 1
    mov ebx, 0
    int 80h
