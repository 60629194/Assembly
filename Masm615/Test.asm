.model small
.data
mes	db	"Hi, I learn assembly.$"

.stack
.code
main proc
	mov ax,@data
	mov ds,ax

	mov dx,offset mes
	mov ah,09h
	int 21h		

	mov ax,4c00h
	int 21h
main endp
end main