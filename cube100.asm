.model small
.stack
.data
    Qc dw 320, 1000, 240
    Q1 dw 560, 1240, 480 ;+++
    Q2 dw 560, 1240, 0 ;++-
    Q3 dw 560, 760, 480  ;+-+
    Q4 dw 80, 1240, 480 ;-++
    Q5 dw 80, 760, 480  ;--+
    Q6 dw 80, 1240, 0 ;-+-
    Q7 dw 560, 760, 0  ;+--
    Q8 dw 80,  760, 0  ;---
    sp1 dw 3 Dup(?)
    sp2 dw 3 Dup(?)
    sp3 dw 3 Dup(?)
    sp4 dw 3 Dup(?)
	sp5 dw 3 Dup(?)
	sp6 dw 3 Dup(?)
	sp7 dw 3 Dup(?)
	sp8 dw 3 Dup(?)
	thetax dw 0
	thetaz dw 0
	rx dw 1, 0, 0, 0, 1, 0, 0, 0, 1
	rz dw 1, 0, 0, 0, 1, 0, 0, 0, 1
    Pp dw 320, 0, 240 ;front of center of the screen
	scr dw 500 ;y coordinate
.code
main PROC
    ;catch input
    mov ax, @data
    mov ds, ax

ipt:
    mov ah, 10h
    int 16h
    cmp ah, 48h ;up
    je topspin
    cmp ah, 50h ;down
    je backspin
    cmp al, 4bh ;left
    je clockwise
    cmp al, 4dh ;right
    je counterclockwise
    cmp al, 27 ;esc
    je exit
    jmp ipt 

    ;rotate cube
    topspin:
		cmp thetax, 0
		jne rok1
		mov thetax, 360
		rok1:
		dec word ptr thetax
        jmp cal
    backspin:
		cmp thetax, 360
		jne rok2
		mov thetax, 0
		rok2:
		inc word ptr thetax
        jmp cal
    clockwise:
		cmp thetaz, 0
		jne rok3
		mov thetaz, 360
		rok3:
		dec word ptr thetaz
        jmp cal
    counterclockwise:
        cmp thetaz, 360
		jne rok4
		mov thetaz, 0
		rok4:
		inc word ptr thetaz
        jmp cal
		
