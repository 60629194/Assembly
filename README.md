# Assembly

## Function Documents

To use the functions, include xxx.inc in code section.

### trig.inc

**\*require declaration in data section**

> EXTERNDEF sin1:WORD

#### Functions

- **sin** : ax = 5000 \* sin(ax°) , 0 ≦ ax ≦ 360
- **cos** : ax = 5000 \* cos(ax°) , 0 ≦ ax ≦ 360

### math.inc

#### Functions

- **EXadd** : DX:AX = DX:AX + BX:CX
- **round** : BX = quotient, use after div instruction (<span style="color:red">UNTESTED</span>)
