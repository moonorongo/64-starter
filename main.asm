// BUILD AND RUN = F6
// C64 DEBUGGEER = Shift F6

#import "inc/constants.asm" 
#import "inc/pointers.asm" 

BasicUpstart2(main)

main:
  disable_cia_interrupts()  
  disable_basic_and_kernal()

  sei

  set_raster_int_line(52)
  
  set_irq_vector(intcode)

  enable_vic_irq()

  cli


main_loop:
  jmp main_loop // test
  



// Interrupt code for SCREEN_INTERRUPT_LINE
intcode:
  store_status_registers()
  inc $d019           // acusamos recibo

// SET COLOR
  ldx #$0
  stx BASE_VIC + $21
  stx BASE_VIC + $20


// normal colors
  ldx #6
  stx BASE_VIC + $21
  ldx #14
  stx BASE_VIC + $20


  restore_status_registers()
               
  rti

// includes
#import "inc/macros/config.asm" 
#import "inc/macros/vic.asm" 
#import "inc/macros/interrupts.asm" 
