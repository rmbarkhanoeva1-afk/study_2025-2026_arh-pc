%include 'in_out.asm'

SECTION .data
    msg_result db 'Наименьшее число: ', 0
    msg_test1  db 'Тест 1: a=54, b=62, c=87', 0
    msg_test2  db 'Тест 2: разные комбинации', 0
    
    a dd 54
    b dd 62
    c dd 87

SECTION .bss
    min resd 1    ; 4 байта для числа

SECTION .text
GLOBAL _start

_start:
    ; Тест 1: a=54, b=62, c=87
    mov eax, msg_test1
    call sprintLF
    
    ; Находим минимум из a, b, c
    mov eax, [a]        ; eax = a
    mov [min], eax      ; min = a
    
    ; Сравниваем min и b
    cmp eax, [b]
    jle .compare_c      ; если a <= b, сравниваем с c
    mov eax, [b]        ; иначе min = b
    mov [min], eax

.compare_c:
    mov eax, [min]      ; текущий минимум
    cmp eax, [c]
    jle .print_result1  ; если min <= c, оставляем
    mov eax, [c]        ; иначе min = c
    mov [min], eax

.print_result1:
    mov eax, msg_result
    call sprint
    mov eax, [min]
    call iprintLF

    call quit
