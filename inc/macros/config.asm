.macro memory_configuration() {
  lda $01
  and #%11111000 
  ora #CONFIGURED_MEMORY
  sta $01
}
