%include 'in_out.asm'

SECTION .data
    msg db "Результат: ", 0

SECTION .text
global _start

_start:
    pop ecx        ; Извлекаем из стека в `ecx` количество аргументов
    pop edx        ; Извлекаем из стека в `edx` имя программы
    sub ecx, 1     ; Уменьшаем `ecx` на 1 (количество аргументов без названия программы)

    ; Проверка на отсутствие аргументов
    cmp ecx, 0
    jz no_args

    mov esi, 1     ; Используем `esi` для хранения произведения (начальное значение 1)

next:
    pop eax        ; извлекаем следующий аргумент из стека
    call atoi      ; преобразуем символ в число
    imul esi, eax  ; умножаем: esi = esi * eax
    loop next      ; переход к обработке следующего аргумента

    jmp print_result

no_args:
    mov esi, 0     ; если нет аргументов, результат = 0

print_result:
    mov eax, msg   ; вывод сообщения "Результат: "
    call sprint
    mov eax, esi   ; записываем произведение в регистр `eax`
    call iprintLF  ; печать результата

    call quit      ; завершение программы
