.data
    sin1 dw 0, 87, 174, 262, 349, 436, 523, 609, 696, 782, 868, 954, 1040, 1125, 1210, 1294
    sin2 dw 1378, 1462, 1545, 1628, 1710, 1792, 1873, 1954, 2034, 2113, 2192, 2270, 2347, 2424, 2500
    sin3 dw 2575, 2650, 2723, 2796, 2868, 2939, 3009, 3078, 3147, 3214, 3280, 3346, 3410, 3473, 3536
    sin4 dw 3597, 3657, 3716, 3774, 3830, 3886, 3940, 3993, 4045, 4096, 4145, 4193, 4240, 4286, 4330
    sin5 dw 4373, 4415, 4455, 4494, 4532, 4568, 4603, 4636, 4668, 4698, 4728, 4755, 4782, 4806, 4830
    sin6 dw 4851, 4872, 4891, 4908, 4924, 4938, 4951, 4963, 4973, 4981, 4988, 4993, 4997, 4999, 5000
.code
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