.MODEL SMALL
.STACK 100h
.DATA
    num1 DB ?
    num2 DB ?
    result DB ?
    msgInput1 DB 'Enter first number: $'
    msgInput2 DB 'Enter second number: $'
    msgAdd DB 'Result of addition: $'
    msgSub DB 'Result of subtraction: $'

.CODE
EXTERN ADDITION: PROC
EXTERN SUBTRACTION: PROC

MAIN PROC
    ; Initialize data segment
    MOV AX, @DATA
    MOV DS, AX

    ; Get first number
    LEA DX, msgInput1
    MOV AH, 09h
    INT 21h
    MOV AH, 01h
    INT 21h
    SUB AL, '0'      ; Convert ASCII to integer
    MOV num1, AL

    ; Get second number
    LEA DX, msgInput2
    MOV AH, 09h
    INT 21h
    MOV AH, 01h
    INT 21h
    SUB AL, '0'      ; Convert ASCII to integer
    MOV num2, AL

    ; Call addition function
    CALL ADDITION
    LEA DX, msgAdd
    MOV AH, 09h
    INT 21h
    MOV AL, result
    ADD AL, '0'      ; Convert back to ASCII
    MOV DL, AL
    MOV AH, 02h
    INT 21h

    ; Call subtraction function
    CALL SUBTRACTION
    LEA DX, msgSub
    MOV AH, 09h
    INT 21h
    MOV AL, result
    ADD AL, '0'      ; Convert back to ASCII
    MOV DL, AL
    MOV AH, 02h
    INT 21h

    ; Exit program
    MOV AX, 4C00h
    INT 21h
MAIN ENDP

END MAIN
