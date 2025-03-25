// BUILD AND RUN = F6
// C64 DEBUGGEER = Shift F6

#import "inc/constants.asm" 
#import "inc/pointers.asm" 
#import "inc/configuration.asm" 

.const SCREEN_INTERRUPT_LINE = 52

BasicUpstart2(main)

main:
  disable_cia_interrupts()  
  memory_configuration()

  sei

  set_raster_int_line(SCREEN_INTERRUPT_LINE)
  
  set_irq_vector(intcode)

  enable_vic_irq()

  cli


main_loop:
  jmp main_loop // test
  



// Interrupt code for SCREEN_INTERRUPT_LINE
intcode:
  store_status_registers()  // 13 cycles

  inc BASE_VIC + $21    // 6

// SET COLOR
  // ldx #$0               // 2
  // stx BASE_VIC + $21    // 3
  // stx BASE_VIC + $20    // 3


/*
raster_loop_2:
  ldx BASE_VIC + $12 
  cpx #SCREEN_INTERRUPT_LINE
  beq raster_loop_2
*/
  // 65 cycles per line
  wait_cycles(59) 

// normal colors
  dec BASE_VIC + $21    // 6
  // dec BASE_VIC + $20    // 6



  inc $d019           // 6
  restore_status_registers()  // 13 cycles
              
  rti

// includes
#import "inc/macros/config.asm" 
#import "inc/macros/vic.asm" 
#import "inc/macros/interrupts.asm" 
