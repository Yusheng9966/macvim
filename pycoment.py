import sys, re
a = sys.stdin.readlines()

def do_coment( a ):
    b = ["//"+l.strip('\n') for l in a ]
    for l in b:
        print l
def do_uncoment( a ):
    b = [ l.strip('\n') for l in a]
    for l in b:
        c = re.findall("^(\\s*)//(.*)$", l )
        if len(c) > 0:
            print c[0][0]+c[0][1]
        else:
            print l

if len(sys.argv)<=1:
    do_coment(a)
else:
    do_uncoment(a)
    




