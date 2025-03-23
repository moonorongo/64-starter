.macro set_raster_int_line(line) {
  .var lo_byte = <line
  .var hi_byte = >line

  // clear MSB raster
  lda #%00011011 // fix vertical position

  // set bit #7 (9bit raster position) to true 
  .if (hi_byte != 0) {
    ora #%10000000
  }

  sta SCR_CONTROL_D012

  lda #lo_byte
  sta RASTER_REGISTER_D012
}


.macro enable_vic_irq() {
  /*
    d01a Interrupt control register. Bits:
    
    Bit #0: 1 = Raster interrupt enabled.
    Bit #1: 1 = Sprite-background collision interrupt enabled.
    Bit #2: 1 = Sprite-sprite collision interrupt enabled.
    Bit #3: 1 = Light pen interrupt enabled.    
  */

  lda $d01a
  ora #$1
  sta $d01a
}

