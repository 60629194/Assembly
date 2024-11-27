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
	sp1 dw 3 Dup(?) 
    sp2 dw 3 Dup(?)
    sp3 dw 3 Dup(?)
    sp4 dw 3 Dup(?)
	sp5 dw 3 Dup(?)
	sp6 dw 3 Dup(?)
	sp7 dw 3 Dup(?)
	sp8 dw 3 Dup(?)

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
		mov Q8[2], ax
		pop ax
		mov Q8[0], ax		
		
        jmp cal
cal:
	;Qn+Qc
	mov ax, Qc[0]
	add word ptr Q1[0], ax
	mov ax, Qc[2]
	add word ptr Q1[2], ax
	mov ax, Qc[4]
	add word ptr Q1[4], ax
	
	mov ax, Qc[0]
	add word ptr Q2[0], ax
	mov ax, Qc[2]
	add word ptr Q2[2], ax
	mov ax, Qc[4]
	add word ptr Q2[4], ax
	
	mov ax, Qc[0]
	add word ptr Q3[0], ax
	mov ax, Qc[2]
	add word ptr Q3[2], ax
	mov ax, Qc[4]
	add word ptr Q3[4], ax
	
	mov ax, Qc[0]
	add word ptr Q4[0], ax
	mov ax, Qc[2]
	add word ptr Q4[2], ax
	mov ax, Qc[4]
	add word ptr Q4[4], ax
	
	mov ax, Qc[0]
	add word ptr Q5[0], ax
	mov ax, Qc[2]
	add word ptr Q5[2], ax
	mov ax, Qc[4]
	add word ptr Q5[4], ax
	
	mov ax, Qc[0]
	add word ptr Q6[0], ax
	mov ax, Qc[2]
	add word ptr Q6[2], ax
	mov ax, Qc[4]
	add word ptr Q6[4], ax
	
	mov ax, Qc[0]
	add word ptr Q7[0], ax
	mov ax, Qc[2]
	add word ptr Q7[2], ax
	mov ax, Qc[4]
	add word ptr Q7[4], ax
	
	mov ax, Qc[0]
	add word ptr Q8[0], ax
	mov ax, Qc[2]
	add word ptr Q8[2], ax
	mov ax, Qc[4]
	add word ptr Q8[4], ax
	
	;project here
	;;;after projection need to minus Qc get backspin
	mov ax, Qc[0]
	sub word ptr Q1[0], ax
	mov ax, Qc[2]
	sub word ptr Q1[2], ax
	mov ax, Qc[4]
	sub word ptr Q1[4], ax
	
	mov ax, Qc[0]
	sub word ptr Q2[0], ax
	mov ax, Qc[2]
	sub word ptr Q2[2], ax
	mov ax, Qc[4]
	sub word ptr Q2[4], ax
	
	mov ax, Qc[0]
	sub word ptr Q3[0], ax
	mov ax, Qc[2]
	sub word ptr Q3[2], ax
	mov ax, Qc[4]
	sub word ptr Q3[4], ax
	
	mov ax, Qc[0]
	sub word ptr Q4[0], ax
	mov ax, Qc[2]
	sub word ptr Q4[2], ax
	mov ax, Qc[4]
	sub word ptr Q4[4], ax
	
	mov ax, Qc[0]
	sub word ptr Q5[0], ax
	mov ax, Qc[2]
	sub word ptr Q5[2], ax
	mov ax, Qc[4]
	sub word ptr Q5[4], ax
	
	mov ax, Qc[0]
	sub word ptr Q6[0], ax
	mov ax, Qc[2]
	sub word ptr Q6[2], ax
	mov ax, Qc[4]
	sub word ptr Q6[4], ax
	
	mov ax, Qc[0]
	sub word ptr Q7[0], ax
	mov ax, Qc[2]
	sub word ptr Q7[2], ax
	mov ax, Qc[4]
	sub word ptr Q7[4], ax
	
	mov ax, Qc[0]
	sub word ptr Q8[0], ax
	mov ax, Qc[2]
	sub word ptr Q8[2], ax
	mov ax, Qc[4]
	sub word ptr Q8[4], ax
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