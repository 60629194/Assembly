.model small
.stack
.data
.code

include math.inc

main PROC
    mov ax, @data
    mov ds, ax

    mov dx, 002Dh
    mov ax, 0C6C0h
    mov bx, 0FFD2h
    mov cx, 6050h
    call EXadd

    mov ax, 4c00h
    int 21h

main ENDP
end main