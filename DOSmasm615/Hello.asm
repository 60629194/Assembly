; Sampel code for HelloWorld using MASM615 and DOSBox
.MODEL SMALL        ; Define memory model as small
.STACK 100H         ; Define stack size as 100h (256 bytes)
.DATA               ; Start of data segment
MSG db 10,13,'    Fakhar STEM Spher:  ',10,13,'$'  ; Define a message string with carriage return and line feed at the beginning and end
.CODE               ; Start of code segment
MAIN PROC           ; Start of main procedure
    MOV AX, @DATA      ; Move the address of the data segment into the AX register
    MOV DS, AX         ; Move the address of the data segment into the DS register
    MOV DX, OFFSET MSG ; Put the offset address of the message string into the DX register
    mov AH,09          ; Set AH register to 09h (function to print a string)
    INT 21h            ; Call interrupt 21h (print the message)
    MOV AH,4CH         ; Set AH register to 4Ch (function to terminate the program)
    INT 21h            ; Call interrupt 21h (terminate program)
MAIN ENDP           ; End of main procedure
END MAIN            ; End of program
