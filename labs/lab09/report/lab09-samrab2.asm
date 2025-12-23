%include 'in_out.asm'

SECTION .data
div:
    DB 'Результат: ',0

SECTION .text
GLOBAL _start

_start:
    ; ---- Вычисление выражения (3+2)*4+5
    mov ebx,3
    mov eax,2
    add ebx,eax
    mov eax,ebx     ; перенос суммы в EAX
    mov ecx,4
    mul ecx         ; EAX = (3+2)*4 = 20
    add eax,5       ; EAX = 25
    mov edi,eax     ; сохраняем результат

    ; ---- Вывод результата
    mov eax,div
    call sprint
    mov eax,edi
    call iprintLF
    call quit
