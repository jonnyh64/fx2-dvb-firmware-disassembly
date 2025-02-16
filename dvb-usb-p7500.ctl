i 1320-1fff ; file padding to 8192 bytes

l 0003 interrupt_vector_IE0   
l 001B interrupt_vector_TF1
l 0033 interrupt_vector_RESUME
l 0043 interrupt_autovector_USBINT 
l 0053 interrupt_autovector_FIFO

b 0006-001a
b 001e-0032
b 0036-0042
b 0046-0052
b 0056-007f

l 0b8f ie0_isr
l 0d29 tf1_isr
l 0e1c resumr_isr

l 0dd0 startup1
l 061d main

m 03 Sleep   ; 20h.3
m 00 Rwuen   ; 20h.0
m 02 Selfpwr ; 20h.2
m 01 GotSUD  ; 20h.1

;s 04 i2c_read_buf_addr

l 0080 SetupCommand

l 0333 DR_VendorCmnd
l 038f vendorcmd_80 ; i2c write
l 03ee vendorcmd_8a ; control port a
; Compared to dvb-usb-p1100.ctl, functions of vendorcmd_90 and vendorcmd_92 are swapped?!
l 0373 vendorcmd_90 ; i2c to address in EP0BUF01: write 2 bytes (EP0BUF02/EP0BUF03), then read (number of bytes in EP0BUF00)
l 03a5 vendorcmd_91 ; get the read bytes from vendorcmd_90/vendorcmd_92
l 0357 vendorcmd_92 ; i2c to address in EP0BUF01: write 1 byte (EP0BUF02), then read (number of bytes in EP0BUF00)
l 045f vendorcmd_b8
l 04a9 vendorcmd_out

;; i2c_write2_read writes to address EP0BUF01 the data in EP0BUF02 and EP0BUF03, and then
;; (after I2C re-START) reads from address EP0BUF01 (number of bytes to read in rb3r3)
l 0a44 i2c_write2_read
c 0a44-0ace
;; i2c_write1_read writes to address EP0BUF01 the data in EP0BUF02, and then
;; (after I2C re-START) reads from address EP0BUF01 (number of bytes to read in rb3r3)
l 0acf i2c_write1_read
c 0acf-0b48
l 0bd3 i2c_write ; write number of bytes starting from 0xe740, length in EP0BUF00
l 0e14 i2c_wait_done

l 0787 TD_Init
c 0787-0853

l 0900 interrupt_autovectors
c 0900-09ff

l 09b8 usb_descriptor_data
b 09b8-0a41

l 0c10 EZUSB_Discon
l 0b49 EZUSB_Delay
l 0cd4 EZUSB_Delay1ms
l 0c3f EZUSB_Resume
l 0cc0 EZUSB_SUSP
c 0cc0-0cd3
; no EZUSB I2C functions

l 0df1 i2c_set_400khz
c 0df1-0dfa

l 0d49 ISR_Sudav
l 0d96 ISR_Sof
l 0d80 ISR_Sutok
l 0d68 ISR_Susp
l 0ce5 ISR_Ures
l 0d07 ISR_Highspeed
l 0e2a ISR_Ep0ack
l 0e2b ISR_Stub
l 0e2c ISR_Ep0in
l 0e2d ISR_Ep0out
l 0e2e ISR_Ep1in
l 0e2f ISR_Ep1out
l 0e30 ISR_Ep2inout
l 0e31 ISR_Ep4inout
l 0e32 ISR_Ep6inout
l 0e33 ISR_Ep8inout
l 0e34 ISR_Ibn
;l 0e2b ISR_Stub
l 0e35 ISR_Ep0pingnak
l 0e36 ISR_Ep1pingnak
l 0e37 ISR_Ep2inoutPING
l 0e38 ISR_Ep4inoutPING
l 0e39 ISR_Ep6inoutPING
l 0e3a ISR_Ep8inoutPING
l 0e3b ISR_Errorlimit
;l 0e2b ISR_Stub
;l 0e2b ISR_Stub
;l 0e2b ISR_Stub
l 0e3c ISR_Ep2inoutISOERR
l 0e3d ISR_Ep4inoutISOERR
l 0e3e ISR_Ep6inoutISOERR
l 0e3f ISR_Ep8inoutISOERR
l 0e40 ISR_Ep2pflag
l 0e41 ISR_Ep4pflag
l 0e42 ISR_Ep6pflag
l 0e43 ISR_Ep8pflag
l 0e44 ISR_Ep2eflag
l 0e45 ISR_Ep4eflag
l 0e46 ISR_Ep6eflag
l 0e47 ISR_Ep8eflag
l 0e48 ISR_Ep2fflag
l 0e49 ISR_Ep4fflag
l 0e4a ISR_Ep6fflag
l 0e4b ISR_Ep8fflag
l 0e4c ISR_GpifComplete
l 0e4d ISR_GpifWaveform
