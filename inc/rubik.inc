.code
topL proc
    push ax
    push bx

    mov ax, rubik[0]
    mov bx, rubik[6]
    mov rubik[6], ax
    mov ax, rubik[4]
    mov rubik[4], bx
    mov bx, rubik[2]
    mov rubik[2], ax
    mov rubik[0], bx

    mov ax, rubik[3]
    mov bx, rubik[1]
    mov rubik[1], ax
    mov ax, rubik[7]
    mov rubik[7], bx
    mov bx, rubik[5]
    mov rubik[5], ax
    mov rubik[3], bx

    mov ax, rubik[16]
    mov bx, rubik[19]
    mov rubik[19], ax
    mov ax, rubik[18]
    mov rubik[18], bx
    mov bx, rubik[17]
    mov rubik[17], ax
    mov rubik[16], bx

    pop bx
    pop ax
    ret
topL endp

topR proc
    push ax
    push bx

    mov ax, rubik[6]
    mov bx, rubik[0]
    mov rubik[0], ax
    mov ax, rubik[2]
    mov rubik[2], bx
    mov bx, rubik[4]
    mov rubik[4], ax
    mov rubik[6], bx

    mov ax, rubik[1]
    mov bx, rubik[3]
    mov rubik[3], ax
    mov ax, rubik[5]
    mov rubik[5], bx
    mov bx, rubik[7]
    mov rubik[7], ax
    mov rubik[1], bx

    mov ax, rubik[19]
    mov bx, rubik[16]
    mov rubik[16], ax
    mov ax, rubik[17]
    mov rubik[17], bx
    mov bx, rubik[18]
    mov rubik[18], ax
    mov rubik[19], bx

    pop bx
    pop ax
    ret
topR endp

bottomL proc
    push ax
    push bx

    mov ax, rubik[8]
    mov bx, rubik[14]
    mov rubik[14], ax
    mov ax, rubik[12]
    mov rubik[12], bx
    mov bx, rubik[10]
    mov rubik[10], ax
    mov rubik[8], bx

    mov ax, rubik[11]
    mov bx, rubik[9]
    mov rubik[9], ax
    mov ax, rubik[15]
    mov rubik[15], bx
    mov bx, rubik[13]
    mov rubik[13], ax
    mov rubik[11], bx

    mov ax, rubik[20]
    mov bx, rubik[23]
    mov rubik[23], ax
    mov ax, rubik[22]
    mov rubik[22], bx
    mov bx, rubik[21]
    mov rubik[21], ax
    mov rubik[20], bx

    pop bx
    pop ax
    ret
bottomL endp

bottomR proc
    push ax
    push bx

    mov ax, rubik[14]
    mov bx, rubik[8]
    mov rubik[8], ax
    mov ax, rubik[10]
    mov rubik[10], bx
    mov bx, rubik[12]
    mov rubik[12], ax
    mov rubik[14], bx

    mov ax, rubik[9]
    mov bx, rubik[11]
    mov rubik[11], ax
    mov ax, rubik[13]
    mov rubik[13], bx
    mov bx, rubik[15]
    mov rubik[15], ax
    mov rubik[9], bx

    mov ax, rubik[23]
    mov bx, rubik[20]
    mov rubik[20], ax
    mov ax, rubik[21]
    mov rubik[21], bx
    mov bx, rubik[22]
    mov rubik[22], ax
    mov rubik[23], bx

    pop bx
    pop ax
    ret
bottomR endp

closeL proc
    push ax
    push bx

    mov ax, rubik[0]
    mov bx, rubik[8]
    mov rubik[8], ax
    mov ax, rubik[9]
    mov rubik[9], bx
    mov bx, rubik[1]
    mov rubik[1], ax
    mov rubik[0], bx

    mov ax, rubik[2]
    mov bx, rubik[16]
    mov rubik[16], ax
    mov ax, rubik[15]
    mov rubik[15], bx
    mov bx, rubik[21]
    mov rubik[21], ax
    mov rubik[2], bx

    mov ax, rubik[20]
    mov bx, rubik[10]
    mov rubik[10], ax
    mov ax, rubik[17]
    mov rubik[17], bx
    mov bx, rubik[7]
    mov rubik[7], ax
    mov rubik[20], bx

    pop bx
    pop ax
    ret
closeL endp

closeR proc
    push ax
    push bx

    mov ax, rubik[8]
    mov bx, rubik[0]
    mov rubik[0], ax
    mov ax, rubik[1]
    mov rubik[1], bx
    mov bx, rubik[9]
    mov rubik[9], ax
    mov rubik[8], bx

    mov ax, rubik[16]
    mov bx, rubik[2]
    mov rubik[2], ax
    mov ax, rubik[21]
    mov rubik[21], bx
    mov bx, rubik[15]
    mov rubik[15], ax
    mov rubik[16], bx

    mov ax, rubik[17]
    mov bx, rubik[10]
    mov rubik[10], ax
    mov ax, rubik[20]
    mov rubik[20], bx
    mov bx, rubik[7]
    mov rubik[7], ax
    mov rubik[17], bx

    pop bx
    pop ax
    ret
