
.macro store_status_registers() {
  pha
  txa
  pha
  tya
  pha
}

.macro restore_status_registers() {
  pla
  tay
  pla
  tax
  pla
}

.macro disable_cia_interrupts() {
/* 

    $dc0d, $dd0d Interrupt control and status register. 
    $7f 01111111

    Bit #7: Fill bit; 
    bits #0-#6, that are set to 1, get their values from this bit; 
    bits #0-#6, that are set to 0, are left unchanged.    
    
    Deshabilita interrupciones timer

*/    

  lda #$7f
  sta $dc0d
  sta $dd0d

// by reading this two registers we negate any pending CIA irqs.
// if we don't do this, a pending CIA irq might occur after we finish setting up our irq.
// we don't want that to happen.
  lda $dc0d
  lda $dd0d
} 

.macro set_irq_vector(vector) {
  lda #<vector
  sta $fffe        
  lda #>vector
  sta $ffff
}