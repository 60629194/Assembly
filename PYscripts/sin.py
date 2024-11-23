import math
#32000*sin(x), x=0~90
for i in range(0,91):
    #print(i)
    print(round(math.sin((i*(math.pi)/180))*5000),end=', ')
    if i%15 == 0:
        print()