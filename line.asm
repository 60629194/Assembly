.model small
.stack
.data
	;original cube
    Qc dw  320, 1000,  240
    Q1 dw  240,  240,  240 ;+++
    Q2 dw  240,  240, -240 ;++-
    Q3 dw  240, -240,  240  ;+-+
    Q4 dw -240,  240,  240 ;-++
    Q5 dw -240, -240,  240  ;--+
    Q6 dw -240,  240, -240 ;-+-
    Q7 dw  240, -240, -240  ;+--
    Q8 dw -240, -240, -240  ;---
	;cube for projection
	P1 dw 3 Dup(?)
	P2 dw 3 Dup(?)
	P3 dw 3 Dup(?)
	P4 dw 3 Dup(?)
	P5 dw 3 Dup(?)
	P6 dw 3 Dup(?)
	P7 dw 3 Dup(?)
	P8 dw 3 Dup(?)
	;parameterized line equation vector
	vp dw 3 Dup(?)
    ;
    thetax dw 0
    thetay dw 0
	thetaz dw 0

    rx dw 1, 0 ;cos, sin
    ry dw 1, 0 
    rz dw 1, 0

	;projection on screen
	sp1 dw 2 Dup(?) 
    sp2 dw 2 Dup(?)
    sp3 dw 2 Dup(?)
    sp4 dw 2 Dup(?)
	sp5 dw 2 Dup(?)
	sp6 dw 2 Dup(?)
	sp7 dw 2 Dup(?)
	sp8 dw 2 Dup(?)

	Pp dw 320, 0, 240 ;perspective point

	scr dw 500 ;y coordinate of screen

.code
include trig.inc
include math.inc
main PROC
    ;catch input
    mov ax, @data
    mov ds, ax

ipt:
    mov ah, 10h
    int 16h
    cmp al, 73h ;w
    je xn
    cmp al, 77h ;s
    je xp
    cmp al, 71h ;q
    je yn
    cmp al, 65h ;e
    je yp
    cmp al, 61h ;a
    je zn
    cmp al, 64h ;d
    je zp

    cmp al, 27 ;esc
    je exit
    jmp ipt 

    ;rotate cube
    xn:
		cmp thetax, 0
		jne rok1
		mov thetax, 360
		rok1:
		dec word ptr thetax
        jmp cal
    xp:
		cmp thetax, 360
		jne rok2
		mov thetax, 0
		rok2:
		inc word ptr thetax
        jmp cal
    yn:
		cmp thetay, 0
		jne rok3
		mov thetay, 360
		rok3:
		dec word ptr thetay
        jmp cal
    yp:
		cmp thetay, 360
		jne rok4
		mov thetay, 0
		rok4:
		inc word ptr thetay
        jmp cal
    zn:
		cmp thetaz, 0
		jne rok5
		mov thetaz, 360
		rok5:
		dec word ptr thetaz
        jmp cal
    zp:
        cmp thetaz, 360
		jne rok6
		mov thetaz, 0
		rok6:
		inc word ptr thetaz
        jmp cal
