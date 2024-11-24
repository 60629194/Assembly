sin proc 
    push bx

    cmp ax, 90
    jbe @Fquater
    cmp ax, 180
    jbe @Squater
    cmp ax, 270
    jbe @Tquater

;Fouth quater
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
    sub ax, 180
    mov bx, ax
    shl bx, 1
    mov ax, WORD PTR sin1[bx]
    neg ax

@done:
    pop bx
    ret
sin ENDP

cos PROC
    push bx

    cmp ax, 90
    jbe @Fquater
    cmp ax, 180
    jbe @Squater
    cmp ax, 270
    jbe @Tquater

;Fourth quater
    sub ax, 270
    mov bx, ax
    shl bx, 1
    mov ax, WORD PTR sin1[bx]
    jmp @done

@Fquater:
    mov bx, 90
    sub bx, ax
    shl bx, 1
    mov ax, WORD PTR sin1[bx]
    jmp @done

@Squater:
    sub ax, 90
    mov bx, ax
    shl bx, 1
    mov ax, WORD PTR sin1[bx]
    neg ax
    jmp @done

@Tquater:
    mov bx, 270
    sub bx, ax
    shl bx, 1
    mov ax, WORD PTR sin1[bx]
    neg ax

@done:
    pop bx
    ret
cos ENDP