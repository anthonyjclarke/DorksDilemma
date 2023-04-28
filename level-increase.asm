; >s:level-increase
; put"level-increase"
;
;
;
; a call to this routine sets up
; all the varaibles affected by
; 'level'
;
setlvl
;
ldx level
;
lda lvalmv,x
sta almvet
;
; alien move tempo
;
lda lvnokl,x
sta kilhex
;
; no. to kill (hex)
;
lda lvnokk,x
sta kildec
;
; no. to kill (dec)
;
rts
;
;------------------------
;
lvalmv
;
.byte 20,16,12,8,4
;
lvnokl
;
.byte 10,15,20,25,30
;
lvnokk
;
.byte $11,$16,$21,$26,$31
;
;------------------------
;
uplevl
;
; a call to this ups the level
; and prints a message
;
inc level
lda level
cmp #5
bne mlok
;
lda #4
sta level
;
mlok
;
; level never > 4
;
jsr clswin
;
ldx #<lvlovr
ldy #>lvlovr
jsr pwint
;
jsr clssnd
jsr clssnd
jsr clssnd
;
jmp play
;
;-------------------
;
lvlovr
;
.byte 8,8,$76,86,72,106,72,86,32,68,92,88,94,86,72,102,72,70,40,0
.byte 8,9,$66,87,73,107,73,87,32,69,93,89,95,87,73,103,73,71,41,0
;
; level completed
;
.byte 9,12,$75,90,92,108,32,94,86,64,112,32,102,78,80,100,0
.byte 9,13,$65,91,93,109,32,95,87,65,113,32,103,79,81,101,0
;
; now play this
;
.byte $ff
;
;
.end