closeR endp

farL proc
    push ax
    push bx

    mov ax, rubik[11]
    mov bx, rubik[18]
    mov rubik[18], ax
    mov ax, rubik[6]
    mov rubik[6], bx
    mov bx, rubik[23]
    mov rubik[23], ax
    mov rubik[11], bx
    
    mov ax, rubik[3]
    mov bx, rubik[19]
    mov rubik[19], ax
    mov ax, rubik[14]
    mov rubik[14], bx
    mov bx, rubik[22]
    mov rubik[22], ax
    mov rubik[3], bx

    mov ax, rubik[4]
    mov bx, rubik[5]
    mov rubik[5], ax
    mov ax, rubik[13]
    mov rubik[13], bx
    mov bx, rubik[12]
    mov rubik[12], ax
    mov rubik[4], bx
    
    pop bx
    pop ax
    ret
farL endp

farR proc
    push ax
    push bx

    mov ax, rubik[19]
    mov bx, rubik[3]
    mov rubik[3], ax
    mov ax, rubik[22]
    mov rubik[22], bx
    mov bx, rubik[14]
    mov rubik[14], ax
    mov rubik[19], bx

    mov ax, rubik[18]
    mov bx, rubik[11]
    mov rubik[11], ax
    mov ax, rubik[23]
    mov rubik[23], bx
    mov bx, rubik[6]
    mov rubik[6], ax
    mov rubik[18], bx

    mov ax, rubik[12]
    mov bx, rubik[13]
    mov rubik[13], ax
    mov ax, rubik[5]
    mov rubik[5], bx
    mov bx, rubik[4]
    mov rubik[4], ax
    mov rubik[12], bx

    pop bx
    pop ax
    ret
farR endp

rightF proc
    push ax
    push bx

    mov ax, rubik[1]
    mov bx, rubik[18]
    mov rubik[18], ax
    mov ax, rubik[12]
    mov rubik[12], bx
    mov bx, rubik[21]
    mov rubik[21], ax
    mov rubik[1], bx

    mov ax, rubik[9]
    mov bx, rubik[17]
    mov rubik[17], ax
    mov ax, rubik[4]
    mov rubik[4], bx
    mov bx, rubik[22]
    mov rubik[22], ax
    mov rubik[9], bx

    mov ax, rubik[2]
    mov bx, rubik[3]
    mov rubik[3], ax
    mov ax, rubik[11]
    mov rubik[11], bx
    mov bx, rubik[10]
    mov rubik[10], ax
    mov rubik[2], bx

    pop bx
    pop ax
    ret
rightF endp

rightB proc
    push ax
    push bx

    mov ax, rubik[18]
    mov bx, rubik[1]
    mov rubik[1], ax
    mov ax, rubik[21]
    mov rubik[21], bx
    mov bx, rubik[12]
    mov rubik[12], ax
    mov rubik[18], bx

    mov ax, rubik[17]
    mov bx, rubik[9]
    mov rubik[9], ax
    mov ax, rubik[22]
    mov rubik[22], bx
    mov bx, rubik[4]
    mov rubik[4], ax
    mov rubik[17], bx


    mov ax, rubik[3]
    mov bx, rubik[2]
    mov rubik[2], ax
    mov ax, rubik[10]
    mov rubik[10], bx
    mov bx, rubik[11]
    mov rubik[11], ax
    mov rubik[3], bx

    pop bx
    pop ax
    ret
rightB endp

leftF proc
    push ax
    push bx

    mov ax, rubik[8]
    mov bx, rubik[16]
    mov rubik[16], ax
    mov ax, rubik[5]
    mov rubik[5], bx
    mov bx, rubik[23]
    mov rubik[23], ax
    mov rubik[8], bx
    
    mov ax, rubik[0]
    mov bx, rubik[19]
    mov rubik[19], ax
    mov ax, rubik[13]
    mov rubik[13], bx
    mov bx, rubik[20]
    mov rubik[20], ax
    mov rubik[0], bx

    mov ax, rubik[7]
    mov bx, rubik[6]
    mov rubik[6], ax
    mov ax, rubik[14]
    mov rubik[14], bx
    mov bx, rubik[15]
    mov rubik[15], ax
    mov rubik[7], bx

    pop bx
    pop ax
    ret
leftF endp

leftB proc
    push ax
    push bx

    mov ax, rubik[16]
    mov bx, rubik[8]
    mov rubik[8], ax
    mov ax, rubik[23]
    mov rubik[23], bx
    mov bx, rubik[5]
    mov rubik[5], ax
    mov rubik[16], bx

    mov ax, rubik[19]
    mov bx, rubik[0]
    mov rubik[0], ax
    mov ax, rubik[20]
    mov rubik[20], bx
    mov bx, rubik[13]
    mov rubik[13], ax
    mov rubik[19], bx

    mov ax, rubik[6]
    mov bx, rubik[7]
    mov rubik[7], ax
    mov ax, rubik[15]
    mov rubik[15], bx
    mov bx, rubik[14]
    mov rubik[14], ax
    mov rubik[6], bx

    pop bx
    pop ax
    ret
leftB endp
