; >s:edit-jigsaw
; put "edit-jigsaw"
;
; called when tha basic loop is
; in control
;
edit
;
lda #0
sta jigx
sta jigy
sta swap
;
releso
;
jsr chkspc ;* space status
bcs releso ;* release space
;
edjig1
;
ldx #$30
jsr delay+2
;
jsr chkspc ;* space to return
bcc caryon
;
yesfab
;
jsr chkspc ;* please release it !
bcs yesfab
;
jsr coljig ;* tidy up colour
;
rts
;
caryon
;
jsr jiggy  ;* move the cursor
;
bit jfire  ;* fire to copy ?
bpl edjig1
;
lda swap   ;* second time here
bne place  ;* so now copy it
;
lda sl
sta copyl
lda sl+1
sta copyl+1
;
; save address
;
ldy #0
lda (sl),y ;* copy char
sta copych
sta $e01+80
;
lda #1
sta swap
;
bne edjig1
;
place
;
; second time that fire is
; pressed so lets swap it
;
ldy #0
lda (sl),y     ;* current char
;
sta (copyl),y  ;* swop it
;
lda copych     ;* replace char
sta (sl),y     ;* put it on
;
lda #0
sta swap
lda #37
sta $e01+80
;
jmp edjig1
;
;
;-++++++++++++++++++++++++++++-
;
jiggy
;
; move the cursor about
;
ldx jigx
ldy jigy
;
bit jleft
bpl leno
;
cpx #0
beq leno    ;* at left
;
dex
;
leno
;
bit jright
bpl rino
;
cpx #4
beq rino    ;* at right
;
inx
;
rino
;
bit jup
bpl upno
;
cpy #0
beq upno    ;*  at top
;
dey
;
upno
;
bit jdown
bpl dono
;
cpy #4
beq dono    ;* at bottom
;
iny
;
dono
;
stx jigx
sty jigy
jsr jigxy
;
jsr coljig  ;* colour the jigsaw
;
lda ted
and #%11110111 ;* rnd colour
;
ldy #0
sta (cl),y  ;* colour edit square
;
rts
;
;--------------------------------
;
jigxy
;
; add offsets
;
txa
clc
adc #34
tax
;
tya
clc
adc #12
tay
;
jsr xy
;
rts
;
;********************************
;
coljig
;
; colour the jigsaw with the
; following rules:-
;
; 1) if piece of jigsaw but in
;    wrong place then lum=$40
;
; 2) if not a piece of jigsaw
;    then lum=$10
;
; 3) if piece of jiigsaw and in
;    right place then lum=$70
;
;
ldx #0
stx nocorr
;
lda #215
sta jigno      ;* start jig char
;
cjig1
;
ldy rady,x
lda $e02,y     ;* get char
;
cmp #27        ;* empty jig char
bne noemp
;
lda #$64
bne colit
;
noemp
;
cmp jigno      ;* correcy char ?
bne nocor
;
inc nocorr     ;* another correct
;
lda #$71
bne colit
;
nocor
;
lda #$10
;
colit
;
sta $a02,y     ;* colour on
;
inc jigno      ;* next piece
;
inx
cpx #25
;
bne cjig1      ;* do full grid
;
lda nocorr     ;* # in correct
cmp #25
;
bne ntfind
;
; well donw he's completed this
; level
;
jmp uplevl
;
ntfind
;
rts
;
;********************************
;
prjig
;
; print initial jigsaw
;
ldx #24
;
lda #239
sta char
;
prjig1
;
ldy rady,x
;
lda char
sta $e02,y
;
dec char
;
dex
bpl prjig1
;
; jsr coljig ;* print some colour
;
rts
;
;
;-------------------------------
;
;
;
.end
