.code
topL proc
    push ax
    

    mov al, rubik[0]
    mov ah, rubik[6]
    mov rubik[6], al
    mov al, rubik[4]
    mov rubik[4], ah
    mov ah, rubik[2]
    mov rubik[2], al
    mov rubik[0],ah

    mov al, rubik[3]
    mov ah, rubik[1]
    mov rubik[1], al
    mov al, rubik[7]
    mov rubik[7],ah
    mov ah, rubik[5]
    mov rubik[5], al
    mov rubik[3],ah

    mov al, rubik[16]
    mov ah, rubik[19]
    mov rubik[19], al
    mov al, rubik[18]
    mov rubik[18],ah
    mov ah, rubik[17]
    mov rubik[17], al
    mov rubik[16],ah

    
    pop ax
    ret
topL endp

topR proc
    push ax
    

    mov al, rubik[6]
    mov ah, rubik[0]
    mov rubik[0], al
    mov al, rubik[2]
    mov rubik[2],ah
    mov ah, rubik[4]
    mov rubik[4], al
    mov rubik[6],ah

    mov al, rubik[1]
    mov ah, rubik[3]
    mov rubik[3], al
    mov al, rubik[5]
    mov rubik[5],ah
    mov ah, rubik[7]
    mov rubik[7], al
    mov rubik[1],ah

    mov al, rubik[19]
    mov ah, rubik[16]
    mov rubik[16], al
    mov al, rubik[17]
    mov rubik[17],ah
    mov ah, rubik[18]
    mov rubik[18], al
    mov rubik[19],ah

    
    pop ax
    ret
topR endp

bottomL proc
    push ax
    

    mov al, rubik[8]
    mov ah, rubik[14]
    mov rubik[14], al
    mov al, rubik[12]
    mov rubik[12],ah
    mov ah, rubik[10]
    mov rubik[10], al
    mov rubik[8],ah

    mov al, rubik[11]
    mov ah, rubik[9]
    mov rubik[9], al
    mov al, rubik[15]
    mov rubik[15],ah
    mov ah, rubik[13]
    mov rubik[13], al
    mov rubik[11],ah

    mov al, rubik[20]
    mov ah, rubik[23]
    mov rubik[23], al
    mov al, rubik[22]
    mov rubik[22],ah
    mov ah, rubik[21]
    mov rubik[21], al
    mov rubik[20],ah

    
    pop ax
    ret
bottomL endp

bottomR proc
    push ax
    

    mov al, rubik[14]
    mov ah, rubik[8]
    mov rubik[8], al
    mov al, rubik[10]
    mov rubik[10],ah
    mov ah, rubik[12]
    mov rubik[12], al
    mov rubik[14],ah

    mov al, rubik[9]
    mov ah, rubik[11]
    mov rubik[11], al
    mov al, rubik[13]
    mov rubik[13],ah
    mov ah, rubik[15]
    mov rubik[15], al
    mov rubik[9],ah

    mov al, rubik[23]
    mov ah, rubik[20]
    mov rubik[20], al
    mov al, rubik[21]
    mov rubik[21],ah
    mov ah, rubik[22]
    mov rubik[22], al
    mov rubik[23],ah

    
    pop ax
    ret
bottomR endp

closeL proc
    push ax
    

    mov al, rubik[0]
    mov ah, rubik[8]
    mov rubik[8], al
    mov al, rubik[9]
    mov rubik[9],ah
    mov ah, rubik[1]
    mov rubik[1], al
    mov rubik[0],ah

    mov al, rubik[2]
    mov ah, rubik[16]
    mov rubik[16], al
    mov al, rubik[15]
    mov rubik[15],ah
    mov ah, rubik[21]
    mov rubik[21], al
    mov rubik[2],ah

    mov al, rubik[20]
    mov ah, rubik[10]
    mov rubik[10], al
    mov al, rubik[17]
    mov rubik[17],ah
    mov ah, rubik[7]
    mov rubik[7], al
    mov rubik[20],ah

    
    pop ax
    ret
closeL endp

closeR proc
    push ax
    

    mov al, rubik[8]
    mov ah, rubik[0]
    mov rubik[0], al
    mov al, rubik[1]
    mov rubik[1],ah
    mov ah, rubik[9]
    mov rubik[9], al
    mov rubik[8],ah

    mov al, rubik[16]
    mov ah, rubik[2]
    mov rubik[2], al
    mov al, rubik[21]
    mov rubik[21],ah
    mov ah, rubik[15]
    mov rubik[15], al
    mov rubik[16],ah

    mov al, rubik[17]
    mov ah, rubik[10]
    mov rubik[10], al
    mov al, rubik[20]
    mov rubik[20],ah
    mov ah, rubik[7]
    mov rubik[7], al
    mov rubik[17],ah

    
    pop ax
    ret
closeR endp

