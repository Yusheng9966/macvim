import sys, re
a = sys.stdin.readlines()

def do_coment( type, a ):
    b = [l.strip('\r\n').strip('\n') for l in a ]
    if type == "c":
        for l in b:
            print "//",l
    elif type == "html":
        if len(b) == 1:
            print "<!-- ",b[0]," -->"
        else:
            print "<!--"
            for l in b:
                print l
            print "-->"


def do_uncoment( type, a ):
    b = [l.strip('\r\n').strip('\n') for l in a ]
    if type == "c":
        for l in b:
            c = re.findall("^(\\s*)//(.*)$", l )
            if len(c) > 0:
                print c[0][0]+c[0][1]
            else:
                print l
    elif  type == "html":
        if len(b) == 1:
            c = re.findall("^<(\\s*)!--(.*)-->$", b[0] )
            if len(c) > 0:
                print c[0][0]+c[0][1]
        else:
            findhead = False
            for l in b:
                if not findhead:
                    c = re.findall("^(\\s*)<!--(.*)$", l )
                else:
                    c = re.findall("^(.*)-->$", l )
                if len(c)>0:
                        if not findhead:
                            print c[0][0]+c[0][1]
                            findhead = True
                        else:
                            print c[0][0]
                else:
                    print l

            
            


if len(sys.argv)<2:
    exit()
elif len(sys.argv)<3:
    do_coment( sys.argv[1], a )
else:
    do_uncoment( sys.argv[1], a)

    
    




