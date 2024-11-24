.code
EXadd PROC
    add ax, cx
    jnc @ncarry
    inc dx
@ncarry:
    add dx, bx
    ret
EXadd ENDP