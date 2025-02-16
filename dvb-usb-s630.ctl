i 1229-1fff ; file padding to 8192 bytes

l 0003 interrupt_vector_IE0   
l 001B interrupt_vector_TF1
l 0033 interrupt_vector_RESUME
l 0043 interrupt_autovector_USBINT 
l 0053 interrupt_autovector_FIFO

l 0f0c ie0_isr
l 0fa5 tf1_isr
l 11f9 resume_isr

l 0046 startup1
l 11f3 main
l 0a59 main1
l 0bda main2

m 08 Sleep   ; 21h.0
m 02 Rwuen   ; 20h.2
m 06 Selfpwr ; 20h.6
m 03 GotSUD  ; 20h.3

l 0056 DR_VendorCmnd
l 005d DR_VendorCmnd_jmptbl
a 005d
b 005f
a 0060
b 0062
a 0063
b 0065
a 0066
b 0068
a 0069
b 006b
a 006c
b 006e
a 006f
b 0071
a 0072
b 0074
a 0075
b 0077
a 0078
b 007a
w 007b
a 007d
l 01b9 vendorcmd_80 ; i2c write
l 023d vendorcmd_81 ; get the i2c_in_use flag (probably used for debugging)
l 0251 vendorcmd_8a ; control port a
l 0188 vendorcmd_90 ; i2c to address in EP0BUF01: write 1 byte (EP0BUF02), then read (number of bytes in EP0BUF00)
l 01ff vendorcmd_91 ; get the read bytes from vendorcmd_90/vendorcmd_92
l 0157 vendorcmd_92 ; i2c to address in EP0BUF01: write 2 bytes (EP0BUF02/EP0BUF03), then read (number of bytes in EP0BUF00)
l 007f vendorcmd_af
l 008e vendorcmd_af_SETUPDAT0_c0 ; echo back 3 bytes
l 009c vendorcmd_af_SETUPDAT0_40 ; get 10 bytes
l 00d0 vendorcmd_b5
l 0279 vendorcmd_b7 ; get 20h.5
l 028e vendorcmd_b8
l 02bb vendorcmd_out

l 02bd SetupCommand

; i2c_write2_read writes to address EP0BUF01 the data in EP0BUF02 and EP0BUF03, and then
; (after I2C re-START) reads from address EP0BUF01 (number of bytes to read in rb3r6)
l 0c9e i2c_write2_read
; i2c_write1_read writes to address EP0BUF01 the data in EP0BUF02, and then
; (after I2C re-START) reads from address EP0BUF01 (number of bytes to read in rb3r6)
l 0ced i2c_write1_read
;l 0e81 i2c_write ; write number of bytes starting from 0xe740, length in EP0BUF00
l 1033 i2c_write_with_start_condition_EP0BUF01_and_EP0BUF02 ; EP0BUF01 is I2C address
l 1048 i2c_write_from_dptr
l 1049 i2c_write_register_a
l 104d i2c_wait_done

l 0651 TD_Init
c 0651-0736

l 0900 interrupt_autovectors
c 0900-09ff

l 0ae8 usb_descriptor_data
b 0ae8-0b6b

l 0c3d handle_EP0 ; or some EP0 command handling?!
c 0c3d-0c9d

l 0e5c EZUSB_Discon
l 0d36 EZUSB_Delay
l 0fde EZUSB_Delay1ms
l 0e8b EZUSB_Resume
l 0fca EZUSB_SUSP
c 0fca-0fdd
; no EZUSB I2C functions

l 1097 ISR_Sudav
l 116f ISR_Sof
l 1159 ISR_Sutok
l 1141 ISR_Susp
l 0fef ISR_Ures
l 1011 ISR_Highspeed
l 0032 ISR_Ep0ack
l 0052 ISR_Stub
l 1207 ISR_Ep0in
l 1208 ISR_Ep0out
l 1209 ISR_Ep1in
l 120a ISR_Ep1out
l 120b ISR_Ep2inout
l 120c ISR_Ep4inout
l 120d ISR_Ep6inout
l 120e ISR_Ep8inout
l 120f ISR_Ibn
;l 0052 ISR_Stub
l 1210 ISR_Ep0pingnak
l 1211 ISR_Ep1pingnak
l 1212 ISR_Ep2inoutPING
l 1213 ISR_Ep4inoutPING
l 1214 ISR_Ep6inoutPING
l 1215 ISR_Ep8inoutPING
l 1216 ISR_Errorlimit
;l 0052 ISR_Stub
;l 0052 ISR_Stub
;l 0052 ISR_Stub
l 1217 ISR_Ep2inoutISOERR
l 1218 ISR_Ep4inoutISOERR
l 1219 ISR_Ep6inoutISOERR
l 121a ISR_Ep8inoutISOERR
l 121b ISR_Ep2pflag
l 121c ISR_Ep4pflag
l 121d ISR_Ep6pflag
l 121e ISR_Ep8pflag
l 121f ISR_Ep2eflag
l 1220 ISR_Ep4eflag
l 1221 ISR_Ep6eflag
l 1222 ISR_Ep8eflag
l 1223 ISR_Ep2fflag
l 1224 ISR_Ep4fflag
l 1225 ISR_Ep6fflag
l 1226 ISR_Ep8fflag
l 1227 ISR_GpifComplete
l 1228 ISR_GpifWaveform
