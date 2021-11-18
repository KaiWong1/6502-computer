PORTB = $6000
PORTA = $6001
DDRB = $6002
DDRA = $6003

E  = %10000000
RW = %01000000
RS = %00100000

VARX = $4000
VARY = $4001
VARZ = $4002

NUM = $4005
DIV = $4006
RES = $4007
MOD = $4008

BACK_TO_FRONT = $4020

  .org $8000

reset:
  lda #%11111111 ; Set all pins on port A to output
  sta DDRA

  lda #%11100000 ; Set top 3 pins on port B to output
  sta DDRB

  lda #%00011100 ; Set 8-bit mode; 2-line display; 5x8 font
  sta PORTA
  lda #0         ; Clear RS/RW/E bits
  sta PORTB
  lda #E         ; Set E bit to send instruction
  sta PORTB
  lda #0         ; Clear RS/RW/E bits
  sta PORTB

  lda #%01110000 ; Display on; cursor on; blink off
  sta PORTA
  lda #0         ; Clear RS/RW/E bits
  sta PORTB
  lda #E         ; Set E bit to send instruction
  sta PORTB
  lda #0         ; Clear RS/RW/E bits
  sta PORTB

  lda #%01100000 ; Increment and shift cursor; don't shift display
  sta PORTA
  lda #0         ; Clear RS/RW/E bits
  sta PORTB
  lda #E         ; Set E bit to send instruction
  sta PORTB
  lda #0         ; Clear RS/RW/E bits
  sta PORTB

  lda #$0
  sta VARX

  lda #$1
  sta VARY

  lda #$a
  sta DIV

loop:
  lda VARX

  clv
  clc
  adc VARY
  clc
  clv

  sta VARZ

  lda VARY
  sta VARX

  lda VARZ
  sta VARY

  lda VARY
  sta NUM


  ldx #$0

  store_digits:  
    jmp divide

    return_from_div:

    lda MOD
        sta BACK_TO_FRONT, x

        inx

        lda RES
        sta NUM

        lda #$0
        cmp NUM
        bcc store_digits

   dex

   print_digits:
    ldy BACK_TO_FRONT, x
    lda digit_table, y
    sta PORTA
    lda #RS         ; Set RS; Clear RW/E bits
    sta PORTB
    lda #(RS | E)   ; Set E bit to send instruction
    sta PORTB
    lda #RS         ; Clear E bits
    sta PORTB

    dex

    sec
    cpx #$1
    bcc print_digits

    ldx #$0
    delay:
            lda #%00000100
            sta PORTA
            lda #RS         ; Set RS; Clear RW/E bits
            sta PORTB
            lda #(RS | E)   ; Set E bit to send instruction
            sta PORTB
            lda #RS         ; Clear E bits
            sta PORTB
        cpx #$f
        beq next

        inx

        jmp delay 

    next:

        lda #%10000000
        sta PORTA

    lda #0         ; Clear RS/RW/E bits
    sta PORTB
    lda #E         ; Set E bit to send instruction
    sta PORTB
    lda #0         ; Clear RS/RW/E bits
    sta PORTB

  jmp loop

divide:
  lda #$0
  sta RES

  lda #$0
  sta MOD

  div_loop:
    lda NUM
    cmp DIV
    bcc answer

    lda NUM

    sec
    sbc DIV
    clc
    clv

    sta NUM

    inc RES
    jmp div_loop

  answer:
    lda NUM
    sta MOD
    jmp return_from_div

digit_table:
  .word $8c0c
  .word $cc4c
  .word $ac2c
  .word $ec6c
  .word $9c1c


  .org $fffc
  .word reset
  .word $0000
