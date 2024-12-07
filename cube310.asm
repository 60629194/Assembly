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
    slope dw 0
    countline dw 0
    

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

    color db 0; 0black 1blue(9) 2green(10) 4red(12) 6brown 7gray 14yellow 15white (light color)  

.code
include trig.inc
include math.inc
include vmem.inc
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
    cmp al, 7Ah ;z
    je zoom
    cmp al, 78h  ;x
    je shrink

  

    cmp al, 27 ;esc
    je exit
    jmp ipt 


    zoom:
        cmp word ptr scr, 520
        ja ipt
        inc word ptr scr
    jmp cal

    shrink:
        cmp word ptr scr, 10
        jb ipt
        dec word ptr scr
    jmp cal

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
    mov ax, 12h ;graphic mode
    int 10h
	;;test
	mov cx, sp1[0]
	mov dx, sp1[2]
    mov color, 15
    call vmem
	mov cx, sp2[0]
	mov dx, sp2[2]
    mov color, 15
    call vmem
	mov cx, sp3[0]
	mov dx, sp3[2]
    mov color, 15
    call vmem
	mov cx, sp4[0]
	mov dx, sp4[2]
    mov color, 15
    call vmem
	mov cx, sp5[0]
	mov dx, sp5[2]
    mov color, 15
    call vmem
	mov cx, sp6[0]
	mov dx, sp6[2]
    mov color, 15
    call vmem
	mov cx, sp7[0]
	mov dx, sp7[2]
    mov color, 15
    call vmem
	mov cx, sp8[0]
	mov dx, sp8[2]
    mov color, 15
    call vmem


    mov countline, 0
    ;draw line
;;12
l12:    
    mov ax, sp2[2]
	mov si, sp1[2]
	sub ax, si
	mov bx, sp2[0]
	mov di, sp1[0]
	sub bx, di
	cmp bx, 0
	je y1by212
	xor dx, dx
	cwd
	idiv bx
	mov slope, ax

	cmp ax, -1
	jg x1bx212

	cmp ax, -1
	jl y1by212

x1bx212:
	mov ax, sp1[0]
	mov bx, sp2[0]
	mov si, sp1[2]
	mov di, sp2[2]
	cmp ax, bx
	jb setx12
	xchg ax, bx
	xchg si, di

	setx12:
	push ax
	mov ax, slope
	cmp ax, 1
	jge incy
	jmp incx

y1by212:
	mov ax, sp1[0]
	mov bx, sp2[0]
	mov si, sp1[2]
	mov di, sp2[2]
	cmp si, di
	jb sety12
	xchg ax, bx
	xchg si, di

	sety12:
	push ax
	jmp incy
;;13
l13:
    mov ax, sp3[2]
	mov si, sp1[2]
	sub ax, si
	mov bx, sp3[0]
	mov di, sp1[0]
	sub bx, di
	cmp bx, 0
	je y1by213
	xor dx, dx
	cwd
	idiv bx
	mov slope, ax

	cmp ax, -1
	jg x1bx213

	cmp ax, -1
	jl y1by213

x1bx213:
	mov ax, sp1[0]
	mov bx, sp3[0]
	mov si, sp1[2]
	mov di, sp3[2]
	cmp ax, bx
	jb setx13
	xchg ax, bx
	xchg si, di

	setx13:
	push ax
	mov ax, slope
	cmp ax, 1
	jge incy
	jmp incx

y1by213:
	mov ax, sp1[0]
	mov bx, sp3[0]
	mov si, sp1[2]
	mov di, sp3[2]
	cmp si, di
	jb sety13
	xchg ax, bx
	xchg si, di

	sety13:
	push ax
	jmp incy

l14:
    mov ax, sp4[2]
	mov si, sp1[2]
	sub ax, si
	mov bx, sp4[0]
	mov di, sp1[0]
	sub bx, di
	cmp bx, 0
	je y1by214
	xor dx, dx
	cwd
	idiv bx
	mov slope, ax

	cmp ax, -1
	jg x1bx214

	cmp ax, -1
	jl y1by214

