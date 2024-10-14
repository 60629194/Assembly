.model small
.stack 100h
.data
	a dw 3 dup(?)
	b dw 3 dup(?)

.code
main proc
	mov ax, @data
	mov ds, ax
	
	lea di, a
	mov cx, 3
ia:	
	mov ah, 01h
	int 21h
	mov [di], al
	inc di
	loop ia
	
	lea di, b
	mov cx, 3
ib:	
	mov ah, 01h
	int 21h
	mov [di], al
	inc di
	loop ib

;data in	
	mov cx, lengthof a
	add cx, lengthof a
	
l1:				
	push a[bx]
	push b[bx]
	add bx, 2
	cmp bx, cx
	jb l1
	
	mov bx, 0
	mov cx, 0
	mov ch, lengthof a

;inner product saved in  bx
l0:				
	pop ax
	pop dx
	mul dx
	add bx, ax
	
	inc cl
	cmp cl, ch
	jb l0 
	
	;print
	mov cl, 4
	mov ah, 02h
	mov dl, bh
	shr dl, cl
	add dl, 30h
	int 21h
	
	mov dl, bh
	and dl, 0fh
	add dl, 30h
	int 21h
	
	mov dl, bl
	shr dl, cl
	add dl, 30h
	int 21h
	
	mov dl, bl
	and dl, 0fh
	add dl, 30h
	int 21h

	mov ax, 4c00h
	int 21h
main endp
end main

