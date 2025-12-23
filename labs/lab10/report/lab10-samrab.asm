;--------------------------------
; lab10-self.asm
; Программа: ввод фамилии и имени и запись в name.txt
;--------------------------------
%include 'in_out.asm'

SECTION .data
filename db 'name.txt', 0           ; имя файла
msg_prompt db 'Как Вас зовут? ', 0h
msg_prefix db 'Меня зовут ', 0h

SECTION .bss
user_name resb 255                  ; буфер для ввода фамилии и имени

SECTION .text
global _start
_start:

    ; --- Вывод приглашения пользователю
    mov eax, msg_prompt
    call sprint

    ; --- Ввод строки с клавиатуры в user_name
    mov ecx, user_name
    mov edx, 255
    call sread

    ; --- Создание файла name.txt с правами rw-rw-rw-
    mov eax, 8          ; sys_creat
    mov ebx, filename
    mov ecx, 0666o
    int 80h
    mov esi, eax        ; сохраняем файловый дескриптор

    ; --- Запись префикса "Меня зовут " в файл
    mov eax, msg_prefix
    call slen
    mov edx, eax         ; длина строки "Меня зовут "
    mov ecx, msg_prefix
    mov ebx, esi        ; файловый дескриптор
    mov eax, 4          ; sys_write
    int 80h

    ; --- Запись введенной строки в файл
    mov eax, user_name
    call slen           ; вычисление длины строки, результат в eax
    mov edx, eax        ; количество байт для записи
    mov ecx, user_name  ; адрес строки
    mov ebx, esi        ; файловый дескриптор
    mov eax, 4          ; sys_write
    int 80h

    ; --- Закрытие файла
    mov eax, 6          ; sys_close
    mov ebx, esi
    int 80h

    call quit
