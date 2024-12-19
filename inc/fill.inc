fill PROC
    mov al, 0
    push cx
    push dx

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
    cmp al , 0
    jne notd
    call fill
notd:
    pop dx
    pop cx
    
    ret    
fill ENDP

pointexpand PROC
    call vmem
    inc dx
    call vmem
    dec dx
    dec dx
    call vmem
    inc dx
    inc cx
    call vmem
    inc dx
    call vmem
    dec dx
    dec dx
    call vmem
    dec cx
    dec cx
    call vmem
    inc dx
    call vmem
    inc dx
    call vmem
    dec dx
    inc cx

    inc cx
    inc cx
    call vmem
    dec cx
    dec cx
    dec cx
    dec cx
    call vmem
    inc cx
    inc cx
    inc dx
    inc dx
    call vmem
    dec dx
    dec dx
    dec dx
    dec dx
    call vmem
    inc dx
    inc dx

    ret

pointexpand ENDP