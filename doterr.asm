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

	P12 dw 3 Dup(?)
	P13 dw 3 Dup(?)
	P14 dw 3 Dup(?)
	P26 dw 3 Dup(?)
	P27 dw 3 Dup(?)
	P35 dw 3 Dup(?)
	P37 dw 3 Dup(?)
	P45 dw 3 Dup(?)
	P46 dw 3 Dup(?)
	P58 dw 3 Dup(?)
	P68 dw 3 Dup(?)
	P78 dw 3 Dup(?)

	P24 dw 3 Dup(?)
	P15 dw 3 Dup(?)
	P38 dw 3 Dup(?)
	P28 dw 3 Dup(?)
	P56 dw 3 Dup(?)
	P23 dw 3 Dup(?)

	;vector from perspective point to face middle point
	vP24 dw 3 Dup(?)
	vP15 dw 3 Dup(?)
	vP38 dw 3 Dup(?)
	vP28 dw 3 Dup(?)
	vP56 dw 3 Dup(?)
	vP23 dw 3 Dup(?)

	;normal vector of faces
	N1237 dw 100,  0,  0
	N1246 dw 0,  100,  0
	N1345 dw 0,  0,  100
	N2678 dw 0,  0, -100
	N3578 dw 0, -100,  0
	N4568 dw -100, 0,  0
	;normal vector after rotation
	Nr1237 dw 3 Dup(?)
	Nr1246 dw 3 Dup(?)
	Nr1345 dw 3 Dup(?)
	Nr2678 dw 3 Dup(?)
	Nr3578 dw 3 Dup(?)
	Nr4568 dw 3 Dup(?)
	

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

	
	; middle of the line
	sp12 dw 2 Dup(?)
	sp13 dw 2 Dup(?)
	sp14 dw 2 Dup(?)
	sp26 dw 2 Dup(?)
	sp27 dw 2 Dup(?)
	sp35 dw 2 Dup(?)
	sp37 dw 2 Dup(?)
	sp45 dw 2 Dup(?)
	sp46 dw 2 Dup(?)
	sp58 dw 2 Dup(?)
	sp68 dw 2 Dup(?)
	sp78 dw 2 Dup(?)
	
	; middle of the face
	sp23 dw 2 Dup(?)
	sp24 dw 2 Dup(?)
	sp56 dw 2 Dup(?)
	sp38 dw 2 Dup(?)
	sp15 dw 2 Dup(?)
	sp28 dw 2 Dup(?)
	
	Pp dw 320, 0, 240 ;perspective point

	scr dw 500 ;y coordinate of screen

    color db 0; 0black 1blue(9) 2green(10) 4red(12) 6brown 7gray 14yellow 15white (light color)  
    lineyn db 8 Dup(?)
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

	;Nr1237=N1237*R
    mov ax, N1237[0]
    mov Nr1237[0], ax
    ;
    mov ax, thetax
    call cos
    mov dx, N1237[2]
    imul dx
    mov bx, dx
    mov cx, ax
    mov ax, thetax
    call sin
    neg ax
    mov dx, N1237[4]
    imul dx
    call EXadd
    mov bx, 5000
    idiv bx
    call round
    mov Nr1237[2], ax
    ;
    mov ax, thetax
    call sin
    mov dx, N1237[2]
    imul dx
    mov bx, dx
    mov cx, ax
    mov ax, thetax
    call cos
    mov dx, N1237[4]
    imul dx
    call EXadd
    mov bx, 5000
    idiv bx
    call round
    mov Nr1237[4], ax
    ;;;
    mov ax, thetay
    call cos
    mov dx, Nr1237[0]
    imul dx
    mov bx, dx
    mov cx, ax
    mov ax, thetay
    call sin 
    mov dx, Nr1237[4]
    imul dx
    call EXadd
    mov bx, 5000
    idiv bx
    call round
    push ax ;
    ;
    ;Ryy=Rxy
    ;
    mov ax, thetay
    call sin
    neg ax
    mov dx, Nr1237[0]
    imul dx
    mov bx, dx
    mov cx, ax
    mov ax, thetay
    call cos
    mov dx, Nr1237[4]
    imul dx
    call EXadd
    mov bx, 5000
    idiv bx
    call round
    mov Nr1237[4], ax
    pop ax
    mov Nr1237[0], ax
    ;;;
    mov ax, thetaz
    call cos
    mov dx, Nr1237[0]
    imul dx
    mov bx, dx
    mov cx, ax
    mov ax, thetaz
    call sin 
    neg ax
    mov dx, Nr1237[2]
    imul dx
    call EXadd
    mov bx, 5000
    idiv bx
    call round
    push ax
    ;
    mov ax, thetaz
    call sin
    mov dx, Nr1237[0]
    imul dx
    mov bx, dx
    mov cx, ax
    mov ax, thetaz
    call cos
    mov dx, Nr1237[2]
    imul dx
    call EXadd
    mov bx, 5000
    idiv bx
    call round
    mov Nr1237[2], ax
    pop ax
    mov Nr1237[0], ax
    ;
    ;Rzz=Ryz

	;Nr1246=N1246*R
    mov ax, N1246[0]
    mov Nr1246[0], ax
    ;
    mov ax, thetax
    call cos
    mov dx, N1246[2]
    imul dx
    mov bx, dx
    mov cx, ax
    mov ax, thetax
    call sin
    neg ax
    mov dx, N1246[4]
    imul dx
    call EXadd
    mov bx, 5000
    idiv bx
    call round
    mov Nr1246[2], ax
    ;
    mov ax, thetax
    call sin
    mov dx, N1246[2]
    imul dx
    mov bx, dx
    mov cx, ax
    mov ax, thetax
    call cos
    mov dx, N1246[4]
    imul dx
    call EXadd
    mov bx, 5000
    idiv bx
    call round
    mov Nr1246[4], ax
    ;;;
    mov ax, thetay
    call cos
    mov dx, Nr1246[0]
    imul dx
    mov bx, dx
    mov cx, ax
    mov ax, thetay
    call sin 
    mov dx, Nr1246[4]
    imul dx
    call EXadd
    mov bx, 5000
    idiv bx
    call round
    push ax ;
    ;
    ;Ryy=Rxy
    ;
    mov ax, thetay
    call sin
    neg ax
    mov dx, Nr1246[0]
    imul dx
    mov bx, dx
    mov cx, ax
    mov ax, thetay
    call cos
    mov dx, Nr1246[4]
    imul dx
    call EXadd
    mov bx, 5000
    idiv bx
    call round
    mov Nr1246[4], ax
    pop ax
    mov Nr1246[0], ax
    ;;;
    mov ax, thetaz
    call cos
    mov dx, Nr1246[0]
    imul dx
    mov bx, dx
    mov cx, ax
    mov ax, thetaz
    call sin 
    neg ax
    mov dx, Nr1246[2]
    imul dx
    call EXadd
    mov bx, 5000
    idiv bx
    call round
    push ax
    ;
    mov ax, thetaz
    call sin
    mov dx, Nr1246[0]
    imul dx
    mov bx, dx
    mov cx, ax
    mov ax, thetaz
    call cos
    mov dx, Nr1246[2]
    imul dx
    call EXadd
    mov bx, 5000
    idiv bx
    call round
    mov Nr1246[2], ax
    pop ax
    mov Nr1246[0], ax
    ;
    ;Rzz=Ryz

	;Nr1345=N1345*R
    mov ax, N1345[0]
    mov Nr1345[0], ax
    ;
    mov ax, thetax
    call cos
    mov dx, N1345[2]
    imul dx
    mov bx, dx
    mov cx, ax
    mov ax, thetax
    call sin
    neg ax
    mov dx, N1345[4]
    imul dx
    call EXadd
    mov bx, 5000
    idiv bx
    call round
    mov Nr1345[2], ax
    ;
    mov ax, thetax
    call sin
    mov dx, N1345[2]
    imul dx
    mov bx, dx
    mov cx, ax
    mov ax, thetax
    call cos
    mov dx, N1345[4]
    imul dx
    call EXadd
    mov bx, 5000
    idiv bx
    call round
    mov Nr1345[4], ax
    ;;;
    mov ax, thetay
    call cos
    mov dx, Nr1345[0]
    imul dx
    mov bx, dx
    mov cx, ax
    mov ax, thetay
    call sin 
    mov dx, Nr1345[4]
    imul dx
    call EXadd
    mov bx, 5000
    idiv bx
    call round
    push ax ;
    ;
    ;Ryy=Rxy
    ;
    mov ax, thetay
    call sin
    neg ax
    mov dx, Nr1345[0]
    imul dx
    mov bx, dx
    mov cx, ax
    mov ax, thetay
    call cos
    mov dx, Nr1345[4]
    imul dx
    call EXadd
    mov bx, 5000
    idiv bx
    call round
    mov Nr1345[4], ax
    pop ax
    mov Nr1345[0], ax
    ;;;
    mov ax, thetaz
    call cos
    mov dx, Nr1345[0]
    imul dx
    mov bx, dx
    mov cx, ax
    mov ax, thetaz
    call sin 
    neg ax
    mov dx, Nr1345[2]
    imul dx
    call EXadd
    mov bx, 5000
    idiv bx
    call round
    push ax
    ;
    mov ax, thetaz
    call sin
    mov dx, Nr1345[0]
    imul dx
    mov bx, dx
    mov cx, ax
    mov ax, thetaz
    call cos
    mov dx, Nr1345[2]
    imul dx
    call EXadd
    mov bx, 5000
    idiv bx
    call round
    mov Nr1345[2], ax
    pop ax
    mov Nr1345[0], ax
    ;
    ;Rzz=Ryz

	;Nr1237=N1237*R
    mov ax, N2678[0]
    mov Nr2678[0], ax
    ;
    mov ax, thetax
    call cos
    mov dx, N2678[2]
    imul dx
    mov bx, dx
    mov cx, ax
    mov ax, thetax
    call sin
    neg ax
    mov dx, N2678[4]
    imul dx
    call EXadd
    mov bx, 5000
    idiv bx
    call round
    mov Nr2678[2], ax
    ;
    mov ax, thetax
    call sin
    mov dx, N2678[2]
    imul dx
    mov bx, dx
    mov cx, ax
    mov ax, thetax
    call cos
    mov dx, N2678[4]
    imul dx
    call EXadd
    mov bx, 5000
    idiv bx
    call round
    mov Nr2678[4], ax
    ;;;
    mov ax, thetay
    call cos
    mov dx, Nr2678[0]
    imul dx
    mov bx, dx
    mov cx, ax
    mov ax, thetay
    call sin 
    mov dx, Nr2678[4]
    imul dx
    call EXadd
    mov bx, 5000
    idiv bx
    call round
    push ax ;
    ;
    ;Ryy=Rxy
    ;
    mov ax, thetay
    call sin
    neg ax
    mov dx, Nr2678[0]
    imul dx
    mov bx, dx
    mov cx, ax
    mov ax, thetay
    call cos
    mov dx, Nr2678[4]
    imul dx
    call EXadd
    mov bx, 5000
    idiv bx
    call round
    mov Nr2678[4], ax
    pop ax
    mov Nr2678[0], ax
    ;;;
    mov ax, thetaz
    call cos
    mov dx, Nr2678[0]
    imul dx
    mov bx, dx
    mov cx, ax
    mov ax, thetaz
    call sin 
    neg ax
    mov dx, Nr2678[2]
    imul dx
    call EXadd
    mov bx, 5000
    idiv bx
    call round
    push ax
    ;
    mov ax, thetaz
    call sin
    mov dx, Nr2678[0]
    imul dx
    mov bx, dx
    mov cx, ax
    mov ax, thetaz
    call cos
    mov dx, Nr2678[2]
    imul dx
    call EXadd
    mov bx, 5000
    idiv bx
    call round
    mov Nr2678[2], ax
    pop ax
    mov Nr2678[0], ax
    ;
    ;Rzz=Ryz

	;Nr4568=N4568*R
    mov ax, N4568[0]
    mov Nr4568[0], ax
    ;
    mov ax, thetax
    call cos
    mov dx, N4568[2]
    imul dx
    mov bx, dx
    mov cx, ax
    mov ax, thetax
    call sin
    neg ax
    mov dx, N4568[4]
    imul dx
    call EXadd
    mov bx, 5000
    idiv bx
    call round
    mov Nr4568[2], ax
    ;
    mov ax, thetax
    call sin
    mov dx, N4568[2]
    imul dx
    mov bx, dx
    mov cx, ax
    mov ax, thetax
    call cos
    mov dx, N4568[4]
    imul dx
    call EXadd
    mov bx, 5000
    idiv bx
    call round
    mov Nr4568[4], ax
    ;;;
    mov ax, thetay
    call cos
    mov dx, Nr4568[0]
    imul dx
    mov bx, dx
    mov cx, ax
    mov ax, thetay
    call sin 
    mov dx, Nr4568[4]
    imul dx
    call EXadd
    mov bx, 5000
    idiv bx
    call round
    push ax ;
    ;
    ;Ryy=Rxy
    ;
    mov ax, thetay
    call sin
    neg ax
    mov dx, Nr4568[0]
    imul dx
    mov bx, dx
    mov cx, ax
    mov ax, thetay
    call cos
    mov dx, Nr4568[4]
    imul dx
    call EXadd
    mov bx, 5000
    idiv bx
    call round
    mov Nr4568[4], ax
    pop ax
    mov Nr4568[0], ax
    ;;;
    mov ax, thetaz
    call cos
    mov dx, Nr4568[0]
    imul dx
    mov bx, dx
    mov cx, ax
    mov ax, thetaz
    call sin 
    neg ax
    mov dx, Nr4568[2]
    imul dx
    call EXadd
    mov bx, 5000
    idiv bx
    call round
    push ax
    ;
    mov ax, thetaz
    call sin
    mov dx, Nr4568[0]
    imul dx
    mov bx, dx
    mov cx, ax
    mov ax, thetaz
    call cos
    mov dx, Nr4568[2]
    imul dx
    call EXadd
    mov bx, 5000
    idiv bx
    call round
    mov Nr4568[2], ax
    pop ax
    mov Nr4568[0], ax
    ;
    ;Rzz=Ryz

	;Nr3578=N3578*R
    mov ax, N3578[0]
    mov Nr3578[0], ax
    ;
    mov ax, thetax
    call cos
    mov dx, N3578[2]
    imul dx
    mov bx, dx
    mov cx, ax
    mov ax, thetax
    call sin
    neg ax
    mov dx, N3578[4]
    imul dx
    call EXadd
    mov bx, 5000
    idiv bx
    call round
    mov Nr3578[2], ax
    ;
    mov ax, thetax
    call sin
    mov dx, N3578[2]
    imul dx
    mov bx, dx
    mov cx, ax
    mov ax, thetax
    call cos
    mov dx, N3578[4]
    imul dx
    call EXadd
    mov bx, 5000
    idiv bx
    call round
    mov Nr3578[4], ax
    ;;;
    mov ax, thetay
    call cos
    mov dx, Nr3578[0]
    imul dx
    mov bx, dx
    mov cx, ax
    mov ax, thetay
    call sin 
    mov dx, Nr3578[4]
    imul dx
    call EXadd
    mov bx, 5000
    idiv bx
    call round
    push ax ;
    ;
    ;Ryy=Rxy
    ;
    mov ax, thetay
    call sin
    neg ax
    mov dx, Nr3578[0]
    imul dx
    mov bx, dx
    mov cx, ax
    mov ax, thetay
    call cos
    mov dx, Nr3578[4]
    imul dx
    call EXadd
    mov bx, 5000
    idiv bx
    call round
    mov Nr3578[4], ax
    pop ax
    mov Nr3578[0], ax
    ;;;
    mov ax, thetaz
    call cos
    mov dx, Nr3578[0]
    imul dx
    mov bx, dx
    mov cx, ax
    mov ax, thetaz
    call sin 
    neg ax
    mov dx, Nr3578[2]
    imul dx
    call EXadd
    mov bx, 5000
    idiv bx
    call round
    push ax
    ;
    mov ax, thetaz
    call sin
    mov dx, Nr3578[0]
    imul dx
    mov bx, dx
    mov cx, ax
    mov ax, thetaz
    call cos
    mov dx, Nr3578[2]
    imul dx
    call EXadd
    mov bx, 5000
    idiv bx
    call round
    mov Nr3578[2], ax
    pop ax
    mov Nr3578[0], ax
    ;
    ;Rzz=Ryz
	


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

	;update middle point
	;P23=(P2+P3)/2
	mov cx, 2
	xor dx, dx
	mov ax, P2[0]
	mov bx, P3[0]
	add ax, bx
	idiv cx
	mov P23[0], ax
	xor dx, dx
	mov ax, P2[2]
	mov bx, P3[2]
	add ax, bx
	idiv cx
	mov P23[2], ax
	xor dx, dx
	mov ax, P2[4]
	mov bx, P3[4]
	add ax, bx
	idiv cx
	mov P23[4], ax
	;P24=(P2+P4)/2
	xor dx, dx
	mov ax, P2[0]
	mov bx, P4[0]
	add ax, bx
	idiv cx
	mov P24[0], ax
	xor dx, dx
	mov ax, P2[2]
	mov bx, P4[2]
	add ax, bx
	idiv cx
	mov P24[2], ax
	xor dx, dx
	mov ax, P2[4]
	mov bx, P4[4]
	add ax, bx
	idiv cx
	mov P24[4], ax
	;P28=(P2+P8)/2
	xor dx, dx
	mov ax, P2[0]
	mov bx, P8[0]
	add ax, bx
	idiv cx
	mov P28[0], ax
	xor dx, dx
	mov ax, P2[2]
	mov bx, P8[2]
	add ax, bx
	idiv cx
	mov P28[2], ax
	xor dx, dx
	mov ax, P2[4]
	mov bx, P8[4]
	add ax, bx
	idiv cx
	mov P28[4], ax
	;P38=(P3+P8)/2
	xor dx, dx
	mov ax, P3[0]
	mov bx, P8[0]
	add ax, bx
	idiv cx
	mov P38[0], ax
	xor dx, dx
	mov ax, P3[2]
	mov bx, P8[2]
	add ax, bx
	idiv cx
	mov P38[2], ax
	xor dx, dx
	mov ax, P3[4]
	mov bx, P8[4]
	add ax, bx
	idiv cx
	mov P38[4], ax
	;P15=(P1+P5)/2
	xor dx, dx
	mov ax, P1[0]
	mov bx, P5[0]
	add ax, bx
	idiv cx
	mov P15[0], ax
	xor dx, dx
	mov ax, P1[2]
	mov bx, P5[2]
	add ax, bx
	idiv cx
	mov P15[2], ax
	xor dx, dx
	mov ax, P1[4]
	mov bx, P5[4]
	add ax, bx
	idiv cx
	mov P15[4], ax
	;P56=(P5+P6)/2
	xor dx, dx
	mov ax, P5[0]
	mov bx, P6[0]
	add ax, bx
	idiv cx
	mov P56[0], ax
	xor dx, dx
	mov ax, P5[2]
	mov bx, P6[2]
	add ax, bx
	idiv cx
	mov P56[2], ax
	xor dx, dx
	mov ax, P5[4]
	mov bx, P6[4]
	add ax, bx
	idiv cx
	mov P56[4], ax
