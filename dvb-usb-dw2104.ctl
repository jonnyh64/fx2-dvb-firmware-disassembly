i 133b-1fff ; file padding to 8192 bytes

; padded with 0xaa
b 0003-0012
b 0016-0032
b 0036-0042
b 0046-004a
b 004e-0052
b 0056-03ff

l 0013 interrupt_vector_IE1
l 0033 interrupt_vector_RESUME
l 0043 interrupt_autovector_USBINT 
l 004B interrupt_vector_I2CINT
l 0053 interrupt_autovector_FIFO

l 0db8 ie1_isr
l 1314 resume_isr
l 08cc i2c_isr

l 0dbc startup1
l 0e03 pre_main
l 0cfa main
l 0c06 main1
l 0cf0 main2

m 03 Sleep   ; 20h.3
m 00 Rwuen   ; 20h.0
m 02 Selfpwr ; 20h.2
m 01 GotSUD  ; 20h.1

r 2b I2CPCKT_length
r 2c I2CPCKT_pad ; REALLY???
r 2d I2CPCKT_addrh
r 2e I2CPCKT_addrl
r 2f I2CPCKT_count
r 30 I2CPCKT_status

l 0488 DR_VendorCmnd
l 048f DR_VendorCmnd_jmptbl
a 048f
b 0491
a 0492
b 0494
a 0495
b 0497
a 0498
b 049a
a 049b
b 049d
a 049e
b 04a0
a 04a1
b 04a3
a 04a4
b 04a6
a 04a7
b 04a9
a 04aa
b 04ac
a 04ad
b 04af
a 04b0
b 04b2
a 04b3
b 04b5
a 04b6
b 04b8
a 04b9
a 04bb
l 068a vendorcmd_b2
l 06be vendorcmd_b2_ep0buf0_2a ; i2c write to address 0x68: 2 bytes EP0BUF01 + EP0BUF02
l 06cd vendorcmd_b2_ep0buf0_2c ; copy EP0BUF02/03/04/05/06 to memory address 0x0000, then 4 byte i2c write to address EP0BUF02
l 070b vendorcmd_b2_ep0buf0_30 ; set port a.6
l 06a4 vendorcmd_b2_ep0buf0_32 ; i2c write to adress EP0BUF01: two bytes from EP0BUF02/EP0BUF03
l 061d vendorcmd_b5 ; i2c write and read to adress 0x68
l 05fc vendorcmd_b6 ; i2c write and read to SETUPDAT2
l 05ef vendorcmd_b8_rc_query
l 05d6 vendorcmd_b9_check_USB_high_speed
l 0557 vendorcmd_ba_echo_data
l 0563 vendorcmd_bb
l 0583 vendorcmd_bc
l 05a3 vendorcmd_bd
l 04bd vendorcmd_c0_port_a_read ; pin number to read in SETUPDAT4 (0=>PA0, 1=>PA2, 2=>PA3)
l 04d8 vendorcmd_c0_SETUPDAT4_01
l 04eb vendorcmd_c0_SETUPDAT4_02
l 04fd vendorcmd_c0_afterswitch
l 04cb vendorcmd_c0_SETUPDAT4_00
l 0505 vendorcmd_c1_port_a_write ; pin number to write in SETUPDAT4 (0=>PA0, 1=>PA2, 2=>PA3)
l 0522 vendorcmd_c1_SETUPDAT4_01
l 0535 vendorcmd_c1_SETUPDAT4_02
l 0554 vendorcmd_c1_afterswitch
l 0513 vendorcmd_c1_SETUPDAT4_00
l 0646 vendorcmd_c2_i2c_write ; i2c write to address EP0BUF00
l 0669 vendorcmd_c3_i2c_read ; i2c read from address SETUPDAT2, length in SETUPDAT6
l 054d vendorcmd_c5_i2c_set_I2CS_STOP_bit

l 0730 SetupCommand

l 0400 usb_descriptor_data
b 0400-0485

l 0a20 TD_Init
c 0a20-0c05

l 0d00 interrupt_autovectors
c 0d00-0dff

l 0fb7 i2c_write
c 0fb7-103a

l 0ee7 set_EP0BUF2_get_SETUPDAT2_bit0
l 0ef2 setbits_EP0BUF2_set_p0

; no EZUSB_Discon
l 0caa EZUSB_Delay
l 12c9 EZUSB_Delay1ms
l 112a EZUSB_Resume
; no EZUSB_SUSP
l 1011 EZUSB_WriteI2C_
l 10c7 EZUSB_ReadI2C_
l 123e EZUSB_WriteI2C
l 1227 EZUSB_ReadI2C

l 0ee0 clr_USBINT_and_set_dptr_to_e65d

l 120b ISR_Sudav
l 1290 ISR_Sof
l 127d ISR_Sutok
l 1255 ISR_Susp
l 11aa ISR_Ures
l 11cc ISR_Highspeed
l 12a3 ISR_Ep0ack
l 1318 ISR_Stub
l 1319 ISR_Ep0in
l 131a ISR_Ep0out
l 131b ISR_Ep1in
l 131c ISR_Ep1out
l 131d ISR_Ep2inout
l 131e ISR_Ep4inout
l 131f ISR_Ep6inout
l 1320 ISR_Ep8inout
l 1321 ISR_Ibn
;l 1318 ISR_Stub
l 1322 ISR_Ep0pingnak
l 1323 ISR_Ep1pingnak
l 1324 ISR_Ep2inoutPING
l 1325 ISR_Ep4inoutPING
l 1326 ISR_Ep6inoutPING
l 1327 ISR_Ep8inoutPING
l 1328 ISR_Errorlimit
;l 1318 ISR_Stub
;l 1318 ISR_Stub
;l 1318 ISR_Stub
l 1329 ISR_Ep2inoutISOERR
l 132a ISR_Ep4inoutISOERR
l 132b ISR_Ep6inoutISOERR
l 132c ISR_Ep8inoutISOERR
l 132d ISR_Ep2pflag
l 132e ISR_Ep4pflag
l 132f ISR_Ep6pflag
l 1330 ISR_Ep8pflag
l 1331 ISR_Ep2eflag
l 1332 ISR_Ep4eflag
l 1333 ISR_Ep6eflag
l 1334 ISR_Ep8eflag
l 1335 ISR_Ep2fflag
l 1336 ISR_Ep4fflag
l 1337 ISR_Ep6fflag
l 1338 ISR_Ep8fflag
l 1339 ISR_GpifComplete
l 133a ISR_GpifWaveform