cal:
    ;rx*Q1
    mov ax, Q1[0]
    mov P1[0], ax
    ;
    mov ax, thetax
    call cos
    mov dx, Q1[2]
    imul dx
    mov bx, dx
    mov cx, ax
    mov ax, thetax
    call sin
    neg ax
    mov dx, Q1[4]
    imul dx
    call EXadd
    mov bx, 5000
    idiv bx
    call round
    mov P1[2], ax
    ;
    mov ax, thetax
    call sin
    mov dx, Q1[2]
    imul dx
    mov bx, dx
    mov cx, ax
    mov ax, thetax
    call cos
    mov dx, Q1[4]
    imul dx
    call EXadd
    mov bx, 5000
    idiv bx
    call round
    mov P1[4], ax
    ;;;
    mov ax, thetay
    call cos
    mov dx, P1[0]
    imul dx
    mov bx, dx
    mov cx, ax
    mov ax, thetay
    call sin 
    mov dx, P1[4]
    imul dx
    call EXadd
    mov bx, 5000
    idiv bx
    call round
    push ax ;*
    ;
    ;Ryy=Rxy
    ;
    mov ax, thetay
    call sin
    neg ax
    mov dx, P1[0]
    imul dx
    mov bx, dx
    mov cx, ax
    mov ax, thetay
    call cos
    mov dx, P1[4]
    imul dx
    call EXadd
    mov bx, 5000
    idiv bx
    call round
    mov P1[4], ax
    pop ax
    mov P1[0], ax
    ;;;
    mov ax, thetaz
    call cos
    mov dx, P1[0]
    imul dx
    mov bx, dx
    mov cx, ax
    mov ax, thetaz
    call sin 
    neg ax
    mov dx, P1[2]
    imul dx
    call EXadd
    mov bx, 5000
    idiv bx
    call round
    push ax
    ;
    mov ax, thetaz
    call sin
    mov dx, P1[0]
    imul dx
    mov bx, dx
    mov cx, ax
    mov ax, thetaz
    call cos
    mov dx, P1[2]
    imul dx
    call EXadd
    mov bx, 5000
    idiv bx
    call round
    mov P1[2], ax
    pop ax
    mov P1[0], ax
    ;
    ;Rzz=Ryz

    ;Q2 P2
    mov ax, Q2[0]
    mov P2[0], ax
    ;
    mov ax, thetax
    call cos
    mov dx, Q2[2]
    imul dx
    mov bx, dx
    mov cx, ax
    mov ax, thetax
    call sin
    neg ax
    mov dx, Q2[4]
    imul dx
    call EXadd
    mov bx, 5000
    idiv bx
    call round
    mov P2[2], ax
    ;
    mov ax, thetax
    call sin
    mov dx, Q2[2]
    imul dx
    mov bx, dx
    mov cx, ax
    mov ax, thetax
    call cos
    mov dx, Q2[4]
    imul dx
    call EXadd
    mov bx, 5000
    idiv bx
    call round
    mov P2[4], ax
    ;;;
    mov ax, thetay
    call cos
    mov dx, P2[0]
    imul dx
    mov bx, dx
    mov cx, ax
    mov ax, thetay
    call sin 
    mov dx, P2[4]
    imul dx
    call EXadd
    mov bx, 5000
    idiv bx
    call round
    push ax ;*
    ;
    ;Ryy=Rxy
    ;
    mov ax, thetay
    call sin
    neg ax
    mov dx, P2[0]
    imul dx
    mov bx, dx
    mov cx, ax
    mov ax, thetay
    call cos
    mov dx, P2[4]
    imul dx
    call EXadd
    mov bx, 5000
    idiv bx
    call round
    mov P2[4], ax
    pop ax
    mov P2[0], ax
    ;;;
    mov ax, thetaz
    call cos
    mov dx, P2[0]
    imul dx
    mov bx, dx
    mov cx, ax
    mov ax, thetaz
    call sin 
    neg ax
    mov dx, P2[2]
    imul dx
    call EXadd
    mov bx, 5000
    idiv bx
    call round
    push ax
    ;
    mov ax, thetaz
    call sin
    mov dx, P2[0]
    imul dx
    mov bx, dx
    mov cx, ax
    mov ax, thetaz
    call cos
    mov dx, P2[2]
    imul dx
    call EXadd
    mov bx, 5000
    idiv bx
    call round
    mov P2[2], ax
    pop ax
    mov P2[0], ax
    ;
    ;Rzz=Ryz
    ;Q2 P2

    ;Q3 P3
    mov ax, Q3[0]
    mov P3[0], ax
    ;
    mov ax, thetax
    call cos
    mov dx, Q3[2]
    imul dx
    mov bx, dx
    mov cx, ax
    mov ax, thetax
    call sin
    neg ax
    mov dx, Q3[4]
    imul dx
    call EXadd
    mov bx, 5000
    idiv bx
    call round
    mov P3[2], ax
    ;
    mov ax, thetax
    call sin
    mov dx, Q3[2]
    imul dx
    mov bx, dx
    mov cx, ax
    mov ax, thetax
    call cos
    mov dx, Q3[4]
    imul dx
    call EXadd
    mov bx, 5000
    idiv bx
    call round
    mov P3[4], ax
    ;;;
    mov ax, thetay
    call cos
    mov dx, P3[0]
    imul dx
    mov bx, dx
    mov cx, ax
    mov ax, thetay
    call sin 
    mov dx, P3[4]
    imul dx
    call EXadd
    mov bx, 5000
    idiv bx
    call round
    push ax ;*
    ;
    ;Ryy=Rxy
    ;
    mov ax, thetay
    call sin
    neg ax
    mov dx, P3[0]
    imul dx
    mov bx, dx
    mov cx, ax
    mov ax, thetay
    call cos
    mov dx, P3[4]
    imul dx
    call EXadd
    mov bx, 5000
    idiv bx
    call round
    mov P3[4], ax
    pop ax
    mov P3[0], ax
    ;;;
    mov ax, thetaz
    call cos
    mov dx, P3[0]
    imul dx
    mov bx, dx
    mov cx, ax
    mov ax, thetaz
    call sin 
    neg ax
    mov dx, P3[2]
    imul dx
    call EXadd
    mov bx, 5000
    idiv bx
    call round
    push ax
    ;
    mov ax, thetaz
    call sin
    mov dx, P3[0]
    imul dx
    mov bx, dx
    mov cx, ax
    mov ax, thetaz
    call cos
    mov dx, P3[2]
    imul dx
    call EXadd
    mov bx, 5000
    idiv bx
    call round
    mov P3[2], ax
    pop ax
    mov P3[0], ax
    ;
    ;Rzz=Ryz
    ;Q3 P3

    ;Q4 P4
    mov ax, Q4[0]
    mov P4[0], ax
    ;
    mov ax, thetax
    call cos
    mov dx, Q4[2]
    imul dx
    mov bx, dx
    mov cx, ax
    mov ax, thetax
    call sin
    neg ax
    mov dx, Q4[4]
    imul dx
    call EXadd
    mov bx, 5000
    idiv bx
    call round
    mov P4[2], ax
    ;
    mov ax, thetax
    call sin
    mov dx, Q4[2]
    imul dx
    mov bx, dx
    mov cx, ax
    mov ax, thetax
    call cos
    mov dx, Q4[4]
    imul dx
    call EXadd
    mov bx, 5000
    idiv bx
    call round
    mov P4[4], ax
    ;;;
    mov ax, thetay
    call cos
    mov dx, P4[0]
    imul dx
    mov bx, dx
    mov cx, ax
    mov ax, thetay
    call sin 
    mov dx, P4[4]
    imul dx
    call EXadd
    mov bx, 5000
    idiv bx
    call round
    push ax ;*
    ;
    ;Ryy=Rxy
    ;
    mov ax, thetay
    call sin
    neg ax
    mov dx, P4[0]
    imul dx
    mov bx, dx
    mov cx, ax
    mov ax, thetay
    call cos
    mov dx, P4[4]
    imul dx
    call EXadd
    mov bx, 5000
    idiv bx
    call round
    mov P4[4], ax
    pop ax
    mov P4[0], ax
    ;;;
    mov ax, thetaz
    call cos
    mov dx, P4[0]
    imul dx
    mov bx, dx
    mov cx, ax
    mov ax, thetaz
    call sin 
    neg ax
    mov dx, P4[2]
    imul dx
    call EXadd
    mov bx, 5000
    idiv bx
    call round
    push ax
    ;
    mov ax, thetaz
    call sin
    mov dx, P4[0]
    imul dx
    mov bx, dx
    mov cx, ax
    mov ax, thetaz
    call cos
    mov dx, P4[2]
    imul dx
    call EXadd
    mov bx, 5000
    idiv bx
    call round
    mov P4[2], ax
    pop ax
    mov P4[0], ax
    ;
    ;Rzz=Ryz
    ;Q4 P4

    ;Q5 P5
    mov ax, Q5[0]
    mov P5[0], ax
    ;
    mov ax, thetax
    call cos
    mov dx, Q5[2]
    imul dx
    mov bx, dx
    mov cx, ax
    mov ax, thetax
    call sin
    neg ax
    mov dx, Q5[4]
    imul dx
    call EXadd
    mov bx, 5000
    idiv bx
    call round
    mov P5[2], ax
    ;
    mov ax, thetax
    call sin
    mov dx, Q5[2]
    imul dx
    mov bx, dx
    mov cx, ax
    mov ax, thetax
    call cos
    mov dx, Q5[4]
    imul dx
    call EXadd
    mov bx, 5000
    idiv bx
    call round
    mov P5[4], ax
    ;;;
    mov ax, thetay
    call cos
    mov dx, P5[0]
    imul dx
    mov bx, dx
    mov cx, ax
    mov ax, thetay
    call sin 
    mov dx, P5[4]
    imul dx
    call EXadd
    mov bx, 5000
    idiv bx
    call round
    push ax ;*
    ;
    ;Ryy=Rxy
    ;
    mov ax, thetay
    call sin
    neg ax
    mov dx, P5[0]
    imul dx
    mov bx, dx
    mov cx, ax
    mov ax, thetay
    call cos
    mov dx, P5[4]
    imul dx
    call EXadd
    mov bx, 5000
    idiv bx
    call round
    mov P5[4], ax
    pop ax
    mov P5[0], ax
    ;;;
    mov ax, thetaz
    call cos
    mov dx, P5[0]
    imul dx
    mov bx, dx
    mov cx, ax
    mov ax, thetaz
    call sin 
    neg ax
    mov dx, P5[2]
    imul dx
    call EXadd
    mov bx, 5000
    idiv bx
    call round
    push ax
    ;
    mov ax, thetaz
    call sin
    mov dx, P5[0]
    imul dx
    mov bx, dx
    mov cx, ax
    mov ax, thetaz
    call cos
    mov dx, P5[2]
    imul dx
    call EXadd
    mov bx, 5000
    idiv bx
    call round
    mov P5[2], ax
    pop ax
    mov P5[0], ax
    ;
    ;Rzz=Ryz
    ;Q5 P5

    ;Q6 P6
    mov ax, Q6[0]
    mov P6[0], ax
    ;
    mov ax, thetax
    call cos
    mov dx, Q6[2]
    imul dx
    mov bx, dx
    mov cx, ax
    mov ax, thetax
    call sin
    neg ax
    mov dx, Q6[4]
    imul dx
    call EXadd
    mov bx, 5000
    idiv bx
    call round
    mov P6[2], ax
    ;
    mov ax, thetax
    call sin
    mov dx, Q6[2]
    imul dx
    mov bx, dx
    mov cx, ax
    mov ax, thetax
    call cos
    mov dx, Q6[4]
    imul dx
    call EXadd
    mov bx, 5000
    idiv bx
    call round
    mov P6[4], ax
    ;;;
    mov ax, thetay
    call cos
    mov dx, P6[0]
    imul dx
    mov bx, dx
    mov cx, ax
    mov ax, thetay
    call sin 
    mov dx, P6[4]
    imul dx
    call EXadd
    mov bx, 5000
    idiv bx
    call round
    push ax ;*
    ;
    ;Ryy=Rxy
    ;
    mov ax, thetay
    call sin
    neg ax
    mov dx, P6[0]
    imul dx
    mov bx, dx
    mov cx, ax
    mov ax, thetay
    call cos
    mov dx, P6[4]
    imul dx
    call EXadd
    mov bx, 5000
    idiv bx
    call round
    mov P6[4], ax
    pop ax
    mov P6[0], ax
    ;;;
    mov ax, thetaz
    call cos
    mov dx, P6[0]
    imul dx
    mov bx, dx
    mov cx, ax
    mov ax, thetaz
    call sin 
    neg ax
    mov dx, P6[2]
    imul dx
    call EXadd
    mov bx, 5000
    idiv bx
    call round
    push ax
    ;
    mov ax, thetaz
    call sin
    mov dx, P6[0]
    imul dx
    mov bx, dx
    mov cx, ax
    mov ax, thetaz
    call cos
    mov dx, P6[2]
    imul dx
    call EXadd
    mov bx, 5000
    idiv bx
    call round
    mov P6[2], ax
    pop ax
    mov P6[0], ax
    ;
    ;Rzz=Ryz
    ;Q6 P6

    ;Q7 P7
    mov ax, Q7[0]
    mov P7[0], ax
    ;
    mov ax, thetax
    call cos
    mov dx, Q7[2]
    imul dx
    mov bx, dx
    mov cx, ax
    mov ax, thetax
    call sin
    neg ax
    mov dx, Q7[4]
    imul dx
    call EXadd
    mov bx, 5000
    idiv bx
    call round
    mov P7[2], ax
    ;
    mov ax, thetax
    call sin
    mov dx, Q7[2]
    imul dx
    mov bx, dx
    mov cx, ax
    mov ax, thetax
    call cos
    mov dx, Q7[4]
    imul dx
    call EXadd
    mov bx, 5000
    idiv bx
    call round
    mov P7[4], ax
    ;;;
    mov ax, thetay
    call cos
    mov dx, P7[0]
    imul dx
    mov bx, dx
    mov cx, ax
    mov ax, thetay
    call sin 
    mov dx, P7[4]
    imul dx
    call EXadd
    mov bx, 5000
    idiv bx
    call round
    push ax ;*
    ;
    ;Ryy=Rxy
    ;
    mov ax, thetay
    call sin
    neg ax
    mov dx, P7[0]
    imul dx
    mov bx, dx
    mov cx, ax
    mov ax, thetay
    call cos
    mov dx, P7[4]
    imul dx
    call EXadd
    mov bx, 5000
    idiv bx
    call round
    mov P7[4], ax
    pop ax
    mov P7[0], ax
    ;;;
    mov ax, thetaz
    call cos
    mov dx, P7[0]
    imul dx
    mov bx, dx
    mov cx, ax
    mov ax, thetaz
    call sin 
    neg ax
    mov dx, P7[2]
    imul dx
    call EXadd
    mov bx, 5000
    idiv bx
    call round
    push ax
    ;
    mov ax, thetaz
    call sin
    mov dx, P7[0]
    imul dx
    mov bx, dx
    mov cx, ax
    mov ax, thetaz
    call cos
    mov dx, P7[2]
    imul dx
    call EXadd
    mov bx, 5000
    idiv bx
    call round
    mov P7[2], ax
    pop ax
    mov P7[0], ax
    ;
    ;Rzz=Ryz
    ;Q7 P7

    ;Q8 P8
    mov ax, Q8[0]
    mov P8[0], ax
    ;
    mov ax, thetax
    call cos
    mov dx, Q8[2]
    imul dx
    mov bx, dx
    mov cx, ax
    mov ax, thetax
    call sin
    neg ax
    mov dx, Q8[4]
    imul dx
    call EXadd
    mov bx, 5000
    idiv bx
    call round
    mov P8[2], ax
    ;
    mov ax, thetax
    call sin
    mov dx, Q8[2]
    imul dx
    mov bx, dx
    mov cx, ax
    mov ax, thetax
    call cos
    mov dx, Q8[4]
    imul dx
    call EXadd
    mov bx, 5000
    idiv bx
    call round
    mov P8[4], ax
    ;;;
    mov ax, thetay
    call cos
    mov dx, P8[0]
    imul dx
    mov bx, dx
    mov cx, ax
    mov ax, thetay
    call sin 
    mov dx, P8[4]
    imul dx
    call EXadd
    mov bx, 5000
    idiv bx
    call round
    push ax ;*
    ;
    ;Ryy=Rxy
    ;
    mov ax, thetay
    call sin
    neg ax
    mov dx, P8[0]
    imul dx
    mov bx, dx
    mov cx, ax
    mov ax, thetay
    call cos
    mov dx, P8[4]
    imul dx
    call EXadd
    mov bx, 5000
    idiv bx
    call round
    mov P8[4], ax
    pop ax
    mov P8[0], ax
    ;;;
    mov ax, thetaz
    call cos
    mov dx, P8[0]
    imul dx
    mov bx, dx
    mov cx, ax
    mov ax, thetaz
    call sin 
    neg ax
    mov dx, P8[2]
    imul dx
    call EXadd
    mov bx, 5000
    idiv bx
    call round
    push ax
    ;
    mov ax, thetaz
    call sin
    mov dx, P8[0]
    imul dx
    mov bx, dx
    mov cx, ax
    mov ax, thetaz
    call cos
    mov dx, P8[2]
    imul dx
    call EXadd
    mov bx, 5000
    idiv bx
    call round
    mov P8[2], ax
    pop ax
    mov P8[0], ax
    ;
    ;Rzz=Ryz
    ;Q8 P8


    ;Pn=Pn+Qc
    mov ax, Qc[0]
	add word ptr P1[0], ax
	mov ax, Qc[2]
	add word ptr P1[2], ax
	mov ax, Qc[4]
	add word ptr P1[4], ax

    mov ax, Qc[0]
	add word ptr P2[0], ax
	mov ax, Qc[2]
	add word ptr P2[2], ax
	mov ax, Qc[4]
	add word ptr P2[4], ax

    mov ax, Qc[0]
	add word ptr P3[0], ax
	mov ax, Qc[2]
	add word ptr P3[2], ax
	mov ax, Qc[4]
	add word ptr P3[4], ax

    mov ax, Qc[0]
	add word ptr P4[0], ax
	mov ax, Qc[2]
	add word ptr P4[2], ax
	mov ax, Qc[4]
	add word ptr P4[4], ax

    mov ax, Qc[0]
	add word ptr P5[0], ax
	mov ax, Qc[2]
	add word ptr P5[2], ax
	mov ax, Qc[4]
	add word ptr P5[4], ax

    mov ax, Qc[0]
	add word ptr P6[0], ax
	mov ax, Qc[2]
	add word ptr P6[2], ax
	mov ax, Qc[4]
	add word ptr P6[4], ax

    mov ax, Qc[0]
	add word ptr P7[0], ax
	mov ax, Qc[2]
	add word ptr P7[2], ax
	mov ax, Qc[4]
	add word ptr P7[4], ax

    mov ax, Qc[0]
	add word ptr P8[0], ax
	mov ax, Qc[2]
	add word ptr P8[2], ax
	mov ax, Qc[4]
	add word ptr P8[4], ax
