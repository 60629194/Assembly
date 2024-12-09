.model small
.stack
.data
	P1 dw 320, 240
	P2 dw 350, 100
	P3 dw 250, 125
	P4 dw 375, 175
	md dw 2 Dup(?)
	color db 15
    lineyn db 0
.code
include vmem.inc
main proc
	mov ax, @data
	mov ds, ax

	mov ax, 12h
	int 10h
	
    mov cx, P1[0]
	mov dx, P1[2]
	call vmem
	
	mov cx, P2[0]
	mov dx, P2[2]
	call vmem
	
	mov cx, P3[0]
	mov dx, P3[2]
	call vmem
	
	mov cx, P4[0]
	mov dx, P4[2]
	call vmem

    xor dx, dx
    mov ax, P1[0]
    add ax, word ptr P2[0]
    add ax, word ptr P3[0]
    add ax, word ptr P4[0]
    mov bx, 4
    div bx
    mov md[0], ax

    xor dx, dx
    mov ax, P1[2]
    add ax, word ptr P2[2]
    add ax, word ptr P3[2]
    add ax, word ptr P4[2]
    mov bx, 4
    div bx
    mov md[2], ax

    mov cx, md[0]
	mov dx, md[2]
	call vmem
    call vmemr
    mov al, lineyn
	
	mov ax, 0
	int 16h
	
	mov ax, 3
	int 10h
	
	mov ax, 4c00h
	int 21h

main endp
end main