x1bx214:
	mov ax, sp1[0]
	mov bx, sp4[0]
	mov si, sp1[2]
	mov di, sp4[2]
	cmp ax, bx
	jb setx14
	xchg ax, bx
	xchg si, di

	setx14:
	push ax
	mov ax, slope
	cmp ax, 1
	jge incy
	jmp incx

y1by214:
	mov ax, sp1[0]
	mov bx, sp4[0]
	mov si, sp1[2]
	mov di, sp4[2]
	cmp si, di
	jb sety14
	xchg ax, bx
	xchg si, di

	sety14:
	push ax
	jmp incy

l26:
    mov ax, sp6[2]
	mov si, sp2[2]
	sub ax, si
	mov bx, sp6[0]
	mov di, sp2[0]
	sub bx, di
	cmp bx, 0
	je y1by226
	xor dx, dx
	cwd
	idiv bx
	mov slope, ax

	cmp ax, -1
	jg x1bx226

	cmp ax, -1
	jl y1by226

x1bx226:
	mov ax, sp2[0]
	mov bx, sp6[0]
	mov si, sp2[2]
	mov di, sp6[2]
	cmp ax, bx
	jb setx26
	xchg ax, bx
	xchg si, di

	setx26:
	push ax
	mov ax, slope
	cmp ax, 1
	jge incy
	jmp incx

y1by226:
	mov ax, sp2[0]
	mov bx, sp6[0]
	mov si, sp2[2]
	mov di, sp6[2]
	cmp si, di
	jb sety26
	xchg ax, bx
	xchg si, di

	sety26:
	push ax
	jmp incy

l27:
    mov ax, sp7[2]
	mov si, sp2[2]
	sub ax, si
	mov bx, sp7[0]
	mov di, sp2[0]
	sub bx, di
	cmp bx, 0
	je y1by227
	xor dx, dx
	cwd
	idiv bx
	mov slope, ax

	cmp ax, -1
	jg x1bx227

	cmp ax, -1
	jl y1by227

x1bx227:
	mov ax, sp2[0]
	mov bx, sp7[0]
	mov si, sp2[2]
	mov di, sp7[2]
	cmp ax, bx
	jb setx27
	xchg ax, bx
	xchg si, di

	setx27:
	push ax
	mov ax, slope
	cmp ax, 1
	jge incy
	jmp incx

y1by227:
	mov ax, sp2[0]
	mov bx, sp7[0]
	mov si, sp2[2]
	mov di, sp7[2]
	cmp si, di
	jb sety27
	xchg ax, bx
	xchg si, di

	sety27:
	push ax
	jmp incy


l37:
    mov ax, sp7[2]
	mov si, sp3[2]
	sub ax, si
	mov bx, sp7[0]
	mov di, sp3[0]
	sub bx, di
	cmp bx, 0
	je y1by237
	xor dx, dx
	cwd
	idiv bx
	mov slope, ax

	cmp ax, -1
	jg x1bx237

	cmp ax, -1
	jl y1by237

x1bx237:
	mov ax, sp3[0]
	mov bx, sp7[0]
	mov si, sp3[2]
	mov di, sp7[2]
	cmp ax, bx
	jb setx37
	xchg ax, bx
	xchg si, di

	setx37:
	push ax
	mov ax, slope
	cmp ax, 1
	jge incy
	jmp incx

y1by237:
	mov ax, sp3[0]
	mov bx, sp7[0]
	mov si, sp3[2]
	mov di, sp7[2]
	cmp si, di
	jb sety37
	xchg ax, bx
	xchg si, di

	sety37:
	push ax
	jmp incy

l35:
    mov ax, sp5[2]
	mov si, sp3[2]
	sub ax, si
	mov bx, sp5[0]
	mov di, sp3[0]
	sub bx, di
	cmp bx, 0
	je y1by235
	xor dx, dx
	cwd
	idiv bx
	mov slope, ax

	cmp ax, -1
	jg x1bx235

	cmp ax, -1
	jl y1by235

