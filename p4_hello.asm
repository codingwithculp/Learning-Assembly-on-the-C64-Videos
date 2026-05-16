; -------------------------------------------------
; C64 HELLO WORLD
; Way #2 - Using a labeled text block and loops
; -------------------------------------------------

CHROUT      = $FFD2        ;address of the CHROUT KERNAL routine
PLOT        = $FFF0        ;address of the PLOT KERNAL routine
GETIN       = $FFE4

; -------------------------
; Memory locations
; -------------------------
SCREEN_RAM      = $0400   ;1024 decimal
COLOR_RAM       = $D800   ;55296 decimal
CUR_COLOR       = $0286   ; address of current text color
BORDER          = $D020
BACKGROUND      = $D021

; -------------------------
; Key constants
; -------------------------
KEY_B       = $42
KEY_M       = $4D
KEY_S       = $53
KEY_UP      = $91
KEY_DOWN    = $11
KEY_LEFT    = $9D
KEY_RIGHT   = $1D

; -------------------------
; Color constants
; -------------------------
BLACK           = $00     ;0 decimal
WHITE           = $01     ;1 decimal
RED             = $02     ;2 decimal
CYAN            = $03     ;3 decimal
PURPLE          = $04     ;4 decimal
GREEN           = $05     ;5 decimal
BLUE            = $06     ;6 decimal
YELLOW          = $07     ;7 decimal
ORANGE          = $08     ;8 decima;
BROWN           = $09     ;9 decimal
LIGHT_RED       = $0A     ;10 decimal
GREY_1          = $0B     ;11 decimal
GREY_2          = $0C     ;12 decimal
LIGHT_GREEN     = $0D     ;13 decimal
LIGHT_BLUE      = $0E     ;14 decimal
GREY_3          = $0F     ;15 decimal
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
    ; Set text color to white
    lda #WHITE
    sta CUR_COLOR

clear_screen:
    ; Clear screen
    lda #$93  ;screen code for CLR/HOME
    jsr CHROUT

set_text_position:
    ; Set the cursor position, row 10, col 10
    ldx text_row   ;set the row to 10
    ldy text_col   ;set the column to 10
    clc       ;clear the carry flag for PLOT, this must be done to set the cursor
    jsr PLOT  ;moves the current cursor position



    ; Print message using the KERNAL CHROUT
    ldx #$00  ;start at position 0 in the string
print_loop:
    lda message,x       ;address of message+x
    beq wait_for_key         ; 0 terminator ends string
    jsr CHROUT          ; output character
    inx
    bne print_loop      ; go back to top of loop

wait_for_key:
    jsr GETIN
    beq wait_for_key    ; no key pressed
    cmp #KEY_M
    beq m_key
    cmp #KEY_B
    beq b_key
    cmp #KEY_S
    beq s_key
    cmp #KEY_UP
    beq up_key
    cmp #KEY_DOWN
    beq down_key
    cmp #KEY_LEFT
    beq left_key
    cmp #KEY_RIGHT
    beq right_key
    jmp wait_for_key

m_key:
    inc CUR_COLOR
    jmp set_text_position

b_key:
    inc BORDER
    jmp wait_for_key

s_key:
    inc BACKGROUND
    jmp wait_for_key

up_key:
    lda text_row
    beq wait_for_key
    dec text_row
    jmp clear_screen

down_key:
    lda text_row
    cmp #$18
    beq wait_for_key
    inc text_row
    jmp clear_screen

left_key:
    lda text_col
    beq wait_for_key
    dec text_col
    jmp clear_screen

right_key:
    lda text_col
    cmp #$28 - message_len+1
    beq wait_for_key
    inc text_col
    jmp clear_screen

; labeled PETSCII text (uppercase mode)
message:
     .text "HELLO WORLD!!"
     .byte 0
end_message:

message_len = end_message - message

text_row:
    .byte $0A

text_col:
    .byte $0A





























