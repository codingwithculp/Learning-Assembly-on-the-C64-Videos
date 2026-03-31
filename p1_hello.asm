; -------------------------------------------------
; C64 HELLO WORLD via direct screen writes
; Screen clear via KERNAL CHROUT ($93)
; David Culp
; codingwithculp@gmail.com
; -------------------------------------------------

; -------------------------
; Memory locations
; -------------------------
SCREEN_RAM  = 1024      ;1024 decimal
COLOR_RAM   = $D800      ;55296 decimal

; -------------------------
; KERNAL routine
; -------------------------
CHROUT      = $FFD2      ;65490 decimal 

; -------------------------
; Colors
; -------------------------
WHITE       = $01        ;1 decimal
LIGHT_BLUE  = $0E        ;14 decimal

; CODE BEGINS HERE!
* = $033C      ;decimal 828, start of cassette buffer

start:
     ; Clear screen using KERNAL
     lda #$93            ; CLR/HOME control code (decimal 147)
     jsr CHROUT

; -------------------------------------------------
; write "HELLO WORLD" one letter at a time
; row 11, column 11
; offset = (10 * 40) + 10 = 410 = $019A
; These are PETSCII char codes, NOT ASCII!
; -------------------------------------------------
     lda #$08            ; H
     sta SCREEN_RAM + $019A
     lda #WHITE
     sta COLOR_RAM + $019A
     
     lda #$05            ; E
     sta SCREEN_RAM + $019B
     lda #WHITE
     sta COLOR_RAM + $019B
     
     lda #$0C            ; L
     sta SCREEN_RAM + $019C
     sta SCREEN_RAM + $019D
     lda #WHITE
     sta COLOR_RAM + $019C
     sta COLOR_RAM + $019D
     
     lda #$0F            ; O
     sta SCREEN_RAM + $019E
     lda #WHITE
     sta COLOR_RAM + $019E
     
     lda #$20            ; space
     sta SCREEN_RAM + $019F
     
     lda #$17            ; W
     sta SCREEN_RAM + $01A0
     lda #WHITE
     sta COLOR_RAM + $01A0
     
     lda #$0F            ; O
     sta SCREEN_RAM + $01A1
     lda #WHITE
     sta COLOR_RAM + $01A1
     
     lda #$12            ; R
     sta SCREEN_RAM + $01A2
     lda #WHITE
     sta COLOR_RAM + $01A2
     
     lda #$0C            ; L
	 sta SCREEN_RAM + $01A3
     lda #WHITE
     sta COLOR_RAM + $01A3
     
	lda #$04            ; D
     sta SCREEN_RAM + $01A4
     lda #WHITE
     sta COLOR_RAM + $01A4

; Keep program running
forever:
	jmp forever


















