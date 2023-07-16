1 rem darcys blackjack
2 rem objects
3 x=0:y=0:pt=0:pc=100:dc=100:cp=1
4 dim ca(52,2):rem cards a=11 jq k=14
5 dim p(10,2):dim d(10,2):dim o(2)
6 de=2:dt=1:ai=1:di=1:hc=0

100 rem main
101 gosub 200
102 print chr$(147);
103 x=3:y=1:gosub 210:print "darcys blackjack";
104 x=7:y=3:gosub 210:print "dealer";
105 x=7:y=12:gosub 210:print "player";
106 gosub 300:gosub 310: rem fill/shuffle
107 for i=1 to de
108 dt=0:gosub 320:dt=1:gosub 320: rem deal
109 next i
110 hc=1:dt=0:gosub 360:hc=0:dt=1:gosub 360: rem show
111 x=5:y=16:gosub 210:print chr$(146)+chr$(144);
112 input "see dealer hand";z
113 hc=0:dt=0:gosub 360
114 x=5:y=16:gosub 210:print chr$(146)+chr$(144)+"                ";
115 x=5:y=16:gosub 210:input z
116 end

200 rem set colors
201 poke 36879,93:rem green back
202 poke 646,0:rem black 
203 return

210 rem set posn
211 poke 781,y:poke 782,x:poke 783,0:sys 65520
212 return

300 rem fill cards
301 x=5:y=14:gosub 210:print "          ";
302 x=5:y=14:gosub 210:print " filling";
303 for i=1 to 4: in=(i-1)*13
304 for j=1 to 13:ca(in+j,1)=j:ca(in+j,2)=i:next j
305 next i
306 x=5:y=14:gosub 210:print "          ";
307 return

309 rem shuffle
310 x=5:y=14:gosub 210:print "          ";
311 x=5:y=14:gosub 210:print " shuffling";
312 z=rnd(-ti)
313 for i=1 to 52
314 sw=int(rnd(1)*52)+1:cx=ca(i,1):cy=ca(i,2)
315 ca(i,1)=ca(sw,1):ca(i,2)=ca(sw,2)
316 ca(sw,1)=cx:ca(sw,2)=cy
317 next i
318 x=5:y=14:gosub 210:print "          ";
319 return

320 rem deal
321 if dt=1 goto 325
322 if ai>10 goto 330
323 p(ai,1)=ca(cp,1):p(ai,2)=ca(cp,2)
324 ai=ai+1:cp=cp+1:goto 329
325 if di>10 goto 330
327 d(di,1)=ca(cp,1):d(di,2)=ca(cp,2)
328 di=di+1:cp=cp+1
329 if cp>52 then gosub 310:cp=1
330 return

330 rem print card
331 gosub 210:print chr$(18)+chr$(5);
332 if hc=1 goto 345
333 if o(1)=0 goto 344
334 if o(1)=1 then print " a";:goto 339
335 if o(1)<=10 then a$=right$(str$(o(1)),2):print a$;:goto 339
336 if o(1)=11 then print " j";:goto 339
337 if o(1)=12 then print " q";:goto 339
338 if o(1)=13 then print " k";
339 y=y+1:gosub 210
340 if o(2)=1 then print chr$(193)+chr$(32):goto 348
341 if o(2)=2 then print chr$(211)+chr$(32):goto 348
342 if o(2)=3 then print chr$(216)+chr$(32):goto 348
343 if o(2)=4 then print chr$(218)+chr$(32)
344 goto 348
345 print chr$(31)+chr$(166)+chr$(166);
346 y=y+1:gosub 210
347 print chr$(166)+chr$(166)
348 return

360 rem draw hand
361 if dt=1 goto 367
362 x=6:y=5
363 for i=1 to ai
364 o(1)=p(i,1):o(2)=p(i,2):gosub 330:y=y-1:x=x+3
365 next i
366 return
367 x=6:y=9
368 for i=1 to di
369 o(1)=d(i,1):o(2)=d(i,2):gosub 330:y=y-1:x=x+3
370 next i
371 return