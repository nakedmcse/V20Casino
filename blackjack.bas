2 rem objects
3 x=0:y=0:pt=0:pc=100:dc=100:cp=1
4 dim ca(52,2):dim p(6,2):dim d(6,2):dim o(2)
5 de=2:dt=1:ai=1:di=1:hc=0:pv=0:dv=0

100 rem main
101 poke 36879,93:poke 646,0:print chr$(147):rem grn-blk
104 x=3:y=1:gosub 210:print "darcys blackjack"
105 x=7:y=3:gosub 210:print "dealer":x=7:y=12:gosub 210:print "player"
107 gosub 300:gosub 310:rem shuf
108 for i=1 to de
109 dt=0:gosub 320:dt=1:gosub 320:rem deal
110 next i
111 hc=0:dt=0:gosub 360:hc=1:dt=1:gosub 360:rem show
112 x=5:y=16:gosub 210:print chr$(146)+chr$(144);:input "see dealer hand";z
114 hc=0:dt=1:gosub 360
115 x=5:y=16:gosub 210:print chr$(146)+chr$(144)+"                ";
116 dt=0:gosub 380:dt=1:gosub 380: rem calc
117 x=5:y=16:gosub 210:print pv;dv;:input z
118 di=1:ai=1:goto 108

210 rem set posn
211 poke 781,y:poke 782,x:poke 783,0:sys 65520:return

300 rem fill cards
303 for i=1 to 4:in=(i-1)*13:for j=1 to 13:ca(in+j,1)=j:ca(in+j,2)=i:next j
305 next i:return

309 rem shuffle
310 x=5:y=14:gosub 210:print "          ":x=5:y=14:gosub 210:print " shuffling"
312 z=rnd(-ti)
313 for i=1 to 52
314 sw=int(rnd(1)*52)+1:cx=ca(i,1):cy=ca(i,2)
315 ca(i,1)=ca(sw,1):ca(i,2)=ca(sw,2)
316 ca(sw,1)=cx:ca(sw,2)=cy
317 next i
318 x=5:y=14:gosub 210:print "          ":return

320 rem deal
321 if dt=1 goto 325
322 if ai>6 goto 330
323 p(ai,1)=ca(cp,1):p(ai,2)=ca(cp,2)
324 ai=ai+1:cp=cp+1:goto 329
325 if di>6 goto 330
327 d(di,1)=ca(cp,1):d(di,2)=ca(cp,2)
328 di=di+1:cp=cp+1
329 if cp>52 then gosub 310:cp=1
330 return

330 rem draw card
331 gosub 210:print chr$(18)+chr$(5);
332 if hc=1 goto 345
333 if o(1)=0 goto 348
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
362 x=6:y=9:for i=1 to ai-1:o(1)=p(i,1):o(2)=p(i,2):gosub 330:y=y-1:x=x+3:next i
366 return
367 x=6:y=5:for i=1 to di-1:o(1)=d(i,1):o(2)=d(i,2):gosub 330:y=y-1:x=x+3:next i
371 return

380 rem calc
381 if dt=1 goto 391
382 ha=0:pv=0
383 for i=1 to ai-1
384 if p(i,1)=1 then ha=1:goto 387 
385 if p(i,1)<11 then pv=pv+p(i,1):goto 387
386 pv=pv+10
387 next i 
388 if ha=1 and pv<11 then pv=pv+11:goto 390 
389 if ha=1 then pv=pv+1
390 return
391 ha=0:dv=0
392 for i=1 to di-1
393 if d(i,1)=1 then ha=1:goto 396
394 if d(i,1)<11 then dv=dv+d(i,1):goto 396
395 dv=dv+10
396 next i 
397 if ha=1 and dv<11 then dv=dv+11:goto 399 
398 if ha=1 then dv=dv+1
399 return