proj:
    mov ax, P1[0]
	sub ax, Pp[0]
	mov vp[0], ax
	mov ax, P1[2]
	sub ax, Pp[2]
	mov vp[2], ax
	mov ax, P1[4]
	sub ax, Pp[4]
	mov vp[4], ax
	
	xor dx, dx
	mov ax, scr
	mov bx, 30001 ; number which can discuss
	imul bx
	mov bx, vp[2]
	idiv bx  
	call round
	;dx:ax=t*num
	push dx
	push ax
	
	mov cx, vp[0]
	imul cx
	mov bx, 30001
	idiv bx
	call round
	mov cx, Pp[0]
	mov bx, 0
	call EXadd
	mov sp1[0], ax

	pop ax
	pop dx
	mov cx, vp[4]
	imul cx
	mov bx, 30001
	idiv bx
	call round
	mov cx, Pp[4]
	mov bx, 0
	call EXadd
	mov sp1[2], ax
	;;;2
	mov ax, P2[0]
	sub ax, Pp[0]
	mov vp[0], ax
	mov ax, P2[2]
	sub ax, Pp[2]
	mov vp[2], ax
	mov ax, P2[4]
	sub ax, Pp[4]
	mov vp[4], ax
	
	xor dx, dx
	mov ax, scr
	mov bx, 30001 ; number which can discuss
	imul bx
	mov bx, vp[2]
	idiv bx  
	call round
	;dx:ax=t*num
	push dx
	push ax
	
	mov cx, vp[0]
	imul cx
	mov bx, 30001
	idiv bx
	call round
	mov cx, Pp[0]
	mov bx, 0
	call EXadd
	mov sp2[0], ax

	pop ax
	pop dx
	mov cx, vp[4]
	imul cx
	mov bx, 30001
	idiv bx
	call round
	mov cx, Pp[4]
	mov bx, 0
	call EXadd
	mov sp2[2], ax
	;;;3
	mov ax, P3[0]
	sub ax, Pp[0]
	mov vp[0], ax
	mov ax, P3[2]
	sub ax, Pp[2]
	mov vp[2], ax
	mov ax, P3[4]
	sub ax, Pp[4]
	mov vp[4], ax
	
	xor dx, dx
	mov ax, scr
	mov bx, 30001 ; number which can discuss
	imul bx
	mov bx, vp[2]
	idiv bx  
	call round
	;dx:ax=t*num
	push dx
	push ax
	
	mov cx, vp[0]
	imul cx
	mov bx, 30001
	idiv bx
	call round
	mov cx, Pp[0]
	mov bx, 0
	call EXadd
	mov sp3[0], ax

	pop ax
	pop dx
	mov cx, vp[4]
	imul cx
	mov bx, 30001
	idiv bx
	call round
	mov cx, Pp[4]
	mov bx, 0
	call EXadd
	mov sp3[2], ax
	;;;4
	mov ax, P4[0]
	sub ax, Pp[0]
	mov vp[0], ax
	mov ax, P4[2]
	sub ax, Pp[2]
	mov vp[2], ax
	mov ax, P4[4]
	sub ax, Pp[4]
	mov vp[4], ax
	
	xor dx, dx
	mov ax, scr
	mov bx, 30001 ; number which can discuss
	imul bx
	mov bx, vp[2]
	idiv bx  
	call round
	;dx:ax=t*num
	push dx
	push ax
	
	mov cx, vp[0]
	imul cx
	mov bx, 30001
	idiv bx
	call round
	mov cx, Pp[0]
	mov bx, 0
	call EXadd
	mov sp4[0], ax

	pop ax
	pop dx
	mov cx, vp[4]
	imul cx
	mov bx, 30001
	idiv bx
	call round
	mov cx, Pp[4]
	mov bx, 0
	call EXadd
	mov sp4[2], ax
	;;;5
	mov ax, P5[0]
	sub ax, Pp[0]
	mov vp[0], ax
	mov ax, P5[2]
	sub ax, Pp[2]
	mov vp[2], ax
	mov ax, P5[4]
	sub ax, Pp[4]
	mov vp[4], ax
	
	xor dx, dx
	mov ax, scr
	mov bx, 30001 ; number which can discuss
	imul bx
	mov bx, vp[2]
	idiv bx  
	call round
	;dx:ax=t*num
	push dx
	push ax
	
	mov cx, vp[0]
	imul cx
	mov bx, 30001
	idiv bx
	call round
	mov cx, Pp[0]
	mov bx, 0
	call EXadd
	mov sp5[0], ax

	pop ax
	pop dx
	mov cx, vp[4]
	imul cx
	mov bx, 30001
	idiv bx
	call round
	mov cx, Pp[4]
	mov bx, 0
	call EXadd
	mov sp5[2], ax
	;;;6
	mov ax, P6[0]
	sub ax, Pp[0]
	mov vp[0], ax
	mov ax, P6[2]
	sub ax, Pp[2]
	mov vp[2], ax
	mov ax, P6[4]
	sub ax, Pp[4]
	mov vp[4], ax
	
	xor dx, dx
	mov ax, scr
	mov bx, 30001 ; number which can discuss
	imul bx
	mov bx, vp[2]
	idiv bx  
	call round
	;dx:ax=t*num
	push dx
	push ax
	
	mov cx, vp[0]
	imul cx
	mov bx, 30001
	idiv bx
	call round
	mov cx, Pp[0]
	mov bx, 0
	call EXadd
	mov sp6[0], ax

	pop ax
	pop dx
	mov cx, vp[4]
	imul cx
	mov bx, 30001
	idiv bx
	call round
	mov cx, Pp[4]
	mov bx, 0
	call EXadd
	mov sp6[2], ax
	;;;7
	mov ax, P7[0]
	sub ax, Pp[0]
	mov vp[0], ax
	mov ax, P7[2]
	sub ax, Pp[2]
	mov vp[2], ax
	mov ax, P7[4]
	sub ax, Pp[4]
	mov vp[4], ax
	
	xor dx, dx
	mov ax, scr
	mov bx, 30001 ; number which can discuss
	imul bx
	mov bx, vp[2]
	idiv bx  
	call round
	;dx:ax=t*num
	push dx
	push ax
	
	mov cx, vp[0]
	imul cx
	mov bx, 30001
	idiv bx
	call round
	mov cx, Pp[0]
	mov bx, 0
	call EXadd
	mov sp7[0], ax

	pop ax
	pop dx
	mov cx, vp[4]
	imul cx
	mov bx, 30001
	idiv bx
	call round
	mov cx, Pp[4]
	mov bx, 0
	call EXadd
	mov sp7[2], ax
	;;;8
	mov ax, P8[0]
	sub ax, Pp[0]
	mov vp[0], ax
	mov ax, P8[2]
	sub ax, Pp[2]
	mov vp[2], ax
	mov ax, P8[4]
	sub ax, Pp[4]
	mov vp[4], ax
	
	xor dx, dx
	mov ax, scr
	mov bx, 30001 ; number which can discuss
	imul bx
	mov bx, vp[2]
	idiv bx
	call round
	;dx:ax=t*num
	push dx
	push ax
	
	mov cx, vp[0]
	imul cx
	mov bx, 30001
	idiv bx
	call round
	mov cx, Pp[0]
	mov bx, 0
	call EXadd
	mov sp8[0], ax

	pop ax
	pop dx
	mov cx, vp[4]
	imul cx
	mov bx, 30001
	idiv bx
	call round
	mov cx, Pp[4]
	mov bx, 0
	call EXadd
	mov sp8[2], ax