farL proc
    push ax
    

    mov al, rubik[11]
    mov ah, rubik[18]
    mov rubik[18], al
    mov al, rubik[6]
    mov rubik[6],ah
    mov ah, rubik[23]
    mov rubik[23], al
    mov rubik[11],ah
    
    mov al, rubik[3]
    mov ah, rubik[19]
    mov rubik[19], al
    mov al, rubik[14]
    mov rubik[14],ah
    mov ah, rubik[22]
    mov rubik[22], al
    mov rubik[3],ah

    mov al, rubik[4]
    mov ah, rubik[5]
    mov rubik[5], al
    mov al, rubik[13]
    mov rubik[13],ah
    mov ah, rubik[12]
    mov rubik[12], al
    mov rubik[4],ah
    
    
    pop ax
    ret
farL endp

farR proc
    push ax
    

    mov al, rubik[19]
    mov ah, rubik[3]
    mov rubik[3], al
    mov al, rubik[22]
    mov rubik[22],ah
    mov ah, rubik[14]
    mov rubik[14], al
    mov rubik[19],ah

    mov al, rubik[18]
    mov ah, rubik[11]
    mov rubik[11], al
    mov al, rubik[23]
    mov rubik[23],ah
    mov ah, rubik[6]
    mov rubik[6], al
    mov rubik[18],ah

    mov al, rubik[12]
    mov ah, rubik[13]
    mov rubik[13], al
    mov al, rubik[5]
    mov rubik[5],ah
    mov ah, rubik[4]
    mov rubik[4], al
    mov rubik[12],ah

    
    pop ax
    ret
farR endp

rightF proc
    push ax
    

    mov al, rubik[1]
    mov ah, rubik[18]
    mov rubik[18], al
    mov al, rubik[12]
    mov rubik[12],ah
    mov ah, rubik[21]
    mov rubik[21], al
    mov rubik[1],ah

    mov al, rubik[9]
    mov ah, rubik[17]
    mov rubik[17], al
    mov al, rubik[4]
    mov rubik[4],ah
    mov ah, rubik[22]
    mov rubik[22], al
    mov rubik[9],ah

    mov al, rubik[2]
    mov ah, rubik[3]
    mov rubik[3], al
    mov al, rubik[11]
    mov rubik[11],ah
    mov ah, rubik[10]
    mov rubik[10], al
    mov rubik[2],ah

    
    pop ax
    ret
rightF endp

rightB proc
    push ax
    

    mov al, rubik[18]
    mov ah, rubik[1]
    mov rubik[1], al
    mov al, rubik[21]
    mov rubik[21],ah
    mov ah, rubik[12]
    mov rubik[12], al
    mov rubik[18],ah

    mov al, rubik[17]
    mov ah, rubik[9]
    mov rubik[9], al
    mov al, rubik[22]
    mov rubik[22],ah
    mov ah, rubik[4]
    mov rubik[4], al
    mov rubik[17],ah


    mov al, rubik[3]
    mov ah, rubik[2]
    mov rubik[2], al
    mov al, rubik[10]
    mov rubik[10],ah
    mov ah, rubik[11]
    mov rubik[11], al
    mov rubik[3],ah

    
    pop ax
    ret
rightB endp

leftF proc
    push ax
    

    mov al, rubik[8]
    mov ah, rubik[16]
    mov rubik[16], al
    mov al, rubik[5]
    mov rubik[5],ah
    mov ah, rubik[23]
    mov rubik[23], al
    mov rubik[8],ah
    
    mov al, rubik[0]
    mov ah, rubik[19]
    mov rubik[19], al
    mov al, rubik[13]
    mov rubik[13],ah
    mov ah, rubik[20]
    mov rubik[20], al
    mov rubik[0],ah

    mov al, rubik[7]
    mov ah, rubik[6]
    mov rubik[6], al
    mov al, rubik[14]
    mov rubik[14],ah
    mov ah, rubik[15]
    mov rubik[15],al
    mov rubik[7],ah

    
    pop ax
    ret
leftF endp

leftB proc
    push ax
    

    mov al, rubik[16]
    mov ah, rubik[8]
    mov rubik[8],al
    mov al, rubik[23]
    mov rubik[23],ah
    mov ah, rubik[5]
    mov rubik[5],al
    mov rubik[16],ah

    mov al, rubik[19]
    mov ah, rubik[0]
    mov rubik[0],al
    mov al, rubik[20]
    mov rubik[20],ah
    mov ah, rubik[13]
    mov rubik[13],al
    mov rubik[19],ah

    mov al, rubik[6]
    mov ah, rubik[7]
    mov rubik[7],al
    mov al, rubik[15]
    mov rubik[15],ah
    mov ah, rubik[14]
    mov rubik[14],al
    mov rubik[6],ah

    
    pop ax
    ret
leftB endp
