	;line up
	mov ax, sp2[0]
	mov bx, sp1[0]
	mov cx, sp2[2]
	mov dx, sp1[2]
	cmp ax, bx 
	jb c2
	cmp cx, dx
	jb c1
	;++
	mov ax, sp2[0]
	sub ax, word ptr sp1[0]
	mov vl[0], ax
	mov ax, sp2[2]
	sub ax, word ptr sp1[2]
	mov vl[2], ax
	mov ax, vl[0]
	mov bx, vl[2]
	cmp ax, bx
	jb l0
	mov di, 1
a1:	mov ax, vl[2]
	imul di
	mov bx, vl[0]
	idiv bx
	call round

	mov cx, sp1[0]
	add cx, di
	mov dx, sp1[2]
	add dx, ax
	mov ax, 0c01h ; draw cx, dx
    int 10h
	inc di
	cmp di, vl[0]
	jne a1
	jmp fl1

l0:	mov di, 1
a2:	mov ax, vl[0]
	imul di
	mov bx, vl[2]
	idiv bx
	call round

	mov cx, sp1[0]
	add cx, ax
	mov dx, sp1[2]
	add dx, di
	mov ax, 0c01h ; draw cx, dx
    int 10h
	inc di
	cmp di, vl[2]
	jne a2
	jmp fl1

c1: 
	;+-
	mov ax, sp2[0]
	sub ax, word ptr sp1[0]
	mov vl[0], ax
	mov ax, sp2[2]
	sub ax, word ptr sp1[2]
	mov vl[2], ax
	mov ax, vl[0]
	mov bx, ax
	mov ax, vl[2]
	call abs
	xchg ax, bx	
	cmp ax, bx ;|vl0||vl2|
	jb l1

	mov di, 1
a3:	mov ax, vl[2]
	imul di
	mov bx, vl[0]
	idiv bx
	call round

	mov cx, sp1[0]
	add cx, di
	mov dx, sp1[2]
	sub dx, ax
	mov ax, 0c01h ; draw cx, dx
    int 10h
	inc di
	cmp di, vl[0]
	jne a3
	jmp fl1

l1:	mov di, 1
a4:	mov ax, vl[0]
	imul di
	mov bx, vl[2]
	idiv bx
	call round

	mov cx, sp1[0]
	add cx, ax
	mov dx, sp1[2]
	sub dx, di
	mov ax, 0c01h ; draw cx, dx
    int 10h
	inc di
	cmp di, vl[2]
	jne a4
	jmp fl1

c2:	cmp cx, dx
	jb c3
	;-+
	mov ax, sp2[0]
	sub ax, word ptr sp1[0]
	mov vl[0], ax
	mov ax, sp2[2]
	sub ax, word ptr sp1[2]
	mov vl[2], ax
	mov ax, vl[0]
	call abs
	mov bx, vl[2]
	cmp ax, bx ;|vl0||vl2|
	jb l2
	mov di, 1
a5:	mov ax, vl[2]
	imul di
	mov bx, vl[0]
	idiv bx
	call round

	mov cx, sp1[0]
	sub cx, di
	mov dx, sp1[2]
	add dx, ax
	mov ax, 0c01h ; draw cx, dx
    int 10h
	inc di
	cmp di, vl[0]
	jne a5
	jmp fl1

l2:	mov di, 1
a6:	mov ax, vl[2]
	imul di
	mov bx, vl[0]
	idiv bx
	call round

	mov cx, sp1[0]
	sub cx, ax
	mov dx, sp1[2]
	add dx, di
	mov ax, 0c01h ; draw cx, dx
    int 10h
	inc di
	cmp di, vl[0]
	jne a6
	jmp fl1

c3:
	;--
	mov ax, sp2[0]
	sub ax, word ptr sp1[0]
	mov vl[0], ax
	mov ax, sp2[2]
	sub ax, word ptr sp1[2]
	mov vl[2], ax
	mov ax, vl[0]
	call abs
	mov bx, ax
	mov ax, vl[2]
	call abs
	xchg ax, bx
	cmp ax, bx
	jb l0
	mov di, 1
a7:	mov ax, vl[2]
	imul di
	mov bx, vl[0]
	idiv bx
	call round

	mov cx, sp1[0]
	sub cx, di
	mov dx, sp1[2]
	sub dx, ax
	mov ax, 0c01h ; draw cx, dx
    int 10h
	inc di
	cmp di, vl[0]
	jne a7
	jmp fl1

l3:	mov di, 1
a8:	mov ax, vl[0]
	imul di
	mov bx, vl[2]
	idiv bx
	call round

	mov cx, sp1[0]
	sub cx, ax
	mov dx, sp1[2]
	sub dx, di
	mov ax, 0c01h ; draw cx, dx
    int 10h
	inc di
	cmp di, vl[2]
	jne a8
	jmp fl1



fl1:
