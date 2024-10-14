.386                   ; Specify the processor architecture
.model flat, stdcall   ; Use flat memory model and stdcall calling convention
.stack 4096            ; Set stack size

.data
    num1 DWORD 10      ; First number
    num2 DWORD 20      ; Second number
    result DWORD ?     ; Variable to store the result

.code
extern AddNumbers:proc ; Declare the external function ; Declare the ExitProcess function from the Windows API

start:
    push num2          ; Push second parameter
    push num1          ; Push first parameter
    call AddNumbers    ; Call the addition function
    add esp, 8         ; Clean up the stack (remove two DWORDs)

    mov result, eax    ; Store the result in 'result'

    ; Exit the program
    int 21h   ; Call ExitProcess to terminate

end start
