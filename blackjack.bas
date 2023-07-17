1 x=0:y=0:pw=0:dw=0:cp=1:de=2:dt=1:ai=1:di=1:hc=0:pv=0:dv=0
2 dim ca(52,2):dim p(6,2):dim d(6,2):dim o(2)

4 poke 36879,93:poke 646,0:print chr$(147)
5 gosub 26:gosub 110:rem shuf
6 for i=1 to de:dt=0:gosub 120:dt=1:gosub 120:next i:rem deal
7 print chr$(147):x=3:y=1:gosub 25:print "darcys blackjack"
8 x=7:y=3:gosub 25:print "dealer";dw:x=7:y=12:gosub 25:print "player";pw
10 hc=0:dt=0:gosub 60:hc=1:dt=1:gosub 60:rem show
11 dt=0:gosub 80:x=7:y=16:gosub 25:print chr$(146)+chr$(144);
12 if pv>21 then print "*bust*":pv=0:dv=0:dw=dw+1:di=1:ai=1:goto 6
13 x=1:y=16:gosub 25:input "(1)draw or (2)hold";z
14 if z=1 then dt=0:gosub 120:goto 10
15 hc=0:dt=1:gosub 60:x=1:y=16:gosub 25:print "                     "
17 dt=1:gosub 80:if dv>21 then print "*bust*":pv=0:dv=0:pw=pw+1:di=1:ai=1:goto 6
18 if dv<15 then gosub 120:gosub 60:goto 17
19 x=5:y=16:gosub 25:if pv>dv then print "plr wins":pw=pw+1:goto 21
20 if dv>pv then print "dlr wins":dw=dw+1
21 pv=0:dv=0:di=1:ai=1:poke 162,0:wait 162,64:goto 6

25 poke 781,y:poke 782,x:poke 783,0:sys 65520:return:rem set posn

26 rem fill
27 for i=1 to 4:in=(i-1)*13:for j=1 to 13:ca(in+j,1)=j:ca(in+j,2)=i:next j
28 next i:return

30 rem draw
31 gosub 25:print chr$(18)+chr$(5);:if hc=1 goto 45
34 if o(1)=1 then print " a";:goto 39
35 if o(1)<=10 then a$=right$(str$(o(1)),2):print a$;:goto 39
36 if o(1)=11 then print " j";:goto 39
37 if o(1)=12 then print " q";:goto 39
38 if o(1)=13 then print " k";
39 y=y+1:gosub 25
40 if o(2)=1 then print chr$(193)+chr$(32):goto 48
41 if o(2)=2 then print chr$(211)+chr$(32):goto 48
42 if o(2)=3 then print chr$(216)+chr$(32):goto 48
43 if o(2)=4 then print chr$(218)+chr$(32)
44 goto 48
45 print chr$(31)+chr$(166)+chr$(166):y=y+1:gosub 25:print chr$(166)+chr$(166)
48 return

60 rem hand
61 if dt=1 goto 64
62 x=6:y=9:for i=1 to ai-1:o(1)=p(i,1):o(2)=p(i,2):gosub 30:y=y-1:x=x+3:next i
63 return
64 x=6:y=5:for i=1 to di-1:o(1)=d(i,1):o(2)=d(i,2):gosub 30:y=y-1:x=x+3:next i
65 return

80 rem calc
81 if dt=1 goto 91
82 ha=0:pv=0:for i=1 to ai-1
84 if p(i,1)=1 then ha=1:goto 87 
85 if p(i,1)<11 then pv=pv+p(i,1):goto 87
86 pv=pv+10
87 next i 
88 if ha=1 and pv<11 then pv=pv+11:goto 90 
89 if ha=1 then pv=pv+1
90 return
91 ha=0:dv=0:for i=1 to di-1
93 if d(i,1)=1 then ha=1:goto 96
94 if d(i,1)<11 then dv=dv+d(i,1):goto 96
95 dv=dv+10
96 next i 
97 if ha=1 and dv<11 then dv=dv+11:goto 99 
98 if ha=1 then dv=dv+1
99 return

110 rem shuf
111 x=5:y=14:gosub 25:print "          ":x=5:y=14:gosub 25:print " shuffling"
112 z=rnd(-ti)
113 for i=1 to 52:sw=int(rnd(1)*52)+1:cx=ca(i,1):cy=ca(i,2)
114 ca(i,1)=ca(sw,1):ca(i,2)=ca(sw,2)
115 ca(sw,1)=cx:ca(sw,2)=cy:next i
116 x=5:y=14:gosub 25:print "          ":return

120 rem deal
121 if dt=1 goto 125
122 if ai>6 goto 129
123 p(ai,1)=ca(cp,1):p(ai,2)=ca(cp,2):ai=ai+1:cp=cp+1:goto 129
125 if di>6 goto 129
126 d(di,1)=ca(cp,1):d(di,2)=ca(cp,2):di=di+1:cp=cp+1
128 if cp>52 then gosub 110:cp=1
129 return