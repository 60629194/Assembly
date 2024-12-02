.code
EXadd PROC
    add ax, cx
    jnc @ncarry
    inc dx
@ncarry:
    add dx, bx
    ret
EXadd ENDP

round proc
    ;bx : divisor
    ;dx : remainder
    add dx, dx
    jc @larger
    cmp dx, bx
    ja @larger
    ret
@larger:
    inc ax
    ret
round endp

abs PROC
    push bx
    mov bx, ax
    add bx, ax
    jc @negative
    pop bx
    ret
@negative:
    neg ax
    pop bx
    ret
abs ENDP
