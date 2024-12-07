.model small
.stack
.data
.code
main proc
	mov ax, 12h
	int 10h
	
	mov cx, 0
	mov dx, 0
	
y:	mov ax, 0c02h
	int 10h
	
	inc dx
	cmp dx, 480
	jae x
	jmp y

x:	inc cx
	mov dx, 0
	cmp cx, 640
	jae exit
	jmp y
	
exit:
	mov ax, 0003h
	int 10h
	
	mov ax, 4c00h
	int 21h
	
	
main endp
end main