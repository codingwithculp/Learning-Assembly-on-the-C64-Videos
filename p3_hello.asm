; -------------------------------------------------
; C64 HELLO WORLD
; Way #2 - Using a labeled text block and loops
; -------------------------------------------------

CHROUT    = $FFD2        ;address of the CHROUT KERNAL routine
PLOT      = $FFF0        ;address of the PLOT KERNAL routine

; -------------------------
; Memory locations
; -------------------------
SCREEN_RAM     = $0400   ;1024 decimal
COLOR_RAM      = $D800   ;55296 decimal
CUR_COLOR      = $0286   ; address of current text color

; -------------------------
; Color constants
; -------------------------
BLACK          = $00     ;0 decimal
WHITE          = $01     ;1 decimal
RED            = $02     ;2 decimal
CYAN           = $03     ;3 decimal
PURPLE         = $04     ;4 decimal
GREEN          = $05     ;5 decimal
BLUE           = $06     ;6 decimal
YELLOW         = $07     ;7 decimal
ORANGE         = $08     ;8 decima;
BROWN          = $09     ;9 decimal
LIGHT_RED      = $0A     ;10 decimal
GREY_1         = $0B     ;11 decimal
GREY_2         = $0C     ;12 decimal
LIGHT_GREEN    = $0D     ;13 decimal
LIGHT_BLUE     = $0E     ;14 decimal
GREY_3         = $0F     ;15 decimal
; ------------------------------------------------
; BASIC stub
; puts "10 SYS2064" into the start of BASIC
; ------------------------------------------------
*= $0801      ;start of BASIC

.word next     ; 2 bytes pointer to the next BASIC line ($080B - $080C)
.word 10       ; 2 bytes for the line number ($0803 - $0804)
.byte $9e      ; 1 byte token code for SYS ($0805)
.text "2064"   ; 4 bytes for "2064"
.byte 0        ; 1 byte for BASIC line terminator for 10 bytes total ($080A)
next:
.word 0        ; null pointer to mark the end of the BASIC program ($080B - $080C)
; ------------------------------------------------
;  END BASIC stub
; ------------------------------------------------

*= $0810      ;place code startinmg at address $0810(2064)

start:
     ; Clear screen
     lda #$93  ;screen code for CLR/HOME
     jsr CHROUT

     ; Set the cursor position, row 10, col 10
     ldx #$0A   ;set the row to 10
     ldy #$0A   ;set the column to 10
     clc        ;clear the carry flag for PLOT, this must be done to set the cursor
     jsr PLOT   ;moves the current cursor position

     ; Set text drawing color to white
     lda #WHITE
     sta CUR_COLOR  

     ; Print message using the KERNAL CHROUT in a loop indexed by the x register
     ldx #$00  ;start at position 0 in the string
print_loop:
     lda message,x     ; absolute, x addressing mode.  Actual address is calaculated as message+x
     beq forever       ; 0 terminator ends string.  Branch if 0 is in the A reg. otherwise continue
     jsr CHROUT        ; output the char in the A reg
     inx               ; increment the x reg by 1
     bne print_loop    ; go back to top of loop and do it again

forever:
     jmp forever

; labeled PETSCII text (uppercase mode)
message:
     .text "HELLO WORLD"
     .byte 0










