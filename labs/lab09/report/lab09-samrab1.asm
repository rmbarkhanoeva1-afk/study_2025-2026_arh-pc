%include "in_out.asm"

SECTION .data
    formula db 'Функция: f(x)=4x+3', 0
    result  db 'Результат: ', 0

SECTION .text
global _start

_start:
    pop ecx            ; количество аргументов
    pop edx            ; имя программы
    dec ecx            ; без имени программы

    mov eax, formula
    call sprintLF

    mov esi, 0         ; сумма результатов

    cmp ecx, 0
    jz print_result

sum_loop:
    pop eax            ; аргумент x
    call atoi          ; eax = x

    call _func         ; eax = f(x)

    add esi, eax
    loop sum_loop

print_result:
    mov eax, result
    call sprint
    mov eax, esi
    call iprintLF
    call quit

;--------------------------------
; Подпрограмма вычисления f(x)
; f(x) = 4x + 3
;--------------------------------
_func:
    mov ebx, 4
    mul ebx            ; eax = 4x
    add eax, 3         ; eax = 4x + 3
    ret