;;new added
	mov cx, 2
	xor dx, dx
	mov ax, P1[0]
	mov bx, P2[0]
	add ax, bx
	idiv cx
	mov P12[0], ax
	xor dx, dx
	mov ax, P1[2]
	mov bx, P2[2]
	add ax, bx
	idiv cx
	mov P12[2], ax
	xor dx, dx
	mov ax, P1[4]
	mov bx, P2[4]
	add ax, bx
	idiv cx
	mov P12[4], ax

	mov cx, 2
	xor dx, dx
	mov ax, P1[0]
	mov bx, P3[0]
	add ax, bx
	idiv cx
	mov P13[0], ax
	xor dx, dx
	mov ax, P1[2]
	mov bx, P3[2]
	add ax, bx
	idiv cx
	mov P13[2], ax
	xor dx, dx
	mov ax, P1[4]
	mov bx, P3[4]
	add ax, bx
	idiv cx
	mov P13[4], ax

	mov cx, 2
	xor dx, dx
	mov ax, P1[0]
	mov bx, P4[0]
	add ax, bx
	idiv cx
	mov P14[0], ax
	xor dx, dx
	mov ax, P1[2]
	mov bx, P4[2]
	add ax, bx
	idiv cx
	mov P14[2], ax
	xor dx, dx
	mov ax, P1[4]
	mov bx, P4[4]
	add ax, bx
	idiv cx
	mov P14[4], ax

	mov cx, 2
	xor dx, dx
	mov ax, P2[0]
	mov bx, P6[0]
	add ax, bx
	idiv cx
	mov P26[0], ax
	xor dx, dx
	mov ax, P2[2]
	mov bx, P6[2]
	add ax, bx
	idiv cx
	mov P26[2], ax
	xor dx, dx
	mov ax, P2[4]
	mov bx, P6[4]
	add ax, bx
	idiv cx
	mov P26[4], ax

	mov cx, 2
	xor dx, dx
	mov ax, P2[0]
	mov bx, P7[0]
	add ax, bx
	idiv cx
	mov P27[0], ax
	xor dx, dx
	mov ax, P2[2]
	mov bx, P7[2]
	add ax, bx
	idiv cx
	mov P27[2], ax
	xor dx, dx
	mov ax, P2[4]
	mov bx, P7[4]
	add ax, bx
	idiv cx
	mov P27[4], ax

	mov cx, 2
	xor dx, dx
	mov ax, P5[0]
	mov bx, P3[0]
	add ax, bx
	idiv cx
	mov P35[0], ax
	xor dx, dx
	mov ax, P5[2]
	mov bx, P3[2]
	add ax, bx
	idiv cx
	mov P35[2], ax
	xor dx, dx
	mov ax, P5[4]
	mov bx, P3[4]
	add ax, bx
	idiv cx
	mov P35[4], ax

	mov cx, 2
	xor dx, dx
	mov ax, P7[0]
	mov bx, P3[0]
	add ax, bx
	idiv cx
	mov P37[0], ax
	xor dx, dx
	mov ax, P7[2]
	mov bx, P3[2]
	add ax, bx
	idiv cx
	mov P37[2], ax
	xor dx, dx
	mov ax, P7[4]
	mov bx, P3[4]
	add ax, bx
	idiv cx
	mov P37[4], ax

	mov cx, 2
	xor dx, dx
	mov ax, P4[0]
	mov bx, P5[0]
	add ax, bx
	idiv cx
	mov P45[0], ax
	xor dx, dx
	mov ax, P4[2]
	mov bx, P5[2]
	add ax, bx
	idiv cx
	mov P45[2], ax
	xor dx, dx
	mov ax, P4[4]
	mov bx, P5[4]
	add ax, bx
	idiv cx
	mov P45[4], ax

	mov cx, 2
	xor dx, dx
	mov ax, P4[0]
	mov bx, P6[0]
	add ax, bx
	idiv cx
	mov P46[0], ax
	xor dx, dx
	mov ax, P4[2]
	mov bx, P6[2]
	add ax, bx
	idiv cx
	mov P46[2], ax
	xor dx, dx
	mov ax, P4[4]
	mov bx, P6[4]
	add ax, bx
	idiv cx
	mov P46[4], ax

	mov cx, 2
	xor dx, dx
	mov ax, P5[0]
	mov bx, P8[0]
	add ax, bx
	idiv cx
	mov P58[0], ax
	xor dx, dx
	mov ax, P5[2]
	mov bx, P8[2]
	add ax, bx
	idiv cx
	mov P58[2], ax
	xor dx, dx
	mov ax, P5[4]
	mov bx, P8[4]
	add ax, bx
	idiv cx
	mov P58[4], ax

	mov cx, 2
	xor dx, dx
	mov ax, P6[0]
	mov bx, P8[0]
	add ax, bx
	idiv cx
	mov P68[0], ax
	xor dx, dx
	mov ax, P6[2]
	mov bx, P8[2]
	add ax, bx
	idiv cx
	mov P68[2], ax
	xor dx, dx
	mov ax, P6[4]
	mov bx, P8[4]
	add ax, bx
	idiv cx
	mov P68[4], ax

	mov cx, 2
	xor dx, dx
	mov ax, P7[0]
	mov bx, P8[0]
	add ax, bx
	idiv cx
	mov P78[0], ax
	xor dx, dx
	mov ax, P7[2]
	mov bx, P8[2]
	add ax, bx
	idiv cx
	mov P78[2], ax
	xor dx, dx
	mov ax, P7[4]
	mov bx, P8[4]
	add ax, bx
	idiv cx
	mov P78[4], ax
;;new added

	;updata vp (vector from perspective point to face middle point)
	;vP15
	mov ax, P15[0]
	mov bx, Pp[0]
	sub ax, bx
	mov vP15[0], ax
	mov ax, P15[2]
	mov bx, Pp[2]
	sub ax, bx
	mov vP15[2], ax
	mov ax, P15[4]
	mov bx, Pp[4]
	sub ax, bx
	mov vP15[4], ax
	;vP23
	mov ax, P23[0]
	mov bx, Pp[0]
	sub ax, bx
	mov vP23[0], ax
	mov ax, P23[2]
	mov bx, Pp[2]
	sub ax, bx
	mov vP23[2], ax
	mov ax, P23[4]
	mov bx, Pp[4]
	sub ax, bx
	mov vP23[4], ax
	;vP24
	mov ax, P24[0]
	mov bx, Pp[0]
	sub ax, bx
	mov vP24[0], ax
	mov ax, P24[2]
	mov bx, Pp[2]
	sub ax, bx
	mov vP24[2], ax
	mov ax, P24[4]
	mov bx, Pp[4]
	sub ax, bx
	mov vP24[4], ax
	;vP28
	mov ax, P28[0]
	mov bx, Pp[0]
	sub ax, bx
	mov vP28[0], ax
	mov ax, P28[2]
	mov bx, Pp[2]
	sub ax, bx
	mov vP28[2], ax
	mov ax, P28[4]
	mov bx, Pp[4]
	sub ax, bx
	mov vP28[4], ax
	;vP38
	mov ax, P38[0]
	mov bx, Pp[0]
	sub ax, bx
	mov vP38[0], ax
	mov ax, P38[2]
	mov bx, Pp[2]
	sub ax, bx
	mov vP38[2], ax
	mov ax, P38[4]
	mov bx, Pp[4]
	sub ax, bx
	mov vP38[4], ax
	;vP56
	mov ax, P56[0]
	mov bx, Pp[0]
	sub ax, bx
	mov vP56[0], ax
	mov ax, P56[2]
	mov bx, Pp[2]
	sub ax, bx
	mov vP56[2], ax
	mov ax, P56[4]
	mov bx, Pp[4]
	sub ax, bx
	mov vP56[4], ax

	;inner product of vP and Nr >0 show, vice versa



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

;;new added
	; middle point

	mov ax, P12[0]
	sub ax, Pp[0]
	mov vp[0], ax
	mov ax, P12[2]
	sub ax, Pp[2]
	mov vp[2], ax
	mov ax, P12[4]
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
	mov sp12[0], ax

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
	mov sp12[2], ax
	;13
	mov ax, P13[0]
	sub ax, Pp[0]
	mov vp[0], ax
	mov ax, P13[2]
	sub ax, Pp[2]
	mov vp[2], ax
	mov ax, P13[4]
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
	mov sp13[0], ax

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
	mov sp13[2], ax
	;14
	mov ax, P14[0]
	sub ax, Pp[0]
	mov vp[0], ax
	mov ax, P14[2]
	sub ax, Pp[2]
	mov vp[2], ax
	mov ax, P14[4]
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
	mov sp14[0], ax

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
	mov sp14[2], ax
	;26
	mov ax, P26[0]
	sub ax, Pp[0]
	mov vp[0], ax
	mov ax, P26[2]
	sub ax, Pp[2]
	mov vp[2], ax
	mov ax, P26[4]
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
	mov sp26[0], ax

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
	mov sp26[2], ax
	;27
	mov ax, P27[0]
	sub ax, Pp[0]
	mov vp[0], ax
	mov ax, P27[2]
	sub ax, Pp[2]
	mov vp[2], ax
	mov ax, P27[4]
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
	mov sp27[0], ax

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
	mov sp27[2], ax
	;35
	mov ax, P35[0]
	sub ax, Pp[0]
	mov vp[0], ax
	mov ax, P35[2]
	sub ax, Pp[2]
	mov vp[2], ax
	mov ax, P35[4]
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
	mov sp35[0], ax

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
	mov sp35[2], ax
	;37
	mov ax, P37[0]
	sub ax, Pp[0]
	mov vp[0], ax
	mov ax, P37[2]
	sub ax, Pp[2]
	mov vp[2], ax
	mov ax, P37[4]
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
	mov sp37[0], ax

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
	mov sp37[2], ax
	;45
	mov ax, P45[0]
	sub ax, Pp[0]
	mov vp[0], ax
	mov ax, P45[2]
	sub ax, Pp[2]
	mov vp[2], ax
	mov ax, P45[4]
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
	mov sp45[0], ax

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
	mov sp45[2], ax
	;46
	mov ax, P46[0]
	sub ax, Pp[0]
	mov vp[0], ax
	mov ax, P46[2]
	sub ax, Pp[2]
	mov vp[2], ax
	mov ax, P46[4]
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
	mov sp46[0], ax

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
	mov sp46[2], ax
	;58
	mov ax, P58[0]
	sub ax, Pp[0]
	mov vp[0], ax
	mov ax, P58[2]
	sub ax, Pp[2]
	mov vp[2], ax
	mov ax, P58[4]
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
	mov sp58[0], ax

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
	mov sp58[2], ax
	;68
	mov ax, P68[0]
	sub ax, Pp[0]
	mov vp[0], ax
	mov ax, P68[2]
	sub ax, Pp[2]
	mov vp[2], ax
	mov ax, P68[4]
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
	mov sp68[0], ax

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
	mov sp68[2], ax
	;78
	mov ax, P78[0]
	sub ax, Pp[0]
	mov vp[0], ax
	mov ax, P78[2]
	sub ax, Pp[2]
	mov vp[2], ax
	mov ax, P78[4]
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
	mov sp78[0], ax

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
	mov sp78[2], ax
	;;;23
	mov ax, P23[0]
	sub ax, Pp[0]
	mov vp[0], ax
	mov ax, P23[2]
	sub ax, Pp[2]
	mov vp[2], ax
	mov ax, P23[4]
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
	mov sp23[0], ax

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
	mov sp23[2], ax
	;24
	mov ax, P24[0]
	sub ax, Pp[0]
	mov vp[0], ax
	mov ax, P24[2]
	sub ax, Pp[2]
	mov vp[2], ax
	mov ax, P24[4]
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
	mov sp24[0], ax

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
	mov sp24[2], ax
	;56
	mov ax, P56[0]
	sub ax, Pp[0]
	mov vp[0], ax
	mov ax, P56[2]
	sub ax, Pp[2]
	mov vp[2], ax
	mov ax, P56[4]
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
	mov sp56[0], ax

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
	mov sp56[2], ax
	;38
	mov ax, P38[0]
	sub ax, Pp[0]
	mov vp[0], ax
	mov ax, P38[2]
	sub ax, Pp[2]
	mov vp[2], ax
	mov ax, P38[4]
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
	mov sp38[0], ax

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
	mov sp38[2], ax
	;15
	mov ax, P15[0]
	sub ax, Pp[0]
	mov vp[0], ax
	mov ax, P15[2]
	sub ax, Pp[2]
	mov vp[2], ax
	mov ax, P15[4]
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
	mov sp15[0], ax

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
	mov sp15[2], ax
	;28
	mov ax, P28[0]
	sub ax, Pp[0]
	mov vp[0], ax
	mov ax, P28[2]
	sub ax, Pp[2]
	mov vp[2], ax
	mov ax, P28[4]
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
	mov sp28[0], ax

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
	mov sp28[2], ax
;;new added

	

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

	mov cx, sp23[0]
	mov dx, sp23[2]
    mov color, 14
    call vmem
	mov cx, sp24[0]
	mov dx, sp24[2]
    mov color, 14
    call vmem
	mov cx, sp56[0]
	mov dx, sp56[2]
    mov color, 14
    call vmem
	mov cx, sp38[0]
	mov dx, sp38[2]
    mov color, 14
    call vmem
	mov cx, sp15[0]
	mov dx, sp15[2]
    mov color, 14
    call vmem
	mov cx, sp28[0]
	mov dx, sp28[2]
    mov color, 14
    call vmem

	


    mov countline, 0
    ;draw line
	jmp doneline
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
    cmp dx, 0
    je skip12
    cmp ax, -1
    jne skip12
    dec ax
skip12:
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
    cmp dx, 0
    je skip13
    cmp ax, -1
    jne skip13
    dec ax
skip13:
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
    cmp dx, 0
    je skip14
    cmp ax, -1
    jne skip14
    dec ax
skip14:    
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
    cmp dx, 0
    je skip26
    cmp ax, -1
    jne skip26
    dec ax
skip26:    
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
    cmp dx, 0
    je skip27
    cmp ax, -1
    jne skip27
    dec ax
skip27:    
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
    cmp dx, 0
    je skip37
    cmp ax, -1
    jne skip37
    dec ax
skip37:    
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
    cmp dx, 0
    je skip35
    cmp ax, -1
    jne skip35
    dec ax
skip35:
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
    cmp dx, 0
    je skip45
    cmp ax, -1
    jne skip45
    dec ax
skip45:    
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
    cmp dx, 0
    je skip46
    cmp ax, -1
    jne skip46
    dec ax
skip46:    
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
    cmp dx, 0
    je skip68
    cmp ax, -1
    jne skip68
    dec ax
skip68:    
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
    cmp dx, 0
    je skip58
    cmp ax, -1
    jne skip58
    dec ax
skip58:    
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
    cmp dx, 0
    je skip78
    cmp ax, -1
    jne skip78
    dec ax
skip78:    
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
;;;;;;;;;;

;;;;;;;;;;


incx:
	pop ax
	sub bx, ax;bx=(x2-x1)
	sub di, si;di=(y2-y1)
	mov cx, ax;cx=x1
	mov ax, 0
	drawx:
		push ax
		cmp bx, 0
		je Hor
		imul di
		idiv bx
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
        ;widen
        inc cx
        call vmem
        dec cx

        dec cx
        call vmem
        inc cx

        inc dx
        call vmem
        dec dx

        dec dx
        call vmem
        inc dx

		pop bx
		pop ax
		inc ax
		cmp ax, bx
		jne drawx
		jmp doneline


incy:
	pop ax
	sub bx, ax;bx=(x2-x1)
	sub di, si;di=(y2-y1)
	mov dx, si;dx=y
	mov si, ax;si=x1
	mov ax, 0
	drawy:
		push ax
		push dx
		cmp di, 0
		je Ver

		imul bx
		idiv di
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
        ;widen
        inc cx
        call vmem
        dec cx

        dec cx
        call vmem
        inc cx

        inc dx
        call vmem
        dec dx

        dec dx
        call vmem
        inc dx

		pop bx
		pop ax
		inc ax
		cmp ax, di
		jne drawy

doneline:
    inc word ptr countline
	;inner product of vP and Nr >0 show, vice versa
	;check adjacent face 1, jmp s if greater than 0
	;check adjacent face 2, jmp s if greater than 0
	;jmp next line
	c12:
	cmp word ptr countline, 1
	jne c13
	mov ax, vP23[0]
	mov dx, Nr1237[0]
	imul dx
	mov bx, dx
	mov cx, ax
	mov ax, vP23[2]
	mov dx, Nr1237[2]
	imul dx
	call EXadd
	mov bx, dx
	mov cx, ax
	mov ax, vP23[4]
	mov dx, Nr1237[4]
	imul dx
	call EXadd
	cmp dx, 0
	jl s12

	mov ax, vP24[0]
	mov dx, Nr1246[0]
	imul dx
	mov bx, dx
	mov cx, ax
	mov ax, vP24[2]
	mov dx, Nr1246[2]
	imul dx
	call EXadd
	mov bx, dx
	mov cx, ax
	mov ax, vP24[4]
	mov dx, Nr1246[4]
	imul dx
	call EXadd
	cmp dx, 0
	jl s12
	jmp doneline
	s12:
    cmp word ptr countline, 1
    je l12
	c13:
	cmp word ptr countline, 2
	jne c14
	mov ax, vP23[0]
	mov dx, Nr1237[0]
	imul dx
	mov bx, dx
	mov cx, ax
	mov ax, vP23[2]
	mov dx, Nr1237[2]
	imul dx
	call EXadd
	mov bx, dx
	mov cx, ax
	mov ax, vP23[4]
	mov dx, Nr1237[4]
	imul dx
	call EXadd
	cmp dx, 0
	jl s13

	mov ax, vP15[0]
	mov dx, Nr1345[0]
	imul dx
	mov bx, dx
	mov cx, ax
	mov ax, vP15[2]
	mov dx, Nr1345[2]
	imul dx
	call EXadd
	mov bx, dx
	mov cx, ax
	mov ax, vP15[4]
	mov dx, Nr1345[4]
	imul dx
	call EXadd
	cmp dx, 0
	jl s13
	jmp doneline
	s13:
    cmp word ptr countline, 2
    je l13
	c14:
	cmp word ptr countline, 3
	jne c26
	mov ax, vP15[0]
	mov dx, Nr1345[0]
	imul dx
	mov bx, dx
	mov cx, ax
	mov ax, vP15[2]
	mov dx, Nr1345[2]
	imul dx
	call EXadd
	mov bx, dx
	mov cx, ax
	mov ax, vP15[4]
	mov dx, Nr1345[4]
	imul dx
	call EXadd
	cmp dx, 0
	jl s14

	mov ax, vP24[0]
	mov dx, Nr1246[0]
	imul dx
	mov bx, dx
	mov cx, ax
	mov ax, vP24[2]
	mov dx, Nr1246[2]
	imul dx
	call EXadd
	mov bx, dx
	mov cx, ax
	mov ax, vP24[4]
	mov dx, Nr1246[4]
	imul dx
	call EXadd
	cmp dx, 0
	jl s14
	jmp doneline
	s14:
    cmp word ptr countline, 3
    je l14
	c26:
	cmp word ptr countline, 4
	jne c27
	mov ax, vP28[0]
	mov dx, Nr2678[0]
	imul dx
	mov bx, dx
	mov cx, ax
	mov ax, vP28[2]
	mov dx, Nr2678[2]
	imul dx
	call EXadd
	mov bx, dx
	mov cx, ax
	mov ax, vP28[4]
	mov dx, Nr2678[4]
	imul dx
	call EXadd
	cmp dx, 0
	jl s26

	mov ax, vP24[0]
	mov dx, Nr1246[0]
	imul dx
	mov bx, dx
	mov cx, ax
	mov ax, vP24[2]
	mov dx, Nr1246[2]
	imul dx
	call EXadd
	mov bx, dx
	mov cx, ax
	mov ax, vP24[4]
	mov dx, Nr1246[4]
	imul dx
	call EXadd
	cmp dx, 0
	jl s26
	jmp doneline
	s26:
    cmp word ptr countline, 4
    je l26
	c27:
	cmp word ptr countline, 5
	jne c37
	mov ax, vP28[0]
	mov dx, Nr2678[0]
	imul dx
	mov bx, dx
	mov cx, ax
	mov ax, vP28[2]
	mov dx, Nr2678[2]
	imul dx
	call EXadd
	mov bx, dx
	mov cx, ax
	mov ax, vP28[4]
	mov dx, Nr2678[4]
	imul dx
	call EXadd
	cmp dx, 0
	jl s27

	mov ax, vP23[0]
	mov dx, Nr1237[0]
	imul dx
	mov bx, dx
	mov cx, ax
	mov ax, vP23[2]
	mov dx, Nr1237[2]
	imul dx
	call EXadd
	mov bx, dx
	mov cx, ax
	mov ax, vP23[4]
	mov dx, Nr1237[4]
	imul dx
	call EXadd
	cmp dx, 0
	jl s27
	jmp doneline
	s27:
    cmp word ptr countline, 5
    je l27
	c37:
	cmp word ptr countline, 6
	jne c35
	mov ax, vP38[0]
	mov dx, Nr3578[0]
	imul dx
	mov bx, dx
	mov cx, ax
	mov ax, vP38[2]
	mov dx, Nr3578[2]
	imul dx
	call EXadd
	mov bx, dx
	mov cx, ax
	mov ax, vP38[4]
	mov dx, Nr3578[4]
	imul dx
	call EXadd
	cmp dx, 0
	jl s37

	mov ax, vP23[0]
	mov dx, Nr1237[0]
	imul dx
	mov bx, dx
	mov cx, ax
	mov ax, vP23[2]
	mov dx, Nr1237[2]
	imul dx
	call EXadd
	mov bx, dx
	mov cx, ax
	mov ax, vP23[4]
	mov dx, Nr1237[4]
	imul dx
	call EXadd
	cmp dx, 0
	jl s37
	jmp doneline
	s37:
    cmp word ptr countline, 6
    je l37
	c35:
	cmp word ptr countline, 7
	jne c45
	mov ax, vP38[0]
	mov dx, Nr3578[0]
	imul dx
	mov bx, dx
	mov cx, ax
	mov ax, vP38[2]
	mov dx, Nr3578[2]
	imul dx
	call EXadd
	mov bx, dx
	mov cx, ax
	mov ax, vP38[4]
	mov dx, Nr3578[4]
	imul dx
	call EXadd
	cmp dx, 0
	jl s35

	mov ax, vP15[0]
	mov dx, Nr1345[0]
	imul dx
	mov bx, dx
	mov cx, ax
	mov ax, vP15[2]
	mov dx, Nr1345[2]
	imul dx
	call EXadd
	mov bx, dx
	mov cx, ax
	mov ax, vP15[4]
	mov dx, Nr1345[4]
	imul dx
	call EXadd
	cmp dx, 0
	jl s35
	jmp doneline
	s35:
    cmp word ptr countline, 7
    je l35
	c45:
	cmp word ptr countline, 8
	jne c46
	mov ax, vP56[0]
	mov dx, Nr4568[0]
	imul dx
	mov bx, dx
	mov cx, ax
	mov ax, vP56[2]
	mov dx, Nr4568[2]
	imul dx
	call EXadd
	mov bx, dx
	mov cx, ax
	mov ax, vP56[4]
	mov dx, Nr4568[4]
	imul dx
	call EXadd
	cmp dx, 0
	jl s45

	mov ax, vP15[0]
	mov dx, Nr1345[0]
	imul dx
	mov bx, dx
	mov cx, ax
	mov ax, vP15[2]
	mov dx, Nr1345[2]
	imul dx
	call EXadd
	mov bx, dx
	mov cx, ax
	mov ax, vP15[4]
	mov dx, Nr1345[4]
	imul dx
	call EXadd
	cmp dx, 0
	jl s45
	jmp doneline
	s45:
    cmp word ptr countline, 8
    je l45
	c46:
	cmp word ptr countline, 9
	jne c68
	mov ax, vP56[0]
	mov dx, Nr4568[0]
	imul dx
	mov bx, dx
	mov cx, ax
	mov ax, vP56[2]
	mov dx, Nr4568[2]
	imul dx
	call EXadd
	mov bx, dx
	mov cx, ax
	mov ax, vP56[4]
	mov dx, Nr4568[4]
	imul dx
	call EXadd
	cmp dx, 0
	jl s46

	mov ax, vP24[0]
	mov dx, Nr1246[0]
	imul dx
	mov bx, dx
	mov cx, ax
	mov ax, vP24[2]
	mov dx, Nr1246[2]
	imul dx
	call EXadd
	mov bx, dx
	mov cx, ax
	mov ax, vP24[4]
	mov dx, Nr1246[4]
	imul dx
	call EXadd
	cmp dx, 0
	jl s46
	jmp doneline
	s46:
    cmp word ptr countline, 9
    je l46
	c68:
	cmp word ptr countline, 10
	jne c58
	mov ax, vP56[0]
	mov dx, Nr4568[0]
	imul dx
	mov bx, dx
	mov cx, ax
	mov ax, vP56[2]
	mov dx, Nr4568[2]
	imul dx
	call EXadd
	mov bx, dx
	mov cx, ax
	mov ax, vP56[4]
	mov dx, Nr4568[4]
	imul dx
	call EXadd
	cmp dx, 0
	jl s68

	mov ax, vP28[0]
	mov dx, Nr2678[0]
	imul dx
	mov bx, dx
	mov cx, ax
	mov ax, vP28[2]
	mov dx, Nr2678[2]
	imul dx
	call EXadd
	mov bx, dx
	mov cx, ax
	mov ax, vP28[4]
	mov dx, Nr2678[4]
	imul dx
	call EXadd
	cmp dx, 0
	jl s68
	jmp doneline
	s68:
    cmp word ptr countline, 10
    je l68
	c58:
	cmp word ptr countline, 11
	jne c78
	mov ax, vP56[0]
	mov dx, Nr4568[0]
	imul dx
	mov bx, dx
	mov cx, ax
	mov ax, vP56[2]
	mov dx, Nr4568[2]
	imul dx
	call EXadd
	mov bx, dx
	mov cx, ax
	mov ax, vP56[4]
	mov dx, Nr4568[4]
	imul dx
	call EXadd
	cmp dx, 0
	jl s58

	mov ax, vP38[0]
	mov dx, Nr3578[0]
	imul dx
	mov bx, dx
	mov cx, ax
	mov ax, vP38[2]
	mov dx, Nr3578[2]
	imul dx
	call EXadd
	mov bx, dx
	mov cx, ax
	mov ax, vP38[4]
	mov dx, Nr3578[4]
	imul dx
	call EXadd
	cmp dx, 0
	jl s58
	jmp doneline
	s58:
    cmp word ptr countline, 11
    je l58
	c78:
	cmp word ptr countline, 12
	jne ipt
	mov ax, vP28[0]
	mov dx, Nr2678[0]
	imul dx
	mov bx, dx
	mov cx, ax
	mov ax, vP28[2]
	mov dx, Nr2678[2]
	imul dx
	call EXadd
	mov bx, dx
	mov cx, ax
	mov ax, vP28[4]
	mov dx, Nr2678[4]
	imul dx
	call EXadd
	cmp dx, 0
	jl s78

	mov ax, vP38[0]
	mov dx, Nr3578[0]
	imul dx
	mov bx, dx
	mov cx, ax
	mov ax, vP38[2]
	mov dx, Nr3578[2]
	imul dx
	call EXadd
	mov bx, dx
	mov cx, ax
	mov ax, vP38[4]
	mov dx, Nr3578[4]
	imul dx
	call EXadd
	cmp dx, 0
	jl s78
	jmp doneline
	s78:
    cmp word ptr countline, 12
    je l78
	;;;;;;;
	

    
    jmp ipt

exit:
    mov ax, 0003h
    int 10h

    mov ax, 4c00h
    int 21h

main ENDP
end main        
