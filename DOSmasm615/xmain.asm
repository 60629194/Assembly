.model small
.stack
.data
	color db 2
.code
include vmem.inc
main proc
	mov ax, @data
	mov ds, ax
	
	mov ax, 12h
	int 10h
	
	mov cx, 0
	mov dx, 0
	
y:	call vmem
	
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