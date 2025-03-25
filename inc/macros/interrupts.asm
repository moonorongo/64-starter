// Store registers A, X and Y on the stack
// This is useful when we are going to modify them in an interrupt routine
// 13 cycles
.macro store_status_registers() {
  pha // 3
  txa // 2
  pha // 3
  tya // 2
  pha // 3
}

// 13 cycles
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

.macro wait_cycles(cycles) {
  .var cant_nop = floor(cycles / 2)
  .var cant_nop_rest = mod(cycles, 2)

  .if(cant_nop_rest == 1) {
    inc dummy_zero_page //  5 cycles
    .for(var i=2; i<cant_nop; i++) {
      nop
    }
  } else  {
    .for(var i=0; i<cant_nop; i++) {
      nop
    }
  }
    
}