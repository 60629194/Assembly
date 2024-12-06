.data
    maskTable db 1, 2, 4, 8, 16, 32, 64, 128
.code
vmem PROC
    pusha
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
    mov dh, 0
    mov dl, ah
    mov si, dx

    mov al, maskTable[si]
    mov ah, al

    mov al, 4 ;color
    mov dx, 3c4h ; VGA Sequener Address register
    mov al, 2 ; map mask
    out dx, al
    inc dx
    mov al, ah
    out dx, al
    mov es:[di], al

    ret
    
vmem ENDP