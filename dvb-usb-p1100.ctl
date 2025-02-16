i 1320-1fff ; file padding to 8192 bytes

l 0003 interrupt_vector_IE0   
l 001B interrupt_vector_TF1
l 0033 interrupt_vector_RESUME
l 0043 interrupt_autovector_USBINT 
l 0053 interrupt_autovector_FIFO

l 0ff1 ie0_isr
l 110a tf1_isr
l 12f6 resume_isr

l 0036 startup1
l 12f0 main
l 0a59 main1
l 0c59 main2

l 0046 EPCS_Offset_Lookup_Table
b 0046-004f

m 08 Sleep   ; 21h.0
m 02 Rwuen   ; 20h.2
m 06 Selfpwr ; 20h.6
m 03 GotSUD  ; 20h.3
m 09 i2c_in_use ; 21h.1

r 1e i2c_read_count ; rb3r6

s 3b i2c_read_buf_addr

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
l 0cbc i2c_write2_read
; i2c_write1_read writes to address EP0BUF01 the data in EP0BUF02, and then
; (after I2C re-START) reads from address EP0BUF01 (number of bytes to read in rb3r6)
l 0d0b i2c_write1_read
l 0e81 i2c_write ; write number of bytes starting from 0xe740, length in EP0BUF00
l 1198 i2c_write_with_start_condition_EP0BUF01_and_EP0BUF02 ; EP0BUF01 is I2C address
l 11ad i2c_write_from_dptr
l 11ae i2c_write_register_a
l 11b2 i2c_wait_done

l 0b6e control_port_a

l 0651 TD_Init
c 0651-0736

l 0900 interrupt_autovectors
c 0900-09ff

l 0ae8 usb_descriptor_data
b 0ae8-0b6b

l 0ee4 EZUSB_Discon
l 0d54 EZUSB_Delay
l 1143 EZUSB_Delay1ms
l 0f6d EZUSB_Resume
l 112f EZUSB_SUSP
c 112f-1142
; no EZUSB I2C functions

l 11fc ISR_Sudav
l 12d2 ISR_Sof
l 12bc ISR_Sutok
l 128c ISR_Susp
l 1154 ISR_Ures
l 1176 ISR_Highspeed
l 001a ISR_Ep0ack
l 0032 ISR_Stub
l 0042 ISR_Ep0in
l 0052 ISR_Ep0out
l 1300 ISR_Ep1in
l 1301 ISR_Ep1out
l 1302 ISR_Ep2inout
l 1303 ISR_Ep4inout
l 1304 ISR_Ep6inout
l 1305 ISR_Ep8inout
l 1306 ISR_Ibn
;l 0032 ISR_Stub
l 1307 ISR_Ep0pingnak
l 1308 ISR_Ep1pingnak
l 1309 ISR_Ep2inoutPING
l 130a ISR_Ep4inoutPING
l 130b ISR_Ep6inoutPING
l 130c ISR_Ep8inoutPING
l 130d ISR_Errorlimit
;l 0032 ISR_Stub
;l 0032 ISR_Stub
;l 0032 ISR_Stub
l 130e ISR_Ep2inoutISOERR
l 130f ISR_Ep4inoutISOERR
l 1310 ISR_Ep6inoutISOERR
l 1311 ISR_Ep8inoutISOERR
l 1312 ISR_Ep2pflag
l 1313 ISR_Ep4pflag
l 1314 ISR_Ep6pflag
l 1315 ISR_Ep8pflag
l 1316 ISR_Ep2eflag
l 1317 ISR_Ep4eflag
l 1318 ISR_Ep6eflag
l 1319 ISR_Ep8eflag
l 131a ISR_Ep2fflag
l 131b ISR_Ep4fflag
l 131c ISR_Ep6fflag
l 131d ISR_Ep8fflag
l 131e ISR_GpifComplete
l 131f ISR_GpifWaveform
