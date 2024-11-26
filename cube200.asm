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
        jmp cal
    backspin:

        jmp cal
    clockwise:

        jmp cal
    counterclockwise:

        jmp cal

cal:
	;project here

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