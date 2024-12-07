.data
.code
vmem PROC
    push ax
    push bx
    push cx
    push dx
    push di
    mov ax, 0A000h ; video memory start point
    mov es, ax

    ;offset=y*(640/8)+(x/8)
    mov ax, dx
    mov bx, 80
    mul bx
    mov di, ax

    mov ax, cx
    mov bx, 8
    div bx
    add di, ax ; di=offset
    
    mov  dx, 03CEh                ; set to video hardware controller

    and  cl, 07h                  ; Compute bit mask from X-coordinates
    xor  cl, 07h                  ;  and put in ah
    mov  ah, 01h                  ;
    shl  ah, cl                   ;
    mov  al, 08h                  ; bit mask register
    out  dx, ax                   ;

    mov  ax, 0205h                ; read mode 0, write mode 2
    out  dx, ax                   ;
           
    mov  al, es:[di]              ; load to latch register
    mov  al, color ; color
    mov  es:[di], al              ; write to register

    pop di
    pop dx
    pop cx
    pop bx
    pop ax

    ret
    
vmem ENDP