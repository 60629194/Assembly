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
	;trig
	sin1 dw 459 ; sin(1)*26300
	nsin1 dw -459 ; -sin(1)*26300
	cos1 dw 26296 ; cos(1)*26300
	;parameterized line equation vector
	v1 dw 3 Dup(?)
	v2 dw 3 Dup(?)
	v3 dw 3 Dup(?)
	v4 dw 3 Dup(?)
	v5 dw 3 Dup(?)
	v6 dw 3 Dup(?)
	v7 dw 3 Dup(?)
	v8 dw 3 Dup(?)
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
    include math.inc
main PROC
    mov ax, @data
    mov ds, ax

    ipt:
    mov ah, 10h
    int 16h
    cmp ah, 48h ;up
    je topspin
    cmp ah, 50h ;down
    je backspin
    cmp ah, 4bh ;left
    je clockwise
    cmp ah, 4dh ;right
    je counterclockwise
    cmp al, 27 ;esc
    je exit
    jmp ipt 

	topspin:
		;spin here
		mov ax, Q1[2]
		mov dx, cos1
		imul dx
		mov bx, dx
		mov cx, ax
		mov ax, Q1[4]
		mov dx, sin1
		imul dx
		call EXadd
		mov bx, 26300
		idiv bx
		call round
		push ax
		
		mov ax, Q1[2]
		mov dx, nsin1
		imul dx
		mov bx, dx
		mov cx, ax
		mov ax, Q1[4]
		mov dx, cos1
		imul dx
		call EXadd
		mov bx, 26300
		idiv bx
		call round
		mov Q1[4], ax
		pop ax
		mov Q1[2], ax
		;;;
		mov ax, Q2[2]
		mov dx, cos1
		imul dx
		mov bx, dx
		mov cx, ax
		mov ax, Q2[4]
		mov dx, sin1
		imul dx
		call EXadd
		mov bx, 26300
		idiv bx
		call round
		push ax
		
		mov ax, Q2[2]
		mov dx, nsin1
		imul dx
		mov bx, dx
		mov cx, ax
		mov ax, Q2[4]
		mov dx, cos1
		imul dx
		call EXadd
		mov bx, 26300
		idiv bx
		call round
		mov Q2[4], ax
		pop ax
		mov Q2[2], ax
		;;;
		mov ax, Q3[2]
		mov dx, cos1
		imul dx
		mov bx, dx
		mov cx, ax
		mov ax, Q3[4]
		mov dx, sin1
		imul dx
		call EXadd
		mov bx, 26300
		idiv bx
		call round
		push ax
		
		mov ax, Q3[2]
		mov dx, nsin1
		imul dx
		mov bx, dx
		mov cx, ax
		mov ax, Q3[4]
		mov dx, cos1
		imul dx
		call EXadd
		mov bx, 26300
		idiv bx
		call round
		mov Q3[4], ax
		pop ax
		mov Q3[2], ax
		;;;
		mov ax, Q4[2]
		mov dx, cos1
		imul dx
		mov bx, dx
		mov cx, ax
		mov ax, Q4[4]
		mov dx, sin1
		imul dx
		call EXadd
		mov bx, 26300
		idiv bx
		call round
		push ax
		
		mov ax, Q4[2]
		mov dx, nsin1
		imul dx
		mov bx, dx
		mov cx, ax
		mov ax, Q4[4]
		mov dx, cos1
		imul dx
		call EXadd
		mov bx, 26300
		idiv bx
		call round
		mov Q4[4], ax
		pop ax
		mov Q4[2], ax
		;;;
		mov ax, Q5[2]
		mov dx, cos1
		imul dx
		mov bx, dx
		mov cx, ax
		mov ax, Q5[4]
		mov dx, sin1
		imul dx
		call EXadd
		mov bx, 26300
		idiv bx
		call round
		push ax
		
		mov ax, Q5[2]
		mov dx, nsin1
		imul dx
		mov bx, dx
		mov cx, ax
		mov ax, Q5[4]
		mov dx, cos1
		imul dx
		call EXadd
		mov bx, 26300
		idiv bx
		call round
		mov Q5[4], ax
		pop ax
		mov Q5[2], ax
		;;;
		mov ax, Q6[2]
		mov dx, cos1
		imul dx
		mov bx, dx
		mov cx, ax
		mov ax, Q6[4]
		mov dx, sin1
		imul dx
		call EXadd
		mov bx, 26300
		idiv bx
		call round
		push ax
		
		mov ax, Q6[2]
		mov dx, nsin1
		imul dx
		mov bx, dx
		mov cx, ax
		mov ax, Q6[4]
		mov dx, cos1
		imul dx
		call EXadd
		mov bx, 26300
		idiv bx
		call round
		mov Q6[4], ax
		pop ax
		mov Q6[2], ax
		;;;
		mov ax, Q7[2]
		mov dx, cos1
		imul dx
		mov bx, dx
		mov cx, ax
		mov ax, Q7[4]
		mov dx, sin1
		imul dx
		call EXadd
		mov bx, 26300
		idiv bx
		call round
		push ax
		
		mov ax, Q7[2]
		mov dx, nsin1
		imul dx
		mov bx, dx
		mov cx, ax
		mov ax, Q7[4]
		mov dx, cos1
		imul dx
		call EXadd
		mov bx, 26300
		idiv bx
		call round
		mov Q7[4], ax
		pop ax
		mov Q7[2], ax
		;;
		mov ax, Q8[2]
		mov dx, cos1
		imul dx
		mov bx, dx
		mov cx, ax
		mov ax, Q8[4]
		mov dx, sin1
		imul dx
		call EXadd
		mov bx, 26300
		idiv bx
		call round
		push ax
		
		mov ax, Q8[2]
		mov dx, nsin1
		imul dx
		mov bx, dx
		mov cx, ax
		mov ax, Q8[4]
		mov dx, cos1
		imul dx
		call EXadd
		mov bx, 26300
		idiv bx
		call round
		mov Q8[4], ax
		pop ax
		mov Q8[2], ax
		
        jmp cal
    backspin:
		mov ax, Q1[2]
		mov dx, cos1
		imul dx
		mov bx, dx
		mov cx, ax
		mov ax, Q1[4]
		mov dx, nsin1
		imul dx
		call EXadd
		mov bx, 26300
		idiv bx
		call round
		push ax
		
		mov ax, Q1[2]
		mov dx, sin1
		imul dx
		mov bx, dx
		mov cx, ax
		mov ax, Q1[4]
		mov dx, cos1
		imul dx
		call EXadd
		mov bx, 26300
		idiv bx
		call round
		mov Q1[4], ax
		pop ax
		mov Q1[2], ax
		;;;
		mov ax, Q2[2]
		mov dx, cos1
		imul dx
		mov bx, dx
		mov cx, ax
		mov ax, Q2[4]
		mov dx, nsin1
		imul dx
		call EXadd
		mov bx, 26300
		idiv bx
		call round
		push ax
		
		mov ax, Q2[2]
		mov dx, sin1
		imul dx
		mov bx, dx
		mov cx, ax
		mov ax, Q2[4]
		mov dx, cos1
		imul dx
		call EXadd
		mov bx, 26300
		idiv bx
		call round
		mov Q2[4], ax
		pop ax
		mov Q2[2], ax
		;;;
		mov ax, Q3[2]
		mov dx, cos1
		imul dx
		mov bx, dx
		mov cx, ax
		mov ax, Q3[4]
		mov dx, nsin1
		imul dx
		call EXadd
		mov bx, 26300
		idiv bx
		call round
		push ax
		
		mov ax, Q3[2]
		mov dx, sin1
		imul dx
		mov bx, dx
		mov cx, ax
		mov ax, Q3[4]
		mov dx, cos1
		imul dx
		call EXadd
		mov bx, 26300
		idiv bx
		call round
		mov Q3[4], ax
		pop ax
		mov Q3[2], ax
		;;;
		mov ax, Q4[2]
		mov dx, cos1
		imul dx
		mov bx, dx
		mov cx, ax
		mov ax, Q4[4]
		mov dx, nsin1
		imul dx
		call EXadd
		mov bx, 26300
		idiv bx
		call round
		push ax
		
		mov ax, Q4[2]
		mov dx, sin1
		imul dx
		mov bx, dx
		mov cx, ax
		mov ax, Q4[4]
		mov dx, cos1
		imul dx
		call EXadd
		mov bx, 26300
		idiv bx
		call round
		mov Q4[4], ax
		pop ax
		mov Q4[2], ax
		;;;
		mov ax, Q5[2]
		mov dx, cos1
		imul dx
		mov bx, dx
		mov cx, ax
		mov ax, Q5[4]
		mov dx, nsin1
		imul dx
		call EXadd
		mov bx, 26300
		idiv bx
		call round
		push ax
		
		mov ax, Q5[2]
		mov dx, sin1
		imul dx
		mov bx, dx
		mov cx, ax
		mov ax, Q5[4]
		mov dx, cos1
		imul dx
		call EXadd
		mov bx, 26300
		idiv bx
		call round
		mov Q5[4], ax
		pop ax
		mov Q5[2], ax
		;;;
		mov ax, Q6[2]
		mov dx, cos1
		imul dx
		mov bx, dx
		mov cx, ax
		mov ax, Q6[4]
		mov dx, nsin1
		imul dx
		call EXadd
		mov bx, 26300
		idiv bx
		call round
		push ax
		
		mov ax, Q6[2]
		mov dx, sin1
		imul dx
		mov bx, dx
		mov cx, ax
		mov ax, Q6[4]
		mov dx, cos1
		imul dx
		call EXadd
		mov bx, 26300
		idiv bx
		call round
		mov Q6[4], ax
		pop ax
		mov Q6[2], ax
		;;;
		mov ax, Q7[2]
		mov dx, cos1
		imul dx
		mov bx, dx
		mov cx, ax
		mov ax, Q7[4]
		mov dx, nsin1
		imul dx
		call EXadd
		mov bx, 26300
		idiv bx
		call round
		push ax
		
		mov ax, Q7[2]
		mov dx, sin1
		imul dx
		mov bx, dx
		mov cx, ax
		mov ax, Q7[4]
		mov dx, cos1
		imul dx
		call EXadd
		mov bx, 26300
		idiv bx
		call round
		mov Q7[4], ax
		pop ax
		mov Q7[2], ax
		;;;
		mov ax, Q8[2]
		mov dx, cos1
		imul dx
		mov bx, dx
		mov cx, ax
		mov ax, Q8[4]
		mov dx, nsin1
		imul dx
		call EXadd
		mov bx, 26300
		idiv bx
		call round
		push ax
		
		mov ax, Q8[2]
		mov dx, sin1
		imul dx
		mov bx, dx
		mov cx, ax
		mov ax, Q8[4]
		mov dx, cos1
		imul dx
		call EXadd
		mov bx, 26300
		idiv bx
		call round
		mov Q8[4], ax
		pop ax
		mov Q8[2], ax
		
        jmp cal
    clockwise:
		mov ax, Q1[0]
		mov dx, cos1
		imul dx
		mov bx, dx
		mov cx, ax
		mov ax, Q1[2]
		mov dx, sin1
		imul dx
		call EXadd
		mov bx, 26300
		idiv bx
		call round
		push ax
		
		mov ax, Q1[0]
		mov dx, nsin1
		imul dx
		mov bx, dx
		mov cx, ax
		mov ax, Q1[2]
		mov dx, cos1
		imul dx
		call EXadd
		mov bx, 26300
		idiv bx
		call round
		mov Q1[2], ax
		pop ax
		mov Q1[0], ax
		;;;
		mov ax, Q2[0]
		mov dx, cos1
		imul dx
		mov bx, dx
		mov cx, ax
		mov ax, Q2[2]
		mov dx, sin1
		imul dx
		call EXadd
		mov bx, 26300
		idiv bx
		call round
		push ax
		
		mov ax, Q2[0]
		mov dx, nsin1
		imul dx
		mov bx, dx
		mov cx, ax
		mov ax, Q2[2]
		mov dx, cos1
		imul dx
		call EXadd
		mov bx, 26300
		idiv bx
		call round
		mov Q2[2], ax
		pop ax
		mov Q2[0], ax
		;;;
		mov ax, Q3[0]
		mov dx, cos1
		imul dx
		mov bx, dx
		mov cx, ax
		mov ax, Q3[2]
		mov dx, sin1
		imul dx
		call EXadd
		mov bx, 26300
		idiv bx
		call round
		push ax
		
		mov ax, Q3[0]
		mov dx, nsin1
		imul dx
		mov bx, dx
		mov cx, ax
		mov ax, Q3[2]
		mov dx, cos1
		imul dx
		call EXadd
		mov bx, 26300
		idiv bx
		call round
		mov Q3[2], ax
		pop ax
		mov Q3[0], ax
		;;;
		mov ax, Q4[0]
		mov dx, cos1
		imul dx
		mov bx, dx
		mov cx, ax
		mov ax, Q4[2]
		mov dx, sin1
		imul dx
		call EXadd
		mov bx, 26300
		idiv bx
		call round
		push ax
		
		mov ax, Q4[0]
		mov dx, nsin1
		imul dx
		mov bx, dx
		mov cx, ax
		mov ax, Q4[2]
		mov dx, cos1
		imul dx
		call EXadd
		mov bx, 26300
		idiv bx
		call round
		mov Q4[2], ax
		pop ax
		mov Q4[0], ax		
		;;;
		mov ax, Q5[0]
		mov dx, cos1
		imul dx
		mov bx, dx
		mov cx, ax
		mov ax, Q5[2]
		mov dx, sin1
		imul dx
		call EXadd
		mov bx, 26300
		idiv bx
		call round
		push ax
		
		mov ax, Q5[0]
		mov dx, nsin1
		imul dx
		mov bx, dx
		mov cx, ax
		mov ax, Q5[2]
		mov dx, cos1
		imul dx
		call EXadd
		mov bx, 26300
		idiv bx
		call round
		mov Q5[2], ax
		pop ax
		mov Q5[0], ax		
		;;;
		mov ax, Q6[0]
		mov dx, cos1
		imul dx
		mov bx, dx
		mov cx, ax
		mov ax, Q6[2]
		mov dx, sin1
		imul dx
		call EXadd
		mov bx, 26300
		idiv bx
		call round
		push ax
		
		mov ax, Q6[0]
		mov dx, nsin1
		imul dx
		mov bx, dx
		mov cx, ax
		mov ax, Q6[2]
		mov dx, cos1
		imul dx
		call EXadd
		mov bx, 26300
		idiv bx
		call round
		mov Q6[2], ax
		pop ax
		mov Q6[0], ax		
		;;;
		mov ax, Q7[0]
		mov dx, cos1
		imul dx
		mov bx, dx
		mov cx, ax
		mov ax, Q7[2]
		mov dx, sin1
		imul dx
		call EXadd
		mov bx, 26300
		idiv bx
		call round
		push ax
		
		mov ax, Q7[0]
		mov dx, nsin1
		imul dx
		mov bx, dx
		mov cx, ax
		mov ax, Q7[2]
		mov dx, cos1
		imul dx
		call EXadd
		mov bx, 26300
		idiv bx
		call round
		mov Q7[2], ax
		pop ax
		mov Q7[0], ax		
		;;;
		mov ax, Q8[0]
		mov dx, cos1
		imul dx
		mov bx, dx
		mov cx, ax
		mov ax, Q8[2]
		mov dx, sin1
		imul dx
		call EXadd
		mov bx, 26300
		idiv bx
		push ax
		
		mov ax, Q8[0]
		mov dx, nsin1
		imul dx
		mov bx, dx
		mov cx, ax
		mov ax, Q8[2]
		mov dx, cos1
		imul dx
		call EXadd
		mov bx, 26300
		idiv bx
		call round
		mov Q8[2], ax
		pop ax
		mov Q8[0], ax		
		
        jmp cal
    counterclockwise:
		mov ax, Q1[0]
		mov dx, cos1
		imul dx
		mov bx, dx
		mov cx, ax
		mov ax, Q1[2]
		mov dx, nsin1
		imul dx
		call EXadd
		mov bx, 26300
		idiv bx
		call round
		push ax
		
		mov ax, Q1[0]
		mov dx, sin1
		imul dx
		mov bx, dx
		mov cx, ax
		mov ax, Q1[2]
		mov dx, cos1
		imul dx
		call EXadd
		mov bx, 26300
		idiv bx
		call round
		mov Q1[2], ax
		pop ax
		mov Q1[0], ax
		;;;
		mov ax, Q2[0]
		mov dx, cos1
		imul dx
		mov bx, dx
		mov cx, ax
		mov ax, Q2[2]
		mov dx, nsin1
		imul dx
		call EXadd
		mov bx, 26300
		idiv bx
		call round
		push ax
		
		mov ax, Q2[0]
		mov dx, sin1
		imul dx
		mov bx, dx
		mov cx, ax
		mov ax, Q2[2]
		mov dx, cos1
		imul dx
		call EXadd
		mov bx, 26300
		idiv bx
		call round
		mov Q2[2], ax
		pop ax
		mov Q2[0], ax
		;;;
		mov ax, Q3[0]
		mov dx, cos1
		imul dx
		mov bx, dx
		mov cx, ax
		mov ax, Q3[2]
		mov dx, nsin1
		imul dx
		call EXadd
		mov bx, 26300
		idiv bx
		call round
		push ax
		
		mov ax, Q3[0]
		mov dx, sin1
		imul dx
		mov bx, dx
		mov cx, ax
		mov ax, Q3[2]
		mov dx, cos1
		imul dx
		call EXadd
		mov bx, 26300
		idiv bx
		call round
		mov Q3[2], ax
		pop ax
		mov Q3[0], ax
		;;;
		mov ax, Q4[0]
		mov dx, cos1
		imul dx
		mov bx, dx
		mov cx, ax
		mov ax, Q4[2]
		mov dx, nsin1
		imul dx
		call EXadd
		mov bx, 26300
		idiv bx
		call round
		push ax
		
		mov ax, Q4[0]
		mov dx, sin1
		imul dx
		mov bx, dx
		mov cx, ax
		mov ax, Q4[2]
		mov dx, cos1
		imul dx
		call EXadd
		mov bx, 26300
		idiv bx
		call round
		mov Q4[2], ax
		pop ax
		mov Q4[0], ax		
		;;;
		mov ax, Q5[0]
		mov dx, cos1
		imul dx
		mov bx, dx
		mov cx, ax
		mov ax, Q5[2]
		mov dx, nsin1
		imul dx
		call EXadd
		mov bx, 26300
		idiv bx
		call round
		push ax
		
		mov ax, Q5[0]
		mov dx, sin1
		imul dx
		mov bx, dx
		mov cx, ax
		mov ax, Q5[2]
		mov dx, cos1
		imul dx
		call EXadd
		mov bx, 26300
		idiv bx
		call round
		mov Q5[2], ax
		pop ax
		mov Q5[0], ax		
		;;;
		mov ax, Q6[0]
		mov dx, cos1
		imul dx
		mov bx, dx
		mov cx, ax
		mov ax, Q6[2]
		mov dx, nsin1
		imul dx
		call EXadd
		mov bx, 26300
		idiv bx
		call round
		push ax
		
		mov ax, Q6[0]
		mov dx, sin1
		imul dx
		mov bx, dx
		mov cx, ax
		mov ax, Q6[2]
		mov dx, cos1
		imul dx
		call EXadd
		mov bx, 26300
		idiv bx
		call round
		mov Q6[2], ax
		pop ax
		mov Q6[0], ax		
		;;;
		mov ax, Q7[0]
		mov dx, cos1
		imul dx
		mov bx, dx
		mov cx, ax
		mov ax, Q7[2]
		mov dx, nsin1
		imul dx
		call EXadd
		mov bx, 26300
		idiv bx
		call round
		push ax
		
		mov ax, Q7[0]
		mov dx, sin1
		imul dx
		mov bx, dx
		mov cx, ax
		mov ax, Q7[2]
		mov dx, cos1
		imul dx
		call EXadd
		mov bx, 26300
		idiv bx
		call round
		mov Q7[2], ax
		pop ax
		mov Q7[0], ax		
		;;;
		mov ax, Q8[0]
		mov dx, cos1
		imul dx
		mov bx, dx
		mov cx, ax
		mov ax, Q8[2]
		mov dx, nsin1
		imul dx
		call EXadd
		mov bx, 26300
		idiv bx
		call round
		push ax
		
		mov ax, Q8[0]
		mov dx, sin1
		imul dx
		mov bx, dx
		mov cx, ax
		mov ax, Q8[2]
		mov dx, cos1
		imul dx
		call EXadd
		mov bx, 26300
		idiv bx
		call round
		mov Q8[2], ax
		pop ax
		mov Q8[0], ax		
		
        jmp cal
