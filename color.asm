.model small
.stack
.data
    color db 15
.code
include vmem.inc
main PROC
    mov ax, @data
    mov ds, ax

    mov ax, 12h
    int 10h

    mov cx, 100
    mov dx, 100

    call vmem
    .repeat
        inc cx
        call vmem
    .until cx==200 ;(200, 100)

    .repeat
        dec cx
        inc dx
        call vmem
    .until cx==50 ;(50, 250)    

    .repeat
        dec dx
        call vmem 
    .until dx==150 ;(50, 150)

    .repeat
        inc cx
        dec dx
        call vmem
    .until dx==100 

    mov color, 14
    mov cx, 100
    mov dx, 150
    mov si, 0ffffh
    push si
    call fill

    mov ax, 0
    int 16h

    mov ax, 3
    int 10h

    mov ax, 4c00h
    int 21h

main ENDP

fill PROC
    push cx
    push dx
    ;(cx, dx)
    call vmem

    inc cx
    call vmemr
    cmp al, 0
    jne notr
    call fill
notr:    
    dec cx
    dec cx
    call vmemr
    cmp al, 0
    jne notl
    call fill
notl:
    inc cx
    inc dx
    call vmemr
    cmp al, 0
    jne notu
    call fill
notu:
    dec dx
    dec dx
    call vmemr
    cmp al, 0
    jne notd
    call fill
notd:
    pop dx
    cmp dx, 0ffffh
    je finish
    pop cx
    call fill

finish:
    ret    
    
fill ENDP
end main