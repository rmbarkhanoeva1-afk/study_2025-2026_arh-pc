%include "in_out.asm"

SECTION .data
    msg     db 'Введите x: ', 0
    result  db 'f(g(x)) = ', 0

SECTION .bss
    x       resb 80
    res     resd 1

SECTION .text
    global _start

_start:
    ;------------------------------------------
    ; Основная программа
    ;------------------------------------------
    mov eax, msg
    call sprint

    mov ecx, x
    mov edx, 80
    call sread

    mov eax, x
    call atoi

    call _calcul

    mov eax, result
    call sprint

    mov eax, [res]
    call iprintLF

    call quit

;------------------------------------------
; Подпрограмма вычисления f(g(x))
; f(x) = 2x + 7
;------------------------------------------
_calcul:
    ; eax = x
    call _subcalcul       ; eax = g(x)

    mov ebx, 2
    mul ebx               ; eax = 2 * g(x)
    add eax, 7            ; eax = f(g(x))

    mov [res], eax
    ret

;------------------------------------------
; Подпрограмма вычисления g(x)
; g(x) = 3x - 1
;------------------------------------------
_subcalcul:
    mov ebx, 3
    mul ebx               ; eax = 3x
    sub eax, 1            ; eax = 3x - 1
    ret