x1bx235:
	mov ax, sp3[0]
	mov bx, sp5[0]
	mov si, sp3[2]
	mov di, sp5[2]
	cmp ax, bx
	jb setx35
	xchg ax, bx
	xchg si, di

	setx35:
	push ax
	mov ax, slope
	cmp ax, 1
	jge incy
	jmp incx

y1by235:
	mov ax, sp3[0]
	mov bx, sp5[0]
	mov si, sp3[2]
	mov di, sp5[2]
	cmp si, di
	jb sety35
	xchg ax, bx
	xchg si, di

	sety35:
	push ax
	jmp incy

l45:
    mov ax, sp5[2]
	mov si, sp4[2]
	sub ax, si
	mov bx, sp5[0]
	mov di, sp4[0]
	sub bx, di
	cmp bx, 0
	je y1by245
	xor dx, dx
	cwd
	idiv bx
	mov slope, ax

	cmp ax, -1
	jg x1bx245

	cmp ax, -1
	jl y1by245

x1bx245:
	mov ax, sp4[0]
	mov bx, sp5[0]
	mov si, sp4[2]
	mov di, sp5[2]
	cmp ax, bx
	jb setx45
	xchg ax, bx
	xchg si, di

	setx45:
	push ax
	mov ax, slope
	cmp ax, 1
	jge incy
	jmp incx

y1by245:
	mov ax, sp4[0]
	mov bx, sp5[0]
	mov si, sp4[2]
	mov di, sp5[2]
	cmp si, di
	jb sety45
	xchg ax, bx
	xchg si, di

	sety45:
	push ax
	jmp incy

l46:
    mov ax, sp6[2]
	mov si, sp4[2]
	sub ax, si
	mov bx, sp6[0]
	mov di, sp4[0]
	sub bx, di
	cmp bx, 0
	je y1by246
	xor dx, dx
	cwd
	idiv bx
	mov slope, ax

	cmp ax, -1
	jg x1bx246

	cmp ax, -1
	jl y1by246

x1bx246:
	mov ax, sp4[0]
	mov bx, sp6[0]
	mov si, sp4[2]
	mov di, sp6[2]
	cmp ax, bx
	jb setx46
	xchg ax, bx
	xchg si, di

	setx46:
	push ax
	mov ax, slope
	cmp ax, 1
	jge incy
	jmp incx

y1by246:
	mov ax, sp4[0]
	mov bx, sp6[0]
	mov si, sp4[2]
	mov di, sp6[2]
	cmp si, di
	jb sety46
	xchg ax, bx
	xchg si, di

	sety46:
	push ax
	jmp incy

l68:
    mov ax, sp6[2]
	mov si, sp8[2]
	sub ax, si
	mov bx, sp6[0]
	mov di, sp8[0]
	sub bx, di
	cmp bx, 0
	je y1by286
	xor dx, dx
	cwd
	idiv bx
	mov slope, ax

	cmp ax, -1
	jg x1bx286

	cmp ax, -1
	jl y1by286

x1bx286:
	mov ax, sp8[0]
	mov bx, sp6[0]
	mov si, sp8[2]
	mov di, sp6[2]
	cmp ax, bx
	jb setx86
	xchg ax, bx
	xchg si, di

	setx86:
	push ax
	mov ax, slope
	cmp ax, 1
	jge incy
	jmp incx

y1by286:
	mov ax, sp8[0]
	mov bx, sp6[0]
	mov si, sp8[2]
	mov di, sp6[2]
	cmp si, di
	jb sety86
	xchg ax, bx
	xchg si, di

	sety86:
	push ax
	jmp incy
