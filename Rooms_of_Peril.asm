// Seems to be main file for pulling it all together 
//
//
//
//
//
// >s:rooms of peril
// put "rooms of peril"
//
// (c) 1985 micro-projects ltd.
//
//
//    for gremlin graphics ltd.
//
//
// started 5th march 1985
//
//
.opt nol
//
.lib main-vars* //* system vars
.lib macros*    //* maccies !
.lib vars*      //* variables
.lib extra*     //* extra memory !
//
*=$1960
//
lda #$05
jsr $ffd2
//
lda #$93
jsr $ffd2
//
sei
//
// ldx #$fe
// txs
//
jsr clvars
//
lda #<messt
ldx #>messt
//
sta mesl
stx mesl+1
//
jsr inhisc     //* set up hall tbl
//
jmp gloppy
//
sndflg .byte 1 //* sound on/off
joysel .byte 0 //* joy/kbd
level  .byte 0 //* level num
//
.lib play-*     //* game loop
.lib joy*       //* read joydik
.lib irq*       //* errrr.
.lib raster*    //* raster service
.lib utils*     //* utilities
.lib key*       //* read keybrd
.lib mess*      //* scroll mess.
//.lib whoop*     //* message data
.lib setup*     //* init ted etc.
.lib decode*    //* decode screens
.lib move*      //* move man
.lib check-*    //* check man
.lib change-ro* //* room change
.lib tables*    //* mega tables
// .lib hexer*     //* to hex
.lib radar*     //* radar scanner
.lib init-room* //* set up rooms
.lib dumper*    //* fade in rooms
.lib aliens-m*  //* move aliens
.lib alien-chek*//* pr/chk aliens
.lib inkey*     //* scan keys
.lib animate*   //* animate chars
.lib border*    //* print borders
.lib jigsaw*    //* jiggy code
.lib bomb*      //* mega bomb
.lib fill*      //* bomb fill stuff
.lib edit-*     //* edit jigsaw
.lib command*   //* escape/edit
.lib scatter*   //* scatter jigsaw
.lib hall*      //* high-table
.lib magnif*    //* title loop
.lib high-*     //* high - stuff
.lib screen*    //* init screen
.lib variet*    //* alien chars
.lib death-*    //* dead code
.lib game-*     //* game over
.lib altera*    //* select j/k etc
.lib title*     //* scroll border
.lib score*     //* score stuff
.lib work-h*    //* high table work
.lib killer*    //* kill alienlogic
.lib level*     //* increase level
.lib whoop*     //* nice message
//
//
//
//
//
.end
