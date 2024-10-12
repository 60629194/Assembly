; add.asm
.MODEL SMALL
.STACK 100h

PUBLIC AddNumbers  ; Make the function public

AddNumbers PROC    ; Function expects two parameters
    ; Parameters are at [BP + 4] and [BP + 6]
    MOV AX, [BP + 4]  ; First argument
    ADD AX, [BP + 6]  ; Add second argument
    RET                ; Return with result in AX
AddNumbers ENDP

END