gra:
    mov ax, 11h ;graphic mode
    int 10h
	;;test
	mov cx, sp1[0]
	mov dx, sp1[2]
    mov ax, 0c01h ; draw cx, dx
    int 10h
	mov cx, sp2[0]
	mov dx, sp2[2]
    mov ax, 0c01h ; draw cx, dx
    int 10h
	mov cx, sp3[0]
	mov dx, sp3[2]
    mov ax, 0c01h ; draw cx, dx
    int 10h
	mov cx, sp4[0]
	mov dx, sp4[2]
    mov ax, 0c01h ; draw cx, dx
    int 10h
	mov cx, sp5[0]
	mov dx, sp5[2]
    mov ax, 0c01h ; draw cx, dx
    int 10h
	mov cx, sp6[0]
	mov dx, sp6[2]
    mov ax, 0c01h ; draw cx, dx
    int 10h
	mov cx, sp7[0]
	mov dx, sp7[2]
    mov ax, 0c01h ; draw cx, dx
    int 10h
	mov cx, sp8[0]
	mov dx, sp8[2]
    mov ax, 0c01h ; draw cx, dx
    int 10h

    ;draw line

    ;P1->P2

    mov bx, sp2[0]
    mov si, sp1[0]
    cmp bx, si
    jb swap1
    sub bx, si
    mov ax, sp2[2]
    mov di, sp1[2]
    sub ax, di
    jmp done1
