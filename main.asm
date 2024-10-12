; main.asm
.MODEL SMALL
.STACK 100h

EXTRN AddNumbers:PROC  ; Declare the external function

DATA SEGMENT
    num1 DW 5           ; First number
    num2 DW 10          ; Second number
    result DW ?         ; Variable to store the result
    resultStr DB 6 DUP('$') ; Buffer to store the result string
DATA ENDS

CODE SEGMENT
    START:
        ; Push parameters onto the stack (second argument first)
        MOV AX, num2
        PUSH AX           ; Push the second number
        MOV AX, num1
        PUSH AX           ; Push the first number

        ; Call the AddNumbers function
        CALL AddNumbers

        ; The result is now in AX; store it in result variable
        MOV result, AX

        ; Convert the result to string
        CALL ConvertToString

        ; Display the result
        MOV DX, OFFSET resultStr
        MOV AH, 09h       ; DOS function to display a string
        INT 21h

        ; Clean up the stack (2 parameters = pop twice)
        ADD SP, 4        ; Adjust stack pointer after the call
        
        ; Exit program
        MOV AX, 4C00h    ; Terminate program
        INT 21h

    ; Convert a number in AX to a string in resultStr
    ConvertToString PROC
        MOV BX, 10       ; Divisor for decimal conversion
        XOR CX, CX       ; Clear CX for digit count

    ConvertLoop:
        XOR DX, DX       ; Clear DX for division
        DIV BX            ; AX / 10, quotient in AX, remainder in DX
        PUSH DX           ; Push remainder (digit)
        INC CX            ; Increment digit count
        TEST AX, AX      ; Check if quotient is 0
        JNZ ConvertLoop   ; If not, continue loop

    ; Pop digits from stack to resultStr
    MOV DI, OFFSET resultStr
    MOV BYTE PTR [DI + CX], '$' ; Null-terminate the string

    PopLoop:
        POP DX           ; Get the digit
        ADD DL, '0'      ; Convert to ASCII
        DEC CX           ; Decrement count
        MOV [DI + CX], DL ; Store character in string
        CMP CX, 0
        JG PopLoop       ; Repeat for all digits

        RET
    ConvertToString ENDP

CODE ENDS

END START
