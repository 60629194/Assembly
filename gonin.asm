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
	del db 8, '$'
	spc db 32, '$'
	warningA db "You can't$"
	warningB db ' enter 0$'

.code
main proc
again:
	mov ax, @data
	mov ds, ax
; input num in stack
	mov dx, offset ipt
	mov ah, 09h
	int 21h
	
	mov bp, sp ;set base pointer to stack pointer
	mov di, 0
rr:	
	mov dx, 0
	mov ah, 10h
	int 16h
	;check exit
	cmp al, 27
	je ext
	;check space
	cmp al, 32
	je space
	;can't delete on first loop
	cmp di, 0
	je check

	cmp al, 8
	jne check
backspace:
	mov ah, 09h
	mov dx, offset del
	int 21h
	mov dx, offset spc
	int 21h
	mov dx, offset del
	int 21h
	dec di
	pop dx
	jmp rr


check:;only numbers are accepted
	cmp al, 48
	jb rr
	cmp al, 57
	ja rr

space:
	mov dx, 0
	mov ah, 02h
	mov dl, al
	int 21h
	sub dl, 30h
	push dx
	inc di
	cmp di, 5
	jne rr
ignore:
	mov ah, 10h
	int 16h
	cmp al, 8
	je backspace
	cmp al, 13
	jne ignore

	mov bl, [bp-2] ;number xo
	mov ax, 0
	mov al, bl
	mov cx, 10
	mul cx
	add al, [bp-4];number ox
	push ax
	cmp ax, 0
	je zero

	mov bl, [bp-8]
	mov ax, 0
	mov al, bl
	mov cx, 10
	mul cx
	add al, [bp-10]
	push ax
	cmp ax, 0
	je zero

	pop cx
	pop bx
	push bx
	push cx
	
	call printEnter
	
;calculate gcdh
	mov ax, bx
	mov dx, 0
	div cx
l0:	
	cmp dx, 0
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
	
	mov di, bx
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
;gcdh in di
;calculate lcmh
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
zero:;print error
	call printEnter
	MOV AH,09
	MOV BX,00cfh ;bling bling
	int 10h
	mov dx, offset warningA
	mov ah, 09h
	int 21h
	MOV AH,09
	MOV BX,00cfh;bling bling
	int 10h
	mov dx, offset warningB
	mov ah, 09h
	int 21h
	call printEnter
	MOV AH,09
	MOV BX,0007h
	int 10h
	jmp again

ext:mov ax, 4c00h
	int 21h
main endp


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