swap1:
    mov bx, sp1[0]
    mov si, sp2[0]
    sub bx, si
    mov ax, sp1[2]
    mov di, sp2[2]
    sub ax, di
done1:
    xor dx, dx
    push ax
    cwd
    idiv bx
    call abs
    cmp ax, 1
    ja incy
;ax = y2-y1
;bx = x2-x1
;si = x1
;di = y1
incx:
    pop ax
    mov cx, si
    mov si, 0
repeatx:
    inc si ;si = x-x1
    push ax
    imul si
    idiv bx
    mov dx, ax ;dx = k(x-x1)
    inc cx
    add dx, di ;dx = k(x-x1)+y1
    mov ax, 0c01h ; draw cx, dx
    int 10h
    pop ax
    cmp si, bx
    jne repeatx
    jmp done12
incy:
    pop ax
    mov dx, di ;dx= start position of y 
    mov di, 0 ; y-y1
repeaty:
    inc di
    mov cx, ax;y2-y1
    push ax
    push dx
    mov ax, di
    imul bx;(y-y1)(x2-x1)
    idiv cx;ax = (y-y1)/k
    mov cx, ax
    pop dx
    add cx, si;cx = (y-y1)/k + x1
    inc dx
    mov ax, 0c01h ; draw cx, dx
    int 10h
    pop ax
    cmp ax, di
    jne repeaty

done12:

    jmp ipt

exit:
    mov ax, 4c00h
    int 21h

main ENDP
end main        
