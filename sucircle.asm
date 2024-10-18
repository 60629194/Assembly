.model small
.stack 100h 
.data
.code
main proc
; Set Graphics Mode
	MOV AX,11h; High Resolution B/W Mode: 640x480 B/W graphics
;Above line Means AH = 00 and AL = 11h
	INT 10h; Selecting Inerrupt for Graphics ;(Video); mode
; Displaying Pixel
	MOV AH, 0Ch; Write pixel on the screen
	MOV AL, 01h ;white Color
    MOV CX, 0
    MOV DX, 0
    int 10h
;(x-100)^2+(y-100)^2＝2500

.repeat
    inc dx
    .repeat
    inc cx 
    push cx
    push dx

    cmp cx, 100
    jb cmin 
    sub cx, 100
    mov ax, cx
    mov bx, dx
    mul ax
    cmp dx, 0
    jne OOR
    mov dx, bx
    mov cx, ax ;(x-100)^2
    jmp cset
cmin:
    mov ax, 100
    sub ax, cx
    mov bx, dx
    mul ax
    cmp dx, 0
    jne OOR
    mov dx, bx
    mov cx, ax ;(100-x)^2
cset:
    cmp dx, 100
    jb dmin
    sub dx, 100
    mov ax, dx
    mov bx, dx
    mul ax
    cmp dx, 0
    jne OOR
    mov dx, bx
    mov dx, ax ;(y-100)^2
    jmp dset
dmin:
    mov ax, 100
    sub ax, dx
    mov bx, dx
    mul ax
    cmp dx, 0
    jne OOR
    mov dx, bx
    mov dx, ax; (100-y)^2
dset:
    add dx, cx
    jc OOR
    mov ax, dx
    pop dx
    pop cx
    cmp ax, 2750
    ja nofit
    cmp ax, 2350
    jb nofit
    MOV AH, 0Ch; Write pixel on the screen
	MOV AL, 01h ;white Color
    int 10h
nofit:
    .until(cx==640)
    mov cx, 0
.until(dx==480)

JMP ClearScreen

OOR:
    pop dx
    pop cx
    jmp nofit

ClearScreen:
	
	MOV AH, 08h ; input a character from Keyboard withouot displaying on the screen
	INT 21h
	
.IF AL != 13
	JMP ClearScreen
.ENDIF
; Shifting Video Mode to Text Mode Means it Clears the Screen
	mov al , 03 ; function code for setting the text mode.
	mov ah,0    ; Video Mode
	int 10h		; Switching from Video Mode to Text Mode

mov ah,4ch      ; Terminate program
int 21h
main endp
end main         ; End of program
