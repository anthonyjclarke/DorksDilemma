; >s:bomb-code
; put "bomb-code"
;
;
; all the time-bomb stuff
;
bomb
;
; the time-bomb will work as
; follows :-
;
; 1> fire button drops a bomb
;    & sets up a timer
;
; 2> timer counts down
;
; 3> a rustic fill
;
lda bombon  ;* bomb already on ?
bne bm1
;
lda bready  ;* bomb recharged ?
beq bm1     ;* not yet
;
ldx manx
ldy many
;
lda dir
and #3
beq berm1
;
inx
;
berm1
;
lda dir
and #$c
beq berm2
;
iny
;
berm2
;
stx bomx
sty bomy ;* tl co-ord
;
jsr xy
;
lda sl
sta bomsl
sta bomcl
;
lda sl+1
sta bomsl+1
;
lda cl+1
sta bomcl+1
;
; get screen and colour address
;
lda #55
sta timer   ;* count down
;
ldx #1
stx bombon  ;* one's on now.
;
dex
stx bombgo
;
lda sndflg
beq bm1
;
lda #$2f
sta vol
;
; chan #2,normal (noise later)
;
lda #0
sta sou2hi
sta sou2lo
;
bm1
;
rts
;
;----------------------------
;
upbomb
;
; called under interrupt to
; count the timer down & does
; a flag to tell the basic loop
; to do the explosion.
;
jsr ready    ;* update charger
;
lda bombon
beq timoot
;
; only do this if the bomb is on
;
jsr bomprt  ;* print it (flash)
;
dec timer
beq stbomb  ;* lo byte
;
lda #56
sec
sbc timer   ;* inverse
;
asl a
rol moron
asl a
rol moron
asl a
rol moron
asl a
rol moron
sta sou2lo  ;* sound *16
;
lda moron
sta sou2hi  ;* sounh hi
;
timoot
;
rts
;
stbomb
;
lda #1
sta bombgo  ;* tell basic to go!
;
rts
;
;-------------------------------
;
basbom
;
; called by the basic loop to
; do the whooppee explosion.
;
lda bombgo
bne gobomr
;
rts
;
gobomr
;
lda antfag
beq gobomr
;
; wait for man to be in a char.
; (so we have no hassle detecting)
;
; we are in control.
;
lda #$ff
sta sou2lo
sta sou2hi
;
lda sndflg
beq stew2
;
lda #$4f
sta vol     ;* noise now
;
stew2
;
ldx #1
stx stop    ;* no irq's
;
; insert mega/code here.
;
jsr findtl
;
; find the address of the tl of
; the man for use after the fill
; to see if he died
;
jsr filbmb
;
; do the bomb fill
;
sei
;
ldx #31
;
clbmbc
;
lda #0
sta $3960,x
dex
bpl clbmbc
;
; clear charge char
;
; now stop all bomb stuff.
;
lda #0
sta stop
sta bombgo
sta bombon
sta bready ;* start charge
sta chtime ;* charge time
sta vol    ;* sound off
;
cli
;
rts
;
;*****************************
;
bomprt
;
; print it
;
;
ldx #3
;
lda #247
sta char
;
lda ted
ora #%00001000
sta bmbcol      ;* multi colour
;
sod1
;
ldy yval2,x
lda char
sta (bomsl),y
;
lda bmbcol
sta (bomcl),y      ;* flash colour
;
dec char
dex
bpl sod1
;
rts
;
;------------------------------
;
ready
;
; do the chargeing of the bomb
; set 'bready' to 1 if ok.
;
lda bready
beq upchrg
;
; whats the use - its ready !
;
kwah            ;* exit branch
;
rts
;
upchrg
;
dec chtime      ;* timer
bne chrge
;
lda #1
sta bready
;
jsr copybm
;
; copy full bomb across
;
rts
;
chrge
;
; update the char
;
; the chars that are used as the
; recharging bomb are
;
; $2c,$2d
; $2e,$2f
;
lda chtime
and #$0f
bne kwah       ;* wait for top
;              ;* bit to change
;
; now scroll char up to make
; room for new data
;
lda $3970
pha
lda $3978
pha
;
ldx #0
;
scrol
;
lda $3961,x
sta $3960,x
;
lda $3969,x
sta $3968,x
;
lda $3971,x
sta $3970,x
;
lda $3979,x
sta $3978,x
;
inx
cpx #7
bne scrol
;
pla
sta $396f
;
pla
sta $3967
;
lda chtime     ;* $ff - $00
;
lsr a
lsr a
lsr a
lsr a
;
; 0-15
;
eor #$0f
;
tay
;
and #8
beq botbmb    ;* doing top 2
;
tya
and #7
clc           ;* x = 0 to 7
adc #16
tay
;
botbmb
;
tya
;
; y holds offset to char data
;
lda $3fa0,y
sta $3977     ;* left char
;
lda $3fa0+8,y
sta $397f     ;* right char
;
rts
;
;
;
;
;
;
.end