l58:
    mov ax, sp5[2]
	mov si, sp8[2]
	sub ax, si
	mov bx, sp5[0]
	mov di, sp8[0]
	sub bx, di
	cmp bx, 0
	je y1by285
	xor dx, dx
	cwd
	idiv bx
	mov slope, ax

	cmp ax, -1
	jg x1bx285

	cmp ax, -1
	jl y1by285

x1bx285:
	mov ax, sp8[0]
	mov bx, sp5[0]
	mov si, sp8[2]
	mov di, sp5[2]
	cmp ax, bx
	jb setx85
	xchg ax, bx
	xchg si, di

	setx85:
	push ax
	mov ax, slope
	cmp ax, 1
	jge incy
	jmp incx

y1by285:
	mov ax, sp8[0]
	mov bx, sp5[0]
	mov si, sp8[2]
	mov di, sp5[2]
	cmp si, di
	jb sety85
	xchg ax, bx
	xchg si, di

	sety85:
	push ax
	jmp incy
l78:
    mov ax, sp7[2]
	mov si, sp8[2]
	sub ax, si
	mov bx, sp7[0]
	mov di, sp8[0]
	sub bx, di
	cmp bx, 0
	je y1by287
	xor dx, dx
	cwd
	idiv bx
	mov slope, ax

	cmp ax, -1
	jg x1bx287

	cmp ax, -1
	jl y1by287

x1bx287:
	mov ax, sp8[0]
	mov bx, sp7[0]
	mov si, sp8[2]
	mov di, sp7[2]
	cmp ax, bx
	jb setx87
	xchg ax, bx
	xchg si, di

	setx87:
	push ax
	mov ax, slope
	cmp ax, 1
	jge incy
	jmp incx

y1by287:
	mov ax, sp8[0]
	mov bx, sp7[0]
	mov si, sp8[2]
	mov di, sp7[2]
	cmp si, di
	jb sety87
	xchg ax, bx
	xchg si, di

	sety87:
	push ax
	jmp incy

incx:
	pop ax
	sub bx, ax;bx=(x2-x1)
	sub di, si;di=(y2-y1)
	mov cx, ax;cx=x1
	mov ax, 0
    dec bx
	drawx:
        inc bx
		push ax
		cmp bx, 0
		je Hor
		imul di
		idiv bx
        call round
		jmp NH
		Hor:
			mov ax, 0
		NH:
		add ax, si; si=y1
		push bx
		xor bx, bx
		inc cx
		mov dx, ax
		mov color, 15
		call vmem
		pop bx
		pop ax
		inc ax
        dec bx
		cmp ax, bx
		jne drawx
		jmp done12


incy:
	pop ax
	sub bx, ax;bx=(x2-x1)
	sub di, si;di=(y2-y1)
	mov dx, si;dx=y
	mov si, ax;si=x1
	mov ax, 0
    dec di
	drawy:
        inc di
		push ax
		push dx
		cmp di, 0
		je Ver
        xchg bx, di
		imul di
		idiv bx
        call round
        xchg bx, di
		jmp NV
		Ver:
			mov ax, 0
		NV:
		add ax, si
		pop dx
		push bx
		xor bx, bx
		mov cx, ax
		inc dx
		mov color, 15
		call vmem
		pop bx
		pop ax
		inc ax
        dec di
		cmp ax, di
		jne drawy

done12:
    inc word ptr countline
    cmp word ptr countline, 0
    je l12
    cmp word ptr countline, 1
    je l13
    cmp word ptr countline, 2
    je l14
    cmp word ptr countline, 3
    je l26
    cmp word ptr countline, 4
    je l27
    cmp word ptr countline, 5
    je l37
    cmp word ptr countline, 6
    je l35
    cmp word ptr countline, 7
    je l45
    cmp word ptr countline, 8
    je l46
    cmp word ptr countline, 9
    je l68
    cmp word ptr countline, 10
    je l58
    cmp word ptr countline, 11
    je l78
    
    jmp ipt

exit:
    mov ax, 0003h
    int 10h

    mov ax, 4c00h
    int 21h

main ENDP
end main        