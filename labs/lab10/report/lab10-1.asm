%include 'in_out.asm'

SECTION .data
    filename db 'readme-1.txt', 0h    ; Имя файла
    msg db 'Введите строку для записи в файл: ', 0h    ; Сообщение

SECTION .bss
    contents resb 255    ; переменная для вводимой строки

SECTION .text
global _start

_start:
    ; --- Печать сообщения `msg`
    mov eax, msg
    call sprint
    
    ; ---- Запись введеной с клавиатуры строки в `contents`
    mov ecx, contents
    mov edx, 255
    call sread
    
    ; --- Открытие существующего файла (`sys_open`)
    mov ecx, 2        ; открываем для записи (2)
    mov ebx, filename
    mov eax, 5        ; sys_open
    int 80h
    
    ; --- Запись дескриптора файла в `esi`
    mov esi, eax
    
    ; --- Расчет длины введенной строки
    mov eax, contents
    call slen          ; в `eax` запишется количество введенных байтов
    
    ; --- Записываем в файл `contents` (`sys_write`)
    mov edx, eax       ; длина строки
    mov ecx, contents  ; адрес строки
    mov ebx, esi       ; дескриптор файла
    mov eax, 4         ; sys_write
    int 80h
    
    ; --- Закрываем файл (`sys_close`)
    mov ebx, esi
    mov eax, 6         ; sys_close
    int 80h
    
    call quit
