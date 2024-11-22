.model small
.stack
.data
    Qc dw 320, 1000, 0
    Q1 dw 420, 1100, 340 ;+++
    Q2 dw 420, 1100, 140 ;++-
    Q3 dw 420, 900, 340  ;+-+
    Q4 dw 220, 1100, 340 ;-++
    Q5 dw 220, 900, 340  ;--+
    Q6 dw 220, 1100, 140 ;-+-
    Q7 dw 420, 900, 140  ;+--
    Q8 dw 220, 900, 140  ;---
    sp1 dw 3 Dup(?)
    sp2 dw 3 Dup(?)
    sp3 dw 3 Dup(?)
    sp4 dw 3 Dup(?)
    Pp dw 320, 0, 240 ;front of center of the screen
.code
main PROC
    ;catch input
    mov ax, @data
    mov ds, ax

ipt:
    mov ah, 10h
    int 16h
    cmp al, 38 ;up
    je topspin
    cmp al, 40 ;down
    je backspin
    cmp al, 37 ;left
    je clockwise
    cmp al, 39 ;right
    je counterclockwise
    cmp al, 27 ;esc
    je exit
    jmp ipt 

    ;rotate cube
    topspin:

        jmp cal

    backspin:

        jmp cal

    clockwise:

        jmp cal

    counterclockwise:
        
        jmp cal

    ;refresh new dot
    ;cal graphic mode
cal:    
        ;point to point vecter construct a parametric eq
        ;plan function(find eq which y=plane's y) to get point 

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