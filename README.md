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
- **round** : use after div instruction. \
  Orginal: BX = devisor AX = quotient, DX = remainder\
  Modified: AX = round(DX:AX/BX), DX = remainder
- **abs** : ax = |ax|

### vmem.inc

#### Functions

- **vmem** : draw CX, DX directly in video memory. \
  Color: depends on color db
- **vmemr** : check CX, DX have white pixel or not. \
  return: lineyn 1(yes) 0(no)