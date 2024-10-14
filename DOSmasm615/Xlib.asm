.386                ; Specify the processor architecture
.model flat, stdcall ; Use flat memory model and stdcall calling convention
.stack 4096         ; Set stack size

.data
; If you need to define variables, do so here.

.code

public AddNumbers    ; Declare the function as public

AddNumbers proc num1:word, num2:word
    pop num1
	mov ax, num1 
	pop num2; Move first parameter into AX
    add ax, num2    ; Add second parameter to AX
    ret              ; Return with the result in AX
AddNumbers endp

end
