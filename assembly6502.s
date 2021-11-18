PORTB = $6000
PORTA = $6001
DDRB = $6002
DDRA = $6003

E  = %10000000
RW = %01000000
RS = %00100000

  .org $8000

reset:
  lda #%11111111 
  sta DDRB

  lda #%11100000 
  sta DDRA

  lda #%00111000 		
  sta PORTB
  lda #0         
  sta PORTA
  lda #E          
  sta PORTA
  lda #0          
  sta PORTA

  lda #%00001110  
  sta PORTB
  lda #0           

  lda #E          
  sta PORTA
  lda #0         
  sta PORTA

  lda #%00000110 
  sta PORTB
  lda #0         
  sta PORTA
  lda #E        
  sta PORTA
  lda #0         
  sta PORTA

  lda #"p"
  sta PORTB
  lda #RS         
  sta PORTA
  lda #(RS | E)   
  sta PORTA
  lda #RS       
  sta PORTA

  lda #"e"
  sta PORTB
  lda #RS       
  sta PORTA
  lda #(RS | E)   
  sta PORTA
  lda #RS         
  sta PORTA

  lda #"e"
  sta PORTB
  lda #RS         
  sta PORTA
  lda #(RS | E)   
  sta PORTA
  lda #RS         
  sta PORTA

  lda #"p"
  sta PORTB
  lda #RS         
  sta PORTA
  lda #(RS | E)   
  sta PORTA
  lda #RS   
  sta PORTA

  lda #"e"
  sta PORTB
  lda #RS         
  sta PORTA
  lda #(RS | E)   
  sta PORTA
  lda #RS         
  sta PORTA

  lda #"e"
  sta PORTB
  lda #RS         
  sta PORTA
  lda #(RS | E)   
  sta PORTA
  lda #RS         
  sta PORTA

  lda #"p"
  sta PORTB
  lda #RS       
  sta PORTA
  lda #(RS | E)						
  sta PORTA
  lda #RS         
  sta PORTA

  lda #"o"
  sta PORTB
  lda #RS       
  sta PORTA
  lda #(RS | E)   
  sta PORTA
  lda #RS         
  sta PORTA

  lda #"o"
  sta PORTB
  lda #RS       
  sta PORTA
  lda #(RS | E)   
  sta PORTA
  lda #RS         
  sta PORTA

  lda #"p"
  sta PORTB
  lda #RS         
  sta PORTA
  lda #(RS | E)   
  sta PORTA
  lda #RS         
  sta PORTA

  lda #"o"
  sta PORTB
  lda #RS       
  sta PORTA
  lda #(RS | E)   
  sta PORTA
  lda #RS         
  sta PORTA

  lda #"o"
  sta PORTB
  lda #RS       
  sta PORTA
  lda #(RS | E)   
  sta PORTA
  lda #RS         
  sta PORTA

  lda #" "
  sta PORTB
  lda #RS         
  sta PORTA
  lda #(RS | E)   
  sta PORTA
  lda #RS         
  sta PORTA

loop:
  jmp loop

  .org $fffc
  .word reset
  .word $0000
