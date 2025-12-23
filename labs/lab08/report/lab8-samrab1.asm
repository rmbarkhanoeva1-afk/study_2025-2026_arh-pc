%include 'in_out.asm'

SECTION .data
    formula db 'Функция: f(x)=4x+3', 0
    result  db 'Результат: ', 0

SECTION .text
global _start

_start:
    pop ecx        ; количество аргументов
    pop edx        ; имя программы
    dec ecx        ; без имени программы

    ; Вывод формулы
    mov eax, formula
    call sprintLF

    ; Инициализация суммы
    mov esi, 0

    ; Проверка на отсутствие аргументов
    cmp ecx, 0
    jz print_result

sum_loop:
    pop eax        ; аргумент x
    call atoi      ; преобразуем в число

    ; f(x) = 4x + 3
    mov ebx, 4
    mul ebx        ; eax = 4 * x
    add eax, 3     ; eax = 4x + 3

    add esi, eax   ; добавляем к сумме

    loop sum_loop

print_result:
    mov eax, result
    call sprint
    mov eax, esi
    call iprintLF

    call quit
