.macro disable_basic_and_kernal() {
/*
  Processor port. Bits:
 
  Bits #0-#2: Configuration for memory areas 
    $A000-$BFFF, 
    $D000-$DFFF and 
    $E000-$FFFF. 
  Values:
  %x00: RAM visible in all three areas.
  %x01: RAM visible at $A000-$BFFF and $E000-$FFFF.
  %x10: RAM visible at $A000-$BFFF; KERNAL ROM visible at $E000-$FFFF.
  %x11: BASIC ROM visible at $A000-$BFFF; KERNAL ROM visible at $E000-$FFFF.
 
  %0xx: Character ROM visible at $D000-$DFFF. (Except for the value %000, see above.)
  %1xx: I/O area visible at $D000-$DFFF. (Except for the value %100, see above.)
*/

  lda $01
  and #%11111100 // tambien deshabilitamos el kernal
  ora #%00000001 // RAM visible at $A000-$BFFF and $E000-$FFFF.
  sta $01

  // lda #$34
  // sta $01 
}
