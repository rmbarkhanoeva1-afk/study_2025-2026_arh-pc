%include 'in_out.asm'  ; Подключаем библиотеку с функциями

SECTION .data
    div_msg db 'Результат: ', 0
    rem_msg db 'Остаток от деления: ', 0

SECTION .text
GLOBAL _start

_start:
    ; ---- Вычисление выражения
    mov eax, 1        ; EAX=1
    mov ebx, 3        ; EBX=3
    mul ebx           ; EAX=EAX*EBX
    add eax, 3        ; EAX=EAX+3
    xor edx, edx      ; обнуляем EDX для корректной работы div
    mov ebx, 3        ; EBX=3
    div ebx           ; EAX=EAX/3, EDX=остаток от деления
    mov edi, eax      ; запись результата вычисления в 'edi'
    ; ----

    mov eax, div_msg  ; вызов подпрограммы печати
    call sprint       ; сообщения 'Результат: '
    mov eax, edi      ; вызов подпрограммы печати значения
    call iprintLF     ; из 'edi' в виде символов
    mov eax, rem_msg  ; вызов подпрограммы печати
    call sprint       ; сообщения 'Остаток от деления: '
    mov eax, edx      ; вызов подпрограммы печати значения
    call iprintLF     ; из 'edx' (остаток) в виде символов

    call quit         ; вызов подпрограммы завершения
