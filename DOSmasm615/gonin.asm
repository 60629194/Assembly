.model small
.stack
.data
	ipt db 'Enter two integer<type of xx xx><esc to exit>:$'
	iptsave db 10, ?, 10 Dup(0)
	num dw 2 Dup(0)
	gcdh db 'GCD in heximal:$'
	gcdd db 'GCD in decimal:$'
	lcmh db 'LCM in heximal:$'
	lcmd db 'LCM in decimal:$'
	ent db 13, 10, '$'
.code
main proc
again:
	mov ax, @data
	mov ds, ax
; input num in num array
	lea dx, ipt
	mov ah, 09h
	int 21h
	
	lea dx, iptsave
	mov ah, 0ah
	int 21h
	
	mov al, [iptsave+2]
	cmp al, 27 ;esc
	je ext
	
	call printEnter
	
	mov si, offset iptsave + 2
	call readNum
	mov [num], ax
	
	inc si
	call readNum
	mov [num+2], ax
	
	mov bx, num[0]
	mov cx, num[1]
	mov cl, ch
	mov ch, 0
	
	push bx
	push cx
	
;calculate gcdh
	mov ax, bx
	mov dx, 0
	div cx
l0:	cmp dx, 0
	je l1
	mov ax, cx
	mov cx, dx
	mov dx, 0
	div cx
	jmp l0
	
l1:   ; cx=gcdh ;change gcdh to gcdd
	mov dx, cx
	mov bx, cx
	mov cx, 000ah
	mov ax, bx
	xor dx, dx
	div cx
	
	mov cl, 4
	shl al, cl
	add dl, al
	
	mov cx, dx
	;bx=gcdh  cx=gcdd
;print gcdh
	mov dx, offset gcdh
	mov ah, 09h
	int 21h
	
	mov si, cx ;printDatainBl fuction will use cl
	call printDatainBl
	call printEnter

;print gcdd	
	mov dx, offset gcdd
	mov ah, 09h
	int 21h
	
	mov bx, si ;reload origin cx
	call printDatainBl
	call printEnter
	
	call printEnter
;gcdd in bx
;calculate lcmh
	mov di, 0
	mov di, bx
	pop ax
	pop bx
	mul bx
	div di
	mov bx, ax
	
	mov dx, offset lcmh
	mov ah, 09h
	int 21h
	
	call printDatainBx
	call printEnter
	; lcmd in hex in bx
	
	mov cx, 000ah
	mov ax, bx
	xor dx, dx
	div cx
	
	mov si, dx
	
	xor dx, dx
	div cx
	mov di, dx
	
	xor dx, dx
	div cx
	
	mov cl, 4
	mov ah, al
	shl ah, cl
	shl dx, cl
	shl dx, cl
	add dh, ah
	shl di, cl
	add dx, di
	add dx, si
	mov bx, dx ;bx = lcmd
	
	mov dx, offset lcmd
	mov ah, 09h
	int 21h
	
	call printDatainBx
	call printEnter
	
	mov ax, 0
	mov bx, 0
	mov cx, 0
	mov dx, 0
	mov si, 0
	mov di, 0
	jmp again
	
ext:mov ax, 4c00h
	int 21h
main endp

readNum proc
	mov ax, 0
rl:	mov cl, [si]
	cmp cl, '0'
	jl endrl
	cmp cl, '9'
	jg endrl
	sub cl, '0'
	mov bx, 10
	mul bx
	add ax, cx
	inc si
	
	jmp rl
	
endrl:
	ret	
readNum endp

printDatainBl proc
	mov cl, 4
	mov dl, bl
	shr dl, cl
	cmp dl, 0ah
	jb pbl1
	add dl, 07h
pbl1: add dl, 30h
	mov ah, 02h
	int 21h
	mov dl, bl
	and dl, 0fh
	cmp dl, 0ah
	jb pbl2
	add dl, 07h
pbl2: add dl, 30h
	int 21h
	ret
printDatainBl endp

printDatainBx proc
	mov ah, 02h
	mov cl, 4
	mov dl, bh
	shr dl, cl
	cmp dl, 0ah
	jb pbx1
	add dl, 07h
pbx1: add dl, 30h
	int 21h
	
	mov dl, bh
	and dl, 0fh
	cmp dl, 0ah
	jb pbx2
	add dl, 07h
pbx2: add dl, 30h
	int 21h
	
	mov dl, bl
	shr dl, cl
	cmp dl, 0ah
	jb pbx3
	add dl, 07h
pbx3: add dl, 30h
	int 21h
	
	mov dl, bl
	and dl, 0fh
	cmp dl, 0ah
	jb pbx4
	add dl, 07h
pbx4: add dl, 30h
	int 21h
	ret
printDatainBx endp

printEnter proc
	mov dx, offset ent
	mov ah, 09h
	int 21h
	ret
printEnter endp

end main