cal: 
	mov ax, thetax
	call cos
	mov rx[4], ax
	mov rx[8], ax
	mov rz[0], ax
	mov rz[4], ax
	mov ax, thetax
	call sin
	mov rx[7], ax
	mov rz[3], ax
	neg ax
	mov rx[5], ax
	mov rz[1], ax
	; rx, rz refreshed

	
	mov ax, Qc[0]
	sub word ptr Q1[0], ax
	mov ax, Qc[1]
	sub word ptr Q1[1], ax
	mov ax, Qc[2]
	sub word ptr Q1[2], ax
	
	mov ax, Qc[0]
	sub word ptr Q2[0], ax
	mov ax, Qc[1]
	sub word ptr Q2[1], ax
	mov ax, Qc[2]
	sub word ptr Q2[2], ax
	
	mov ax, Qc[0]
	sub word ptr Q3[0], ax
	mov ax, Qc[1]
	sub word ptr Q3[1], ax
	mov ax, Qc[2]
	sub word ptr Q3[2], ax
	
	mov ax, Qc[0]
	sub word ptr Q4[0], ax
	mov ax, Qc[1]
	sub word ptr Q4[1], ax
	mov ax, Qc[2]
	sub word ptr Q4[2], ax
	
	mov ax, Qc[0]
	sub word ptr Q5[0], ax
	mov ax, Qc[1]
	sub word ptr Q5[1], ax
	mov ax, Qc[2]
	sub word ptr Q5[2], ax
	
	mov ax, Qc[0]
	sub word ptr Q6[0], ax
	mov ax, Qc[1]
	sub word ptr Q6[1], ax
	mov ax, Qc[2]
	sub word ptr Q6[2], ax
	
	mov ax, Qc[0]
	sub word ptr Q7[0], ax
	mov ax, Qc[1]
	sub word ptr Q7[1], ax
	mov ax, Qc[2]
	sub word ptr Q7[2], ax
	
	mov ax, Qc[0]
	sub word ptr Q8[0], ax
	mov ax, Qc[1]
	sub word ptr Q8[1], ax
	mov ax, Qc[2]
	sub word ptr Q8[2], ax
	;Qn-Qc
	
	;;;;rxQ1
	;
	mov ax, rx[4]
	mov dx, Q1[1]
	imul dx
	mov bx, dx
	mov cx, ax
	;
	mov ax, rx[5]
	mov dx, Q1[2]
	imul dx
	call EXadd
	idiv 5000
	mov Q1[1], ax
	;
	mov ax, rx[7]
	mov dx, Q1[1]
	imul dx
	mov bx, dx
	mov cx, ax
	;
	mov ax, rx[8]
	mov dx, Q1[2]
	imul dx
	call EXadd
	idiv 5000
	mov Q1[2], ax
	;
	
	;;;;rzQ1
	mov ax, rz[0]
	mov dx, Q1[0]
	imul dx
	mov bx, dx
	mov cx, ax
	;
	mov ax, rz[1]
	mov dx, Q1[1]
	imul dx
	call EXadd
	idiv 5000
	mov Q1[0], ax
	;
	mov ax, rz[3]
	mov dx, Q1[0]
	imul dx
	mov bx, dx
	mov cx, ax
	;
	mov ax, rz[4]
	mov dx, Q1[1]
	imul dx
	call EXadd
	idiv 5000
	mov Q1[1], ax
	;
	
	;;;;rxQ2
	;
	mov ax, rx[4]
	mov dx, Q2[1]
	imul dx
	mov bx, dx
	mov cx, ax
	;
	mov ax, rx[5]
	mov dx, Q2[2]
	imul dx
	call EXadd
	idiv 5000
	mov Q2[1], ax
	;
	mov ax, rx[7]
	mov dx, Q2[1]
	imul dx
	mov bx, dx
	mov cx, ax
	;
	mov ax, rx[8]
	mov dx, Q2[2]
	imul dx
	call EXadd
	idiv 5000
	mov Q2[2], ax
	;
	
	;;;;rzQ2
	mov ax, rz[0]
	mov dx, Q2[0]
	imul dx
	mov bx, dx
	mov cx, ax
	;
	mov ax, rz[1]
	mov dx, Q2[1]
	imul dx
	call EXadd
	idiv 5000
	mov Q2[0], ax
	;
	mov ax, rz[3]
	mov dx, Q2[0]
	imul dx
	mov bx, dx
	mov cx, ax
	;
	mov ax, rz[4]
	mov dx, Q2[1]
	imul dx
	call EXadd
	idiv 5000
	mov Q2[1], ax
	;
	
	;;;;rxQ3
	;
	mov ax, rx[4]
	mov dx, Q3[1]
	imul dx
	mov bx, dx
	mov cx, ax
	;
	mov ax, rx[5]
	mov dx, Q3[2]
	imul dx
	call EXadd
	idiv 5000
	mov Q3[1], ax
	;
	mov ax, rx[7]
	mov dx, Q3[1]
	imul dx
	mov bx, dx
	mov cx, ax
	;
	mov ax, rx[8]
	mov dx, Q3[2]
	imul dx
	call EXadd
	idiv 5000
	mov Q3[2], ax
	;
	
	;;;;rzQ3
	mov ax, rz[0]
	mov dx, Q3[0]
	imul dx
	mov bx, dx
	mov cx, ax
	;
	mov ax, rz[1]
	mov dx, Q3[1]
	imul dx
	call EXadd
	idiv 5000
	mov Q3[0], ax
	;
	mov ax, rz[3]
	mov dx, Q3[0]
	imul dx
	mov bx, dx
	mov cx, ax
	;
	mov ax, rz[4]
	mov dx, Q3[1]
	imul dx
	call EXadd
	idiv 5000
	mov Q3[1], ax
	;
	
	;;;;rxQ4
	;
	mov ax, rx[4]
	mov dx, Q4[1]
	imul dx
	mov bx, dx
	mov cx, ax
	;
	mov ax, rx[5]
	mov dx, Q4[2]
	imul dx
	call EXadd
	idiv 5000
	mov Q4[1], ax
	;
	mov ax, rx[7]
	mov dx, Q4[1]
	imul dx
	mov bx, dx
	mov cx, ax
	;
	mov ax, rx[8]
	mov dx, Q4[2]
	imul dx
	call EXadd
	idiv 5000
	mov Q4[2], ax
	;
	
	;;;;rzQ4
	mov ax, rz[0]
	mov dx, Q4[0]
	imul dx
	mov bx, dx
	mov cx, ax
	;
	mov ax, rz[1]
	mov dx, Q4[1]
	imul dx
	call EXadd
	idiv 5000
	mov Q4[0], ax
	;
	mov ax, rz[3]
	mov dx, Q4[0]
	imul dx
	mov bx, dx
	mov cx, ax
	;
	mov ax, rz[4]
	mov dx, Q4[1]
	imul dx
	call EXadd
	idiv 5000
	mov Q4[1], ax
	;
	
	;;;;rxQ5
	;
	mov ax, rx[4]
	mov dx, Q5[1]
	imul dx
	mov bx, dx
	mov cx, ax
	;
	mov ax, rx[5]
	mov dx, Q5[2]
	imul dx
	call EXadd
	idiv 5000
	mov Q5[1], ax
	;
	mov ax, rx[7]
	mov dx, Q5[1]
	imul dx
	mov bx, dx
	mov cx, ax
	;
	mov ax, rx[8]
	mov dx, Q5[2]
	imul dx
	call EXadd
	idiv 5000
	mov Q5[2], ax
	;
	
	;;;;rzQ5
	mov ax, rz[0]
	mov dx, Q5[0]
	imul dx
	mov bx, dx
	mov cx, ax
	;
	mov ax, rz[1]
	mov dx, Q5[1]
	imul dx
	call EXadd
	idiv 5000
	mov Q5[0], ax
	;
	mov ax, rz[3]
	mov dx, Q5[0]
	imul dx
	mov bx, dx
	mov cx, ax
	;
	mov ax, rz[4]
	mov dx, Q5[1]
	imul dx
	call EXadd
	idiv 5000
	mov Q5[1], ax
	;
	;;;;rxQ6
	;
	mov ax, rx[4]
	mov dx, Q6[1]
	imul dx
	mov bx, dx
	mov cx, ax
	;
	mov ax, rx[5]
	mov dx, Q6[2]
	imul dx
	call EXadd
	idiv 5000
	mov Q6[1], ax
	;
	mov ax, rx[7]
	mov dx, Q6[1]
	imul dx
	mov bx, dx
	mov cx, ax
	;
	mov ax, rx[8]
	mov dx, Q6[2]
	imul dx
	call EXadd
	idiv 5000
	mov Q6[2], ax
	;
	
	;;;;rzQ6
	mov ax, rz[0]
	mov dx, Q6[0]
	imul dx
	mov bx, dx
	mov cx, ax
	;
	mov ax, rz[1]
	mov dx, Q6[1]
	imul dx
	call EXadd
	idiv 5000
	mov Q6[0], ax
	;
	mov ax, rz[3]
	mov dx, Q6[0]
	imul dx
	mov bx, dx
	mov cx, ax
	;
	mov ax, rz[4]
	mov dx, Q6[1]
	imul dx
	call EXadd
	idiv 5000
	mov Q6[1], ax
	;
	
	;;;;rxQ7
	;
	mov ax, rx[4]
	mov dx, Q7[1]
	imul dx
	mov bx, dx
	mov cx, ax
	;
	mov ax, rx[5]
	mov dx, Q7[2]
	imul dx
	call EXadd
	idiv 5000
	mov Q7[1], ax
	;
	mov ax, rx[7]
	mov dx, Q7[1]
	imul dx
	mov bx, dx
	mov cx, ax
	;
	mov ax, rx[8]
	mov dx, Q7[2]
	imul dx
	call EXadd
	idiv 5000
	mov Q7[2], ax
	;
	
	;;;;rzQ7
	mov ax, rz[0]
	mov dx, Q7[0]
	imul dx
	mov bx, dx
	mov cx, ax
	;
	mov ax, rz[1]
	mov dx, Q7[1]
	imul dx
	call EXadd
	idiv 5000
	mov Q7[0], ax
	;
	mov ax, rz[3]
	mov dx, Q7[0]
	imul dx
	mov bx, dx
	mov cx, ax
	;
	mov ax, rz[4]
	mov dx, Q7[1]
	imul dx
	call EXadd
	idiv 5000
	mov Q7[1], ax
	;
	
	;;;;rxQ8
	;
	mov ax, rx[4]
	mov dx, Q8[1]
	imul dx
	mov bx, dx
	mov cx, ax
	;
	mov ax, rx[5]
	mov dx, Q8[2]
	imul dx
	call EXadd
	idiv 5000
	mov Q8[1], ax
	;
	mov ax, rx[7]
	mov dx, Q8[1]
	imul dx
	mov bx, dx
	mov cx, ax
	;
	mov ax, rx[8]
	mov dx, Q8[2]
	imul dx
	call EXadd
	idiv 5000
	mov Q8[2], ax
	;
	
	;;;;rzQ8
	mov ax, rz[0]
	mov dx, Q8[0]
	imul dx
	mov bx, dx
	mov cx, ax
	;
	mov ax, rz[1]
	mov dx, Q8[1]
	imul dx
	call EXadd
	idiv 5000
	mov Q8[0], ax
	;
	mov ax, rz[3]
	mov dx, Q8[0]
	imul dx
	mov bx, dx
	mov cx, ax
	;
	mov ax, rz[4]
	mov dx, Q8[1]
	imul dx
	call EXadd
	idiv 5000
	mov Q8[1], ax
	;
        ;point to point vecter construct a parametric eq
        ;plane function(find eq which y=plane's y) to get point 

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