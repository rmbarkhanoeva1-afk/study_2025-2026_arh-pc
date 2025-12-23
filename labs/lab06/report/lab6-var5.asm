%include 'in_out.asm'

SECTION .data
    formula: db 'Формула вычисления: y = (9x - 8) / 8', 0
    prompt:  db 'Введите значение x: ', 0
    result:  db 'Результат: y = ', 0
    test1:   db 'Тест 1: x = 8', 0
    test2:   db 'Тест 2: x = 64', 0
    newline: db '', 0Ah, 0

SECTION .bss
    x: resb 10

SECTION .text
GLOBAL _start

_start:
    ; Выводим формулу
    mov eax, formula
    call sprintLF

    ; Пустая строка
    mov eax, newline
    call sprint

    ; Запрос ввода x от пользователя
    mov eax, prompt
    call sprint
    mov ecx, x
    mov edx, 10
    call sread

    ; Преобразуем строку в число
    mov eax, x
    call atoi          ; результат в eax

    ; Вычисляем y = (9x - 8) / 8
    mov ebx, 9         ; ebx = 9
    mul ebx            ; eax = 9 * x
    sub eax, 8         ; eax = 9x - 8
    xor edx, edx       ; обнуляем edx для деления
    mov ebx, 8         ; ebx = 8 (делитель)
    div ebx            ; eax = (9x - 8) / 8, edx = остаток

    ; Сохраняем результат
    mov edi, eax

    ; Выводим результат
    mov eax, result
    call sprint
    mov eax, edi
    call iprintLF

    ; Пустая строка
    mov eax, newline
    call sprint

    ; Тест 1 с x1 = 8
    mov eax, test1
    call sprintLF

    mov eax, 8         ; x1 = 8
    mov ebx, 9         ; ebx = 9
    mul ebx            ; eax = 9 * 8 = 72
    sub eax, 8         ; eax = 72 - 8 = 64
    xor edx, edx       ; обнуляем edx
    mov ebx, 8         ; ebx = 8
    div ebx            ; eax = 64 / 8 = 8

    mov eax, result
    call sprint
    mov eax, 8         ; результат вычислений
    call iprintLF

    ; Тест 2 с x2 = 64
    mov eax, test2
    call sprintLF

    mov eax, 64        ; x2 = 64
    mov ebx, 9         ; ebx = 9
    mul ebx            ; eax = 9 * 64 = 576
    sub eax, 8         ; eax = 576 - 8 = 568
    xor edx, edx       ; обнуляем edx
    mov ebx, 8         ; ebx = 8
    div ebx            ; eax = 568 / 8 = 71 (целая часть)

    mov eax, result
    call sprint
    mov eax, 71        ; результат вычислений
    call iprintLF

    call quit
