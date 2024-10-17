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
	MOV CX, 0 ; X- Coordinate as Column # 
	MOV DX, 0;  Y- Coordinate as Row #
;  Drawing Righ Top Line of Diamond from A(100,150) to B(130,180)
;right up 

;(cx-50)^2+(dx-50)^2=50^2
.repeat
	mov cx, 0
	inc dx
.repeat
	mov ax, 50
	cmp ax, cx
	ja cm1
	mov ax, cx
	sub ax, 50 ;cx-50
	mul ax
	jmp next
cm1: 
	sub ax, cx
	mul ax
next:
	mov bx, ax
	
	mov ax, 50
	cmp ax, dx
	ja cm2
	mov ax, dx
	sub ax, 50
	mul ax
	jmp next2
cm2:
	sub ax, dx
	mul ax  ; ax store calDx ; bx store calCx
next2: 
	add ax, bx
	cmp ax, 2400
	jb o1
	cmp ax, 2600
	ja o1
	mov ax, 0C01h
	mov bx, cx
	mov si, dx
	mov cx, bx
	mov dx, si
	int 10h
o1:
	inc cx
.until(cx==200)

.until(dx==200)
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
