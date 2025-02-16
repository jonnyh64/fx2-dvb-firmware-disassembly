i 0f6e-1fff ; file padding to 8192 bytes

l 0003 interrupt_vector_IE0   
l 001B interrupt_vector_TF1
l 0033 interrupt_vector_RESUME
l 0043 interrupt_autovector_USBINT 
l 0053 interrupt_autovector_FIFO

l 0cfa ie0_isr
l 0d72 tf1_isr
l 08fc resume_isr

l 0036 startup1
l 0f36 main
l 084b main1
c 084b-08fb
l 0b61 main2

l 0046 EPCS_Offset_Lookup_Table
b 0046-004f

m 08 Sleep   ; 21h.0
m 02 Rwuen   ; 20h.2
m 06 Selfpwr ; 20h.6
m 03 GotSUD  ; 20h.3

r 1e i2c_read_count ; rb3r6

l 0056 DR_VendorCmnd
l 019e vendorcmd_80 ; i2c write
l 0222 vendorcmd_81 ; get the i2c_in_use flag (probably used for debugging)
l 0236 vendorcmd_8a ; control port a
l 016d vendorcmd_90 ; i2c to address in EP0BUF01: write 1 byte (EP0BUF02), then read (number of bytes in EP0BUF00)
l 01e4 vendorcmd_91 ; get the read bytes from vendorcmd_90
l 008d vendorcmd_af
l 009c vendorcmd_af_SETUPDAT0_c0 ; echo back 3 bytes
l 00aa vendorcmd_af_SETUPDAT0_40 ; get 8 bytes
l 00db vendorcmd_b5
l 025e vendorcmd_b8
l 028b vendorcmd_out

l 028d SetupCommand

; i2c_write1_read writes to address EP0BUF01 the data in EP0BUF02, and then
; (after I2C re-START) reads from address EP0BUF01 (number of bytes to read in rb3r6)
l 0ab4 i2c_write1_read
c 0ab4-0b0a
l 0d25 i2c_write ; write number of bytes starting from 0xe740, length in EP0BUF00
l 0eb7 i2c_write_from_e740 ; write from e740 + offset r7
l 0ec1 i2c_write_from_dptr
l 0ec2 i2c_write_register_a
l 0ec6 i2c_wait_done

l 0b0b control_port_a

l 075e TD_Init
c 075e-084a

l 0900 interrupt_autovectors
c 0900-09ff

l 09b8 usb_descriptor_data
b 09b8-0a3b

l 0c73 EZUSB_Discon
l 0bb6 EZUSB_Delay
l 0dab EZUSB_Delay1ms
l 0ca2 EZUSB_Resume
l 0d97 EZUSB_SUSP
c 0d97-0daa
; no EZUSB I2C functions

l 0e80 ISR_Sudav
l 0efa ISR_Sof
l 0ee4 ISR_Sutok
l 0e9f ISR_Susp
l 0dbc ISR_Ures
l 0dde ISR_Highspeed
l 001a ISR_Ep0ack
l 0032 ISR_Stub
l 0042 ISR_Ep0in
l 0052 ISR_Ep0out
l 0f4e ISR_Ep1in
l 0f4f ISR_Ep1out
l 0f50 ISR_Ep2inout
l 0f51 ISR_Ep4inout
l 0f52 ISR_Ep6inout
l 0f53 ISR_Ep8inout
l 0f54 ISR_Ibn
;l 0032 ISR_Stub
l 0f55 ISR_Ep0pingnak
l 0f56 ISR_Ep1pingnak
l 0f57 ISR_Ep2inoutPING
l 0f58 ISR_Ep4inoutPING
l 0f59 ISR_Ep6inoutPING
l 0f5a ISR_Ep8inoutPING
l 0f5b ISR_Errorlimit
;l 0032 ISR_Stub
;l 0032 ISR_Stub
;l 0032 ISR_Stub
l 0f5c ISR_Ep2inoutISOERR
l 0f5d ISR_Ep4inoutISOERR
l 0f5e ISR_Ep6inoutISOERR
l 0f5f ISR_Ep8inoutISOERR
l 0f60 ISR_Ep2pflag
l 0f61 ISR_Ep4pflag
l 0f62 ISR_Ep6pflag
l 0f63 ISR_Ep8pflag
l 0f64 ISR_Ep2eflag
l 0f65 ISR_Ep4eflag
l 0f66 ISR_Ep6eflag
l 0f67 ISR_Ep8eflag
l 0f68 ISR_Ep2fflag
l 0f69 ISR_Ep4fflag
l 0f6a ISR_Ep6fflag
l 0f6b ISR_Ep8fflag
l 0f6c ISR_GpifComplete
l 0f6d ISR_GpifWaveform
