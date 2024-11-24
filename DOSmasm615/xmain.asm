.model small
.stack
.data
    EXTERNDEF sin1:WORD
.code

include trig.inc

main PROC
    mov ax, @data
    mov ds, ax
    mov bx, 0
    mov ax, 233
    call sin
    mov ax, 233
    call cos

    mov ax, 4C00h
    int 21h

main ENDP
end main