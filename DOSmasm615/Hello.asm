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
	MOV CX,120 ; X- Coordinate as Column # 
	MOV DX,120;  Y- Coordinate as Row #
;  Drawing Righ Top Line of Diamond from A(100,150) to B(130,180)
.repeat
	int 10h
	dec dx
.until(dx==70)

;  Drawinging Right Bottom Line of Diamond from B(130,180) to C(160,150)
.repeat
	int 10h
	dec cx
.until(cx==70)

;  Drawinging Left Bottom Line of Diamond from C(160,150) to D(130,120)
.repeat
	int 10h
	inc dx
.until(dx==120)

;  Drawinging Left Top Line of Diamond from D(130,120) to A(100,150)
.repeat
	int 10h
	inc cx
.until(cx==120)


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
