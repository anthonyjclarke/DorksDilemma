; >s:magnificent
; put "magnificent"
;
; as usual the bit that holds
; the whole game together.
;
gloppy
;
sei
;
jsr clswin ;* clear game window
;
; ldx #31
;
; froop
;
; lda $3fa0,x
; sta $3960,x
;
; dex
; bpl froop
;
jsr copybm
;
; copy bomb char
;
ldx #1
stx stop   ;* no move-ment
stx title  ;* on title page
;
dex
stx manx
stx many
stx screen
;
jsr setup  ;* init ted
;
jsr setirq ;* irq's on
;
; lda #0
; sta manx
; sta many
; sta screen
;
jsr radar  ;* print radar
jsr prbder ;* nice border
; jsr prjig  ;* print jigsaw
jsr sludge ;* color on k/j & s/q
jsr high   ;* high score ?
jsr setwin ;* print window
jsr prscrn ;* print info etc
jsr prhisc ;* print table
;
;
lda #$22
sta multi2
;
glloo
;
jsr alter  ;* alterables
;
;
;
;
ldx #$30
jsr delay+2
;
bit jfire
bpl glloo
;
lda #0
sta title
sta level
;
lda #3
sta lives
;
jmp play
;
;
.end
