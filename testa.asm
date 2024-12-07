.model small
.stack
.data
	P1 dw 320, 240
	P2 dw 350, 100
	P3 dw 250, 125
	P4 dw 375, 175
	top dw 
	xmtm dw 2 Dup(?)
	ymtm dw 2 Dup(?)
	color db 15
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
	
	mov ax, P1[0]
	cmp ax, P2[0]
	jb n1
	mov ax, P2[0]
n1:	cmp ax, P3[0]
	jb n2
	mov ax, P3[0]
n2: cmp ax, P4[0]
	jb n3
	mov ax, P4[0]
n3: mov xmtm[2], ax

	mov ax, P1[0]
	cmp ax, P2[0]
	ja n4
	mov ax, P2[0]
n4:	cmp ax, P3[0]
	ja n5
	mov ax, P3[0]
n5: cmp ax, P4[0]
	ja n6
	mov ax, P4[0]
n6: mov xmtm[0], ax

	mov ax, P1[2]
	cmp ax, P2[2]
	jb n7
	mov ax, P2[2]
n7:	cmp ax, P3[2]
	jb n8
	mov ax, P3[2]
n8: cmp ax, P4[2]
	jb n9
	mov ax, P4[2]
n9: mov ymtm[2], ax	
	
	mov ax, P1[2]
	cmp ax, P2[2]
	ja n10
	mov ax, P2[2]
n10:	cmp ax, P3[2]
	ja n11
	mov ax, P3[2]
n11: cmp ax, P4[2]
	ja n12
	mov ax, P4[2]
n12: mov ymtm[2], ax	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

	
	mov ax, 0
	int 16h
	
	mov ax, 3
	int 10h
	
	mov ax, 4c00h
	int 21h

main endp
end main
