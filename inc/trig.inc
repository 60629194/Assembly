
sin proc 
    push bx

    cmp ax, 90
    jbe @Fquater
    cmp ax, 180
    jbe @Squater
    cmp ax, 270
    jbe @Tquater

;Fouthquater
    mov bx, 360
    sub bx, ax
    shl bx, 1
    mov ax, WORD PTR sin1[bx]
    neg ax
    jmp @done

@Fquater:
    mov bx, ax
    shl bx, 1
    mov ax, WORD PTR sin1[bx]
    jmp @done

@Squater:
    mov bx, 180
    sub bx, ax
    shl bx, 1
    mov ax, WORD PTR sin1[bx]
    jmp @done

@Tquater:
    mov bx, 180
    sub ax, bx
    mov bx, ax
    shl bx, 1
    mov ax, WORD PTR sin1[bx]
    neg ax

@done:
    pop bx
    ret
sin ENDP