cal:
	;Qn+Qc=Pn
	mov ax, Qc[0]
	mov bx, Q1[0]
	mov P1[0], bx
	add word ptr P1[0], ax
	mov ax, Qc[2]
	mov bx, Q1[2]
	mov P1[2], bx
	add word ptr P1[2], ax
	mov ax, Qc[4]
	mov bx, Q1[4]
	mov P1[4], bx
	add word ptr P1[4], ax
	
	mov ax, Qc[0]
	mov bx, Q2[0]
	mov P2[0], bx
	add word ptr P2[0], ax
	mov ax, Qc[2]
	mov bx, Q2[2]
	mov P2[2], bx
	add word ptr P2[2], ax
	mov ax, Qc[4]
	mov bx, Q2[4]
	mov P2[4], bx
	add word ptr P2[4], ax
	
	mov ax, Qc[0]
	mov bx, Q3[0]
	mov P3[0], bx
	add word ptr P3[0], ax
	mov ax, Qc[2]
	mov bx, Q3[2]
	mov P3[2], bx
	add word ptr P3[2], ax
	mov ax, Qc[4]
	mov bx, Q3[4]
	mov P3[4], bx
	add word ptr P3[4], ax
	
	mov ax, Qc[0]
	mov bx, Q4[0]
	mov P4[0], bx
	add word ptr P4[0], ax
	mov ax, Qc[2]
	mov bx, Q4[2]
	mov P4[2], bx
	add word ptr P4[2], ax
	mov ax, Qc[4]
	mov bx, Q4[4]
	mov P4[4], bx
	add word ptr P4[4], ax
	
	mov ax, Qc[0]
	mov bx, Q5[0]
	mov P5[0], bx
	add word ptr P5[0], ax
	mov ax, Qc[2]
	mov bx, Q5[2]
	mov P5[2], bx
	add word ptr P5[2], ax
	mov ax, Qc[4]
	mov bx, Q5[4]
	mov P5[4], bx
	add word ptr P5[4], ax
	
	mov ax, Qc[0]
	mov bx, Q6[0]
	mov P6[0], bx
	add word ptr P6[0], ax
	mov ax, Qc[2]
	mov bx, Q6[2]
	mov P6[2], bx
	add word ptr P6[2], ax
	mov ax, Qc[4]
	mov bx, Q6[4]
	mov P6[4], bx
	add word ptr P6[4], ax
	
	mov ax, Qc[0]
	mov bx, Q7[0]
	mov P7[0], bx
	add word ptr P7[0], ax
	mov ax, Qc[2]
	mov bx, Q7[2]
	mov P7[2], bx
	add word ptr P7[2], ax
	mov ax, Qc[4]
	mov bx, Q7[4]
	mov P7[4], bx
	add word ptr P7[4], ax
	
	mov ax, Qc[0]
	mov bx, Q8[0]
	mov P8[0], bx
	add word ptr P8[0], ax
	mov ax, Qc[2]
	mov bx, Q8[2]
	mov P8[2], bx
	add word ptr P8[2], ax
	mov ax, Qc[4]
	mov bx, Q8[4]
	mov P8[4], bx
	add word ptr P8[4], ax
	
	
	;project here
	
	mov ax, P1[0]
	sub ax, Pp[0]
	mov v1[0], ax
	mov ax, P1[2]
	sub ax, Pp[2]
	mov v1[2], ax
	mov ax, P1[4]
	sub ax, Pp[4]
	mov v1[4], ax
	
	xor dx, dx
	mov ax, scr
	mov bx, 100 ; number which can discuss
	imul bx
	mov bx, v2[2]
	idiv bx  
	call round
	mov bx, ax  ;bx=t*num
	
	mov ax, v1[0]
	imul bx
	mov cx, 100
	idiv cx
	call round
	add cx, Pp[0]
	mov sp1[0], cx
	
	mov ax, v1[4]
	imul bx
	mov cx, 100
	idiv cx
	call round
	add cx, Pp[4]
	mov sp1[2], cx
	
	;;;
	
	
	
	
	
	
gra:
    ;show proj
    mov ax, 11h ;graphic mode
    int 10h
    mov ax, 0c01h ; draw cx, dx
    int 10h
    ; line up those point

    jmp ipt

exit:
    mov ax, 4c00h
    int 21h
main ENDP
end main