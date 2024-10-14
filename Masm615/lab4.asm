.model small
.data
A dw 340dh
B dw 0005h
D dw 0ff00h
mes db 'A*B',10,13,'$'
result1 db 8 dup(?),10,13,'$'
result2 db 4 dup(?),'$'
.stack
.code
main proc
	mov ax,@data
	mov ds,ax
	mov cl,4

	mov ax,A
	imul B

	mov result1[0],dh
	shr result1[0],cl
	add result1[0],30h

	mov result1[1],dh
	and result1[1],0fh
	add result1[1],30h
	
	mov result1[2],dl
	shr result1[2],cl
	add result1[2],30h

	mov result1[3],dl
	and result1[3],0fh
	add result1[3],30h

	mov result1[4],ah
	shr result1[4],cl
	add result1[4],30h

	mov result1[5],ah
	and result1[5],0fh
	add result1[5],30h

	mov result1[6],al
	shr result1[6],cl
	add result1[6],30h

	mov result1[7],al
	and result1[7],0fh
	add result1[7],30h

	idiv D

	mov result2[0],dh
	shr result2[0],cl
	add result2[0],30h

	mov result2[1],dh
	and result2[1],0fh
	add result2[1],30h

	mov result2[2],dl
	shr result2[2],cl
	add result2[2],30h

	mov result2[3],dl
	and result2[3],0fh
	add result2[3],30h

	mov dx,offset mes
	mov ah,09h
	int 21h
	mov dx,offset result1
	int 21h
	mov dx,offset result2
	int 21h
	
	mov ax,4c00h
	int 21h
main endp
end main