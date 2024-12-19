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

	;color point
	cp0 dw 2 Dup(?)
	cp1 dw 2 Dup(?)
	cp2 dw 2 Dup(?)
	cp3 dw 2 Dup(?)
	cp4 dw 2 Dup(?)
	cp5 dw 2 Dup(?)
	cp6 dw 2 Dup(?)
	cp7 dw 2 Dup(?)
	cp8 dw 2 Dup(?)
	cp9 dw 2 Dup(?)
	cp10 dw 2 Dup(?)
	cp11 dw 2 Dup(?)
	cp12 dw 2 Dup(?)
	cp13 dw 2 Dup(?)
	cp14 dw 2 Dup(?)
	cp15 dw 2 Dup(?)
	cp16 dw 2 Dup(?)
	cp17 dw 2 Dup(?)
	cp18 dw 2 Dup(?)
	cp19 dw 2 Dup(?)
	cp20 dw 2 Dup(?)
	cp21 dw 2 Dup(?)
	cp22 dw 2 Dup(?)
	cp23 dw 2 Dup(?)

	
	Pp dw 320, 0, 240 ;perspective point

	scr dw 500 ;y coordinate of screen

	rubik db 2, 2, 6, 6, 1, 1, 4, 4, 2, 2, 6, 6, 1, 1, 4, 4, 14, 14, 14, 14, 7, 7, 7, 7

    color db 0; 0black 1blue(9) 2green(10) 4red(12) 6brown 7gray 14yellow 15white (light color)  
    lineyn db 8 Dup(?)
.code
include trig.inc
include math.inc
include vmem.inc
include rubik.inc
include fill.inc
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

	cmp al, 79h ;y
	je ltopl
	cmp al, 75h ;u
	je ltopr
	cmp al, 69h ;i
	je lbotl
	cmp al, 6fh ;o
	je lbotr
	cmp al, 67h ;g
	je lclol
	cmp al, 68h ;h
	je lclor
	cmp al, 6ah ;j
	je lfarl
	cmp al, 6bh ;k
	je lfarr
	cmp al, 76h ;v
	je lrf
	cmp al, 62h ;b
	je lrb
	cmp al, 6eh ;n
	je llf
	cmp al, 6dh ;m
	je llb

    cmp al, 27 ;esc
    je exit
    jmp ipt 

	ltopl:
		call topL
		jmp cal
	ltopr:
		call topR
		jmp cal
	lbotl:
		call bottomL
		jmp cal
	lbotr:
		call bottomR
		jmp cal
	lclol:
		call closeL
		jmp cal
	lclor:
		call closeR
		jmp cal
	lfarl:
		call farL
		jmp cal
	lfarr:
		call farR
		jmp cal
	lrf:
		call rightF
		jmp cal
	lrb:
		call rightB
		jmp cal
	llf:
		call leftF
		jmp cal
	llb:
		call leftB
		jmp cal




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
    cwd
	idiv cx
	mov P12[0], ax
	xor dx, dx
	mov ax, P1[2]
	mov bx, P2[2]
	add ax, bx
    cwd
	idiv cx
	mov P12[2], ax
	xor dx, dx
	mov ax, P1[4]
	mov bx, P2[4]
	add ax, bx
    cwd
	idiv cx
	mov P12[4], ax

	mov cx, 2
	xor dx, dx
	mov ax, P1[0]
	mov bx, P3[0]
	add ax, bx
    cwd
	idiv cx
	mov P13[0], ax
	xor dx, dx
	mov ax, P1[2]
	mov bx, P3[2]
	add ax, bx
	idiv cx
    cwd
	mov P13[2], ax
	xor dx, dx
	mov ax, P1[4]
	mov bx, P3[4]
	add ax, bx
    cwd
	idiv cx
	mov P13[4], ax

	mov cx, 2
	xor dx, dx
	mov ax, P1[0]
	mov bx, P4[0]
	add ax, bx
    cwd
	idiv cx
	mov P14[0], ax
	xor dx, dx
	mov ax, P1[2]
	mov bx, P4[2]
	add ax, bx
    cwd
	idiv cx
	mov P14[2], ax
	xor dx, dx
	mov ax, P1[4]
	mov bx, P4[4]
	add ax, bx
    cwd
	idiv cx
	mov P14[4], ax

	mov cx, 2
	xor dx, dx
	mov ax, P2[0]
	mov bx, P6[0]
	add ax, bx
    cwd
	idiv cx
	mov P26[0], ax
	xor dx, dx
	mov ax, P2[2]
	mov bx, P6[2]
	add ax, bx
    cwd
	idiv cx
	mov P26[2], ax
	xor dx, dx
	mov ax, P2[4]
	mov bx, P6[4]
	add ax, bx
    cwd
	idiv cx
	mov P26[4], ax

	mov cx, 2
	xor dx, dx
	mov ax, P2[0]
	mov bx, P7[0]
	add ax, bx
    cwd
	idiv cx
	mov P27[0], ax
	xor dx, dx
	mov ax, P2[2]
	mov bx, P7[2]
	add ax, bx
    cwd
	idiv cx
	mov P27[2], ax
	xor dx, dx
	mov ax, P2[4]
	mov bx, P7[4]
	add ax, bx
    cwd
	idiv cx
	mov P27[4], ax

	mov cx, 2
	xor dx, dx
	mov ax, P5[0]
	mov bx, P3[0]
	add ax, bx
    cwd
	idiv cx
	mov P35[0], ax
	xor dx, dx
	mov ax, P5[2]
	mov bx, P3[2]
	add ax, bx
    cwd
	idiv cx
	mov P35[2], ax
	xor dx, dx
	mov ax, P5[4]
	mov bx, P3[4]
	add ax, bx
    cwd
	idiv cx
	mov P35[4], ax

	mov cx, 2
	xor dx, dx
	mov ax, P7[0]
	mov bx, P3[0]
	add ax, bx
    cwd
	idiv cx
	mov P37[0], ax
	xor dx, dx
	mov ax, P7[2]
	mov bx, P3[2]
	add ax, bx
    cwd
	idiv cx
	mov P37[2], ax
	xor dx, dx
	mov ax, P7[4]
	mov bx, P3[4]
	add ax, bx
    cwd
	idiv cx
	mov P37[4], ax

	mov cx, 2
	xor dx, dx
	mov ax, P4[0]
	mov bx, P5[0]
	add ax, bx
    cwd
	idiv cx
	mov P45[0], ax
	xor dx, dx
	mov ax, P4[2]
	mov bx, P5[2]
	add ax, bx
    cwd
	idiv cx
	mov P45[2], ax
	xor dx, dx
	mov ax, P4[4]
	mov bx, P5[4]
	add ax, bx
    cwd
	idiv cx
	mov P45[4], ax

	mov cx, 2
	xor dx, dx
	mov ax, P4[0]
	mov bx, P6[0]
	add ax, bx
    cwd
	idiv cx
	mov P46[0], ax
	xor dx, dx
	mov ax, P4[2]
	mov bx, P6[2]
	add ax, bx
    cwd
	idiv cx
	mov P46[2], ax
	xor dx, dx
	mov ax, P4[4]
	mov bx, P6[4]
	add ax, bx
    cwd
	idiv cx
	mov P46[4], ax

	mov cx, 2
	xor dx, dx
	mov ax, P5[0]
	mov bx, P8[0]
	add ax, bx
    cwd
	idiv cx
	mov P58[0], ax
	xor dx, dx
	mov ax, P5[2]
	mov bx, P8[2]
	add ax, bx
    cwd
	idiv cx
	mov P58[2], ax
	xor dx, dx
	mov ax, P5[4]
	mov bx, P8[4]
	add ax, bx
    cwd
	idiv cx
	mov P58[4], ax

	mov cx, 2
	xor dx, dx
	mov ax, P6[0]
	mov bx, P8[0]
	add ax, bx
    cwd
	idiv cx
	mov P68[0], ax
	xor dx, dx
	mov ax, P6[2]
	mov bx, P8[2]
	add ax, bx
    cwd
	idiv cx
	mov P68[2], ax
	xor dx, dx
	mov ax, P6[4]
	mov bx, P8[4]
	add ax, bx
    cwd
	idiv cx
	mov P68[4], ax

	mov cx, 2
	xor dx, dx
	mov ax, P7[0]
	mov bx, P8[0]
	add ax, bx
    cwd
	idiv cx
	mov P78[0], ax
	xor dx, dx
	mov ax, P7[2]
	mov bx, P8[2]
	add ax, bx
    cwd
	idiv cx
	mov P78[2], ax
	xor dx, dx
	mov ax, P7[4]
	mov bx, P8[4]
	add ax, bx
    cwd
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

;;color point
	mov ax, sp5[0]
	add ax, word ptr sp38[0]
	cwd
	shr ax, 1
	mov cp0[0], ax
	mov ax, sp5[2]
	add ax, word ptr sp38[2]
	cwd
	shr ax, 1
	mov cp0[2], ax

	mov ax, sp3[0]
	add ax, word ptr sp38[0]
	cwd
	shr ax, 1
	mov cp1[0], ax
	mov ax, sp3[2]
	add ax, word ptr sp38[2]
	cwd
	shr ax, 1
	mov cp1[2], ax
	
	mov ax, sp8[0]
	add ax, word ptr sp38[0]
	cwd
	shr ax, 1
	mov cp8[0], ax
	mov ax, sp8[2]
	add ax, word ptr sp38[2]
	cwd
	shr ax, 1
	mov cp8[2], ax

	mov ax, sp7[0]
	add ax, word ptr sp38[0]
	cwd
	shr ax, 1
	mov cp9[0], ax
	mov ax, sp7[2]
	add ax, word ptr sp38[2]
	cwd
	shr ax, 1
	mov cp9[2], ax

	mov ax, sp3[0]
	add ax, word ptr sp23[0]
	cwd
	shr ax, 1
	mov cp2[0], ax
	mov ax, sp3[2]
	add ax, word ptr sp23[2]
	cwd
	shr ax, 1
	mov cp2[2], ax

	mov ax, sp1[0]
	add ax, word ptr sp23[0]
	cwd
	shr ax, 1
	mov cp3[0], ax
	mov ax, sp1[2]
	add ax, word ptr sp23[2]
	cwd
	shr ax, 1
	mov cp3[2], ax

	mov ax, sp7[0]
	add ax, word ptr sp23[0]
	cwd
	shr ax, 1
	mov cp10[0], ax
	mov ax, sp7[2]
	add ax, word ptr sp23[2]
	cwd
	shr ax, 1
	mov cp10[2], ax

	mov ax, sp2[0]
	add ax, word ptr sp23[0]
	cwd
	shr ax, 1
	mov cp11[0], ax
	mov ax, sp2[2]
	add ax, word ptr sp23[2]
	cwd
	shr ax, 1
	mov cp11[2], ax

	mov ax, sp1[0]
	add ax, word ptr sp24[0]
	cwd
	shr ax, 1
	mov cp4[0], ax
	mov ax, sp1[2]
	add ax, word ptr sp24[2]
	cwd
	shr ax, 1
	mov cp4[2], ax

	mov ax, sp4[0]
	add ax, word ptr sp24[0]
	cwd
	shr ax, 1
	mov cp5[0], ax
	mov ax, sp4[2]
	add ax, word ptr sp24[2]
	cwd
	shr ax, 1
	mov cp5[2], ax

	mov ax, sp2[0]
	add ax, word ptr sp24[0]
	cwd
	shr ax, 1
	mov cp12[0], ax
	mov ax, sp2[2]
	add ax, word ptr sp24[2]
	cwd
	shr ax, 1
	mov cp12[2], ax

	mov ax, sp6[0]
	add ax, word ptr sp24[0]
	cwd
	shr ax, 1
	mov cp13[0], ax
	mov ax, sp6[2]
	add ax, word ptr sp24[2]
	cwd
	shr ax, 1
	mov cp13[2], ax

	mov ax, sp4[0]
	add ax, word ptr sp56[0]
	cwd
	shr ax, 1
	mov cp6[0], ax
	mov ax, sp4[2]
	add ax, word ptr sp56[2]
	cwd
	shr ax, 1
	mov cp6[2], ax

	mov ax, sp5[0]
	add ax, word ptr sp56[0]
	cwd
	shr ax, 1
	mov cp7[0], ax
	mov ax, sp5[2]
	add ax, word ptr sp56[2]
	cwd
	shr ax, 1
	mov cp7[2], ax

	mov ax, sp6[0]
	add ax, word ptr sp56[0]
	cwd
	shr ax, 1
	mov cp14[0], ax
	mov ax, sp6[2]
	add ax, word ptr sp56[2]
	cwd
	shr ax, 1
	mov cp14[2], ax

	mov ax, sp8[0]
	add ax, word ptr sp56[0]
	cwd
	shr ax, 1
	mov cp15[0], ax
	mov ax, sp8[2]
	add ax, word ptr sp56[2]
	cwd
	shr ax, 1
	mov cp15[2], ax

	mov ax, sp5[0]
	add ax, word ptr sp15[0]
	cwd
	shr ax, 1
	mov cp16[0], ax
	mov ax, sp5[2]
	add ax, word ptr sp15[2]
	cwd
	shr ax, 1
	mov cp16[2], ax

	mov ax, sp3[0]
	add ax, word ptr sp15[0]
	cwd
	shr ax, 1
	mov cp17[0], ax
	mov ax, sp3[2]
	add ax, word ptr sp15[2]
	cwd
	shr ax, 1
	mov cp17[2], ax

	mov ax, sp1[0]
	add ax, word ptr sp15[0]
	cwd
	shr ax, 1
	mov cp18[0], ax
	mov ax, sp1[2]
	add ax, word ptr sp15[2]
	cwd
	shr ax, 1
	mov cp18[2], ax

	mov ax, sp4[0]
	add ax, word ptr sp15[0]
	cwd
	shr ax, 1
	mov cp19[0], ax
	mov ax, sp4[2]
	add ax, word ptr sp15[2]
	cwd
	shr ax, 1
	mov cp19[2], ax

	mov ax, sp8[0]
	add ax, word ptr sp28[0]
	cwd
	shr ax, 1
	mov cp20[0], ax
	mov ax, sp8[2]
	add ax, word ptr sp28[2]
	cwd
	shr ax, 1
	mov cp20[2], ax

	mov ax, sp7[0]
	add ax, word ptr sp28[0]
	cwd
	shr ax, 1
	mov cp21[0], ax
	mov ax, sp7[2]
	add ax, word ptr sp28[2]
	cwd
	shr ax, 1
	mov cp21[2], ax

	mov ax, sp2[0]
	add ax, word ptr sp28[0]
	cwd
	shr ax, 1
	mov cp22[0], ax
	mov ax, sp2[2]
	add ax, word ptr sp28[2]
	cwd
	shr ax, 1
	mov cp22[2], ax

	mov ax, sp6[0]
	add ax, word ptr sp28[0]
	cwd
	shr ax, 1
	mov cp23[0], ax
	mov ax, sp6[2]
	add ax, word ptr sp28[2]
	cwd
	shr ax, 1
	mov cp23[2], ax

gra:
    mov ax, 12h ;graphic mode
    int 10h
	


    mov countline, 0
    ;draw line
	jmp doneline
    ;;test
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
l3578:    
    mov ax, sp78[2]
	mov si, sp35[2]
	sub ax, si
	mov bx, sp78[0]
	mov di, sp35[0]
	sub bx, di
	cmp bx, 0
	je y1by23578
	xor dx, dx
	cwd
	idiv bx
    cmp dx, 0
    je skip3578
    cmp ax, -1
    jne skip3578
    dec ax
skip3578:
	mov slope, ax

	cmp ax, -1
	jg x1bx23578

	cmp ax, -1
	jl y1by23578

x1bx23578:
	mov ax, sp35[0]
	mov bx, sp78[0]
	mov si, sp35[2]
	mov di, sp78[2]
	cmp ax, bx
	jb setx3578
	xchg ax, bx
	xchg si, di

	setx3578:
	push ax
	mov ax, slope
	cmp ax, 1
	jge incy
	jmp incx

y1by23578:
	mov ax, sp35[0]
	mov bx, sp78[0]
	mov si, sp35[2]
	mov di, sp78[2]
	cmp si, di
	jb sety3578
	xchg ax, bx
	xchg si, di

	sety3578:
	push ax
	jmp incy
;;;;;;;;;;
l3758:    
    mov ax, sp58[2]
	mov si, sp37[2]
	sub ax, si
	mov bx, sp58[0]
	mov di, sp37[0]
	sub bx, di
	cmp bx, 0
	je y1by23758
	xor dx, dx
	cwd
	idiv bx
    cmp dx, 0
    je skip3758
    cmp ax, -1
    jne skip3758
    dec ax
skip3758:
	mov slope, ax

	cmp ax, -1
	jg x1bx23758

	cmp ax, -1
	jl y1by23758

x1bx23758:
	mov ax, sp37[0]
	mov bx, sp58[0]
	mov si, sp37[2]
	mov di, sp58[2]
	cmp ax, bx
	jb setx3758
	xchg ax, bx
	xchg si, di

	setx3758:
	push ax
	mov ax, slope
	cmp ax, 1
	jge incy
	jmp incx

y1by23758:
	mov ax, sp37[0]
	mov bx, sp58[0]
	mov si, sp37[2]
	mov di, sp58[2]
	cmp si, di
	jb sety3758
	xchg ax, bx
	xchg si, di

	sety3758:
	push ax
	jmp incy
;;;;;;;;;;
;;;;;;;;;;
l1237:    
    mov ax, sp37[2]
	mov si, sp12[2]
	sub ax, si
	mov bx, sp37[0]
	mov di, sp12[0]
	sub bx, di
	cmp bx, 0
	je y1by21237
	xor dx, dx
	cwd
	idiv bx
    cmp dx, 0
    je skip1237
    cmp ax, -1
    jne skip1237
    dec ax
skip1237:
	mov slope, ax

	cmp ax, -1
	jg x1bx21237

	cmp ax, -1
	jl y1by21237

x1bx21237:
	mov ax, sp12[0]
	mov bx, sp37[0]
	mov si, sp12[2]
	mov di, sp37[2]
	cmp ax, bx
	jb setx1237
	xchg ax, bx
	xchg si, di

	setx1237:
	push ax
	mov ax, slope
	cmp ax, 1
	jge incy
	jmp incx

y1by21237:
	mov ax, sp12[0]
	mov bx, sp37[0]
	mov si, sp12[2]
	mov di, sp37[2]
	cmp si, di
	jb sety1237
	xchg ax, bx
	xchg si, di

	sety1237:
	push ax
	jmp incy
;;;;;;;;;;
l1327:    
    mov ax, sp27[2]
	mov si, sp13[2]
	sub ax, si
	mov bx, sp27[0]
	mov di, sp13[0]
	sub bx, di
	cmp bx, 0
	je y1by21327
	xor dx, dx
	cwd
	idiv bx
    cmp dx, 0
    je skip1327
    cmp ax, -1
    jne skip1327
    dec ax
skip1327:
	mov slope, ax

	cmp ax, -1
	jg x1bx21327

	cmp ax, -1
	jl y1by21327

x1bx21327:
	mov ax, sp13[0]
	mov bx, sp27[0]
	mov si, sp13[2]
	mov di, sp27[2]
	cmp ax, bx
	jb setx1327
	xchg ax, bx
	xchg si, di

	setx1327:
	push ax
	mov ax, slope
	cmp ax, 1
	jge incy
	jmp incx

y1by21327:
	mov ax, sp13[0]
	mov bx, sp27[0]
	mov si, sp13[2]
	mov di, sp27[2]
	cmp si, di
	jb sety1327
	xchg ax, bx
	xchg si, di

	sety1327:
	push ax
	jmp incy
;;;;;;;;;;
l4568:    
    mov ax, sp68[2]
	mov si, sp45[2]
	sub ax, si
	mov bx, sp68[0]
	mov di, sp45[0]
	sub bx, di
	cmp bx, 0
	je y1by24568
	xor dx, dx
	cwd
	idiv bx
    cmp dx, 0
    je skip4568
    cmp ax, -1
    jne skip4568
    dec ax
skip4568:
	mov slope, ax

	cmp ax, -1
	jg x1bx24568

	cmp ax, -1
	jl y1by24568

x1bx24568:
	mov ax, sp45[0]
	mov bx, sp68[0]
	mov si, sp45[2]
	mov di, sp68[2]
	cmp ax, bx
	jb setx4568
	xchg ax, bx
	xchg si, di

	setx4568:
	push ax
	mov ax, slope
	cmp ax, 1
	jge incy
	jmp incx

y1by24568:
	mov ax, sp45[0]
	mov bx, sp68[0]
	mov si, sp45[2]
	mov di, sp68[2]
	cmp si, di
	jb sety4568
	xchg ax, bx
	xchg si, di

	sety4568:
	push ax
	jmp incy
;;;;;;;;;;
l4658:    
    mov ax, sp58[2]
	mov si, sp46[2]
	sub ax, si
	mov bx, sp58[0]
	mov di, sp46[0]
	sub bx, di
	cmp bx, 0
	je y1by24658
	xor dx, dx
	cwd
	idiv bx
    cmp dx, 0
    je skip4658
    cmp ax, -1
    jne skip4658
    dec ax
skip4658:
	mov slope, ax

	cmp ax, -1
	jg x1bx24658

	cmp ax, -1
	jl y1by24658

x1bx24658:
	mov ax, sp46[0]
	mov bx, sp58[0]
	mov si, sp46[2]
	mov di, sp58[2]
	cmp ax, bx
	jb setx4658
	xchg ax, bx
	xchg si, di

	setx4658:
	push ax
	mov ax, slope
	cmp ax, 1
	jge incy
	jmp incx

y1by24658:
	mov ax, sp46[0]
	mov bx, sp58[0]
	mov si, sp46[2]
	mov di, sp58[2]
	cmp si, di
	jb sety4658
	xchg ax, bx
	xchg si, di

	sety4658:
	push ax
	jmp incy
;;;;;;;;;;
l1246:    
    mov ax, sp46[2]
	mov si, sp12[2]
	sub ax, si
	mov bx, sp46[0]
	mov di, sp12[0]
	sub bx, di
	cmp bx, 0
	je y1by21246
	xor dx, dx
	cwd
	idiv bx
    cmp dx, 0
    je skip1246
    cmp ax, -1
    jne skip1246
    dec ax
skip1246:
	mov slope, ax

	cmp ax, -1
	jg x1bx21246

	cmp ax, -1
	jl y1by21246

x1bx21246:
	mov ax, sp12[0]
	mov bx, sp46[0]
	mov si, sp12[2]
	mov di, sp46[2]
	cmp ax, bx
	jb setx1246
	xchg ax, bx
	xchg si, di

	setx1246:
	push ax
	mov ax, slope
	cmp ax, 1
	jge incy
	jmp incx

y1by21246:
	mov ax, sp12[0]
	mov bx, sp46[0]
	mov si, sp12[2]
	mov di, sp46[2]
	cmp si, di
	jb sety1246
	xchg ax, bx
	xchg si, di

	sety1246:
	push ax
	jmp incy
;;;;;;;;;;
l1426:    
    mov ax, sp26[2]
	mov si, sp14[2]
	sub ax, si
	mov bx, sp26[0]
	mov di, sp14[0]
	sub bx, di
	cmp bx, 0
	je y1by21426
	xor dx, dx
	cwd
	idiv bx
    cmp dx, 0
    je skip1426
    cmp ax, -1
    jne skip1426
    dec ax
skip1426:
	mov slope, ax

	cmp ax, -1
	jg x1bx21426

	cmp ax, -1
	jl y1by21426

x1bx21426:
	mov ax, sp14[0]
	mov bx, sp26[0]
	mov si, sp14[2]
	mov di, sp26[2]
	cmp ax, bx
	jb setx1426
	xchg ax, bx
	xchg si, di

	setx1426:
	push ax
	mov ax, slope
	cmp ax, 1
	jge incy
	jmp incx

y1by21426:
	mov ax, sp14[0]
	mov bx, sp26[0]
	mov si, sp14[2]
	mov di, sp26[2]
	cmp si, di
	jb sety1426
	xchg ax, bx
	xchg si, di

	sety1426:
	push ax
	jmp incy
;;;;;;;;;;
l1345:    
    mov ax, sp45[2]
	mov si, sp13[2]
	sub ax, si
	mov bx, sp45[0]
	mov di, sp13[0]
	sub bx, di
	cmp bx, 0
	je y1by21345
	xor dx, dx
	cwd
	idiv bx
    cmp dx, 0
    je skip1345
    cmp ax, -1
    jne skip1345
    dec ax
skip1345:
	mov slope, ax

	cmp ax, -1
	jg x1bx21345

	cmp ax, -1
	jl y1by21345

x1bx21345:
	mov ax, sp13[0]
	mov bx, sp45[0]
	mov si, sp13[2]
	mov di, sp45[2]
	cmp ax, bx
	jb setx1345
	xchg ax, bx
	xchg si, di

	setx1345:
	push ax
	mov ax, slope
	cmp ax, 1
	jge incy
	jmp incx

y1by21345:
	mov ax, sp13[0]
	mov bx, sp45[0]
	mov si, sp13[2]
	mov di, sp45[2]
	cmp si, di
	jb sety1345
	xchg ax, bx
	xchg si, di

	sety1345:
	push ax
	jmp incy
;;;;;;;;;;
l1435:    
    mov ax, sp35[2]
	mov si, sp14[2]
	sub ax, si
	mov bx, sp35[0]
	mov di, sp14[0]
	sub bx, di
	cmp bx, 0
	je y1by21435
	xor dx, dx
	cwd
	idiv bx
    cmp dx, 0
    je skip1435
    cmp ax, -1
    jne skip1435
    dec ax
skip1435:
	mov slope, ax

	cmp ax, -1
	jg x1bx21435

	cmp ax, -1
	jl y1by21435

x1bx21435:
	mov ax, sp14[0]
	mov bx, sp35[0]
	mov si, sp14[2]
	mov di, sp35[2]
	cmp ax, bx
	jb setx1435
	xchg ax, bx
	xchg si, di

	setx1435:
	push ax
	mov ax, slope
	cmp ax, 1
	jge incy
	jmp incx

y1by21435:
	mov ax, sp14[0]
	mov bx, sp35[0]
	mov si, sp14[2]
	mov di, sp35[2]
	cmp si, di
	jb sety1435
	xchg ax, bx
	xchg si, di

	sety1435:
	push ax
	jmp incy
;;;;;;;;;;
l2678:    
    mov ax, sp78[2]
	mov si, sp26[2]
	sub ax, si
	mov bx, sp78[0]
	mov di, sp26[0]
	sub bx, di
	cmp bx, 0
	je y1by22678
	xor dx, dx
	cwd
	idiv bx
    cmp dx, 0
    je skip2678
    cmp ax, -1
    jne skip2678
    dec ax
skip2678:
	mov slope, ax

	cmp ax, -1
	jg x1bx22678

	cmp ax, -1
	jl y1by22678

x1bx22678:
	mov ax, sp26[0]
	mov bx, sp78[0]
	mov si, sp26[2]
	mov di, sp78[2]
	cmp ax, bx
	jb setx2678
	xchg ax, bx
	xchg si, di

	setx2678:
	push ax
	mov ax, slope
	cmp ax, 1
	jge incy
	jmp incx

y1by22678:
	mov ax, sp26[0]
	mov bx, sp78[0]
	mov si, sp26[2]
	mov di, sp78[2]
	cmp si, di
	jb sety2678
	xchg ax, bx
	xchg si, di

	sety2678:
	push ax
	jmp incy
;;;;;;;;;;
l2768:    
    mov ax, sp68[2]
	mov si, sp27[2]
	sub ax, si
	mov bx, sp68[0]
	mov di, sp27[0]
	sub bx, di
	cmp bx, 0
	je y1by22768
	xor dx, dx
	cwd
	idiv bx
    cmp dx, 0
    je skip2768
    cmp ax, -1
    jne skip2768
    dec ax
skip2768:
	mov slope, ax

	cmp ax, -1
	jg x1bx22768

	cmp ax, -1
	jl y1by22768

x1bx22768:
	mov ax, sp27[0]
	mov bx, sp68[0]
	mov si, sp27[2]
	mov di, sp68[2]
	cmp ax, bx
	jb setx2768
	xchg ax, bx
	xchg si, di

	setx2768:
	push ax
	mov ax, slope
	cmp ax, 1
	jge incy
	jmp incx

y1by22768:
	mov ax, sp27[0]
	mov bx, sp68[0]
	mov si, sp27[2]
	mov di, sp68[2]
	cmp si, di
	jb sety2768
	xchg ax, bx
	xchg si, di

	sety2768:
	push ax
	jmp incy
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
	jne c3578
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
    ;;;
	c3578:
	cmp word ptr countline, 13
	jne c3758
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
	jl s3578
	jmp doneline
	s3578:
    cmp word ptr countline, 13
    je l3578

    c3758:
	cmp word ptr countline, 14
	jne c1237
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
	jl s3758
	jmp doneline
	s3758:
    cmp word ptr countline, 14
    je l3758

	c1237:
	cmp word ptr countline, 15
	jne c1327
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
	jl s1237
	jmp doneline
	s1237:
    cmp word ptr countline, 15
    je l1237

	c1327:
	cmp word ptr countline, 16
	jne c4568
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
	jl s1327
	jmp doneline
	s1327:
    cmp word ptr countline, 16
    je l1327

	c4568:
	cmp word ptr countline, 17
	jne c4658
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
	jl s4568
	jmp doneline
	s4568:
    cmp word ptr countline, 17
    je l4568

	c4658:
	cmp word ptr countline, 18
	jne c1246
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
	jl s4658
	jmp doneline
	s4658:
    cmp word ptr countline, 18
    je l4658

	c1246:
	cmp word ptr countline, 19
	jne c1426
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
	jl s1246
	jmp doneline
	s1246:
    cmp word ptr countline, 19
    je l1246

	c1426:
	cmp word ptr countline, 20
	jne c1345
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
	jl s1426
	jmp doneline
	s1426:
    cmp word ptr countline, 20
    je l1426
	
	c1345:
	cmp word ptr countline, 21
	jne c1435
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
	jl s1345
	jmp doneline
	s1345:
    cmp word ptr countline, 21
    je l1345

	c1435:
	cmp word ptr countline, 22
	jne c2678
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
	jl s1435
	jmp doneline
	s1435:
    cmp word ptr countline, 22
    je l1435

	c2678:
	cmp word ptr countline, 23
	jne c2768
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
	jl s2678
	jmp doneline
	s2678:
    cmp word ptr countline, 23
    je l2678

	c2768:
	cmp word ptr countline, 24
	jne filling
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
	jl s2768
	jmp doneline
	s2768:
    cmp word ptr countline, 24
    je l2768

filling:
	mov cx, cp0[0]
	mov dx, cp0[2]
	mov al, rubik[0]
	mov color, al
	call vmem

	mov cx, cp1[0]
	mov dx, cp1[2]
	mov al, rubik[1]
	mov color, al
	call vmem

	mov cx, cp8[0]
	mov dx, cp8[2]
	mov al, rubik[8]
	mov color, al
	call vmem

	mov cx, cp9[0]
	mov dx, cp9[2]
	mov al, rubik[9]
	mov color, al
	call vmem

    
    jmp ipt

exit:
    mov ax, 0003h
    int 10h

    mov ax, 4c00h
    int 21h

main ENDP
end main        
