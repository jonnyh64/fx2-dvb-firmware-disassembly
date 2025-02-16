i 1328-1fff ; file padding to 8192 bytes

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

l 0cb8 ie1_isr
l 1304 resume_isr
l 08b9 i2c_isr

l 0d60 startup1
l 0da7 pre_main
l 12f9 main
l 0cbc main1
l 0bf3 main2

m 03 Sleep   ; 20h.3
m 00 Rwuen   ; 20h.0
m 02 Selfpwr ; 20h.2
m 01 GotSUD  ; 20h.1

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
w 04b9
a 04bb
l 068a vendorcmd_b2
l 06bb vendorcmd_b2_ep0buf0_2a ; i2c write to address 0x68
l 06ca vendorcmd_b2_ep0buf0_2c ; copy EP0BUF02/03/04/05/06 to memory address 0x0000, then 4 byte i2c write to address EP0BUF02
l 0708 vendorcmd_b2_ep0buf0_30 ; set/clear 20h.4
l 06a1 vendorcmd_b2_ep0buf0_32 ; i2c write to address EP0BUF01
l 061d vendorcmd_b5 ; i2c write and read to address 0x68
l 05fc vendorcmd_b6 ; i2c write and read to address SETUPDAT2
l 05ef vendorcmd_b8
l 05d6 vendorcmd_b9
l 0557 vendorcmd_ba
l 0563 vendorcmd_bb ; extended i2c write to address EP0BUF00
l 0583 vendorcmd_bc ; extended i2c write to address EP0BUF1A
l 05a3 vendorcmd_bd
l 04bd vendorcmd_c0 ; control port A
l 0505 vendorcmd_c1 ; control port A
l 0646 vendorcmd_c2 ; i2c write to address EP0BUF00
l 0669 vendorcmd_c3 ; i2c read from address SETUPDAT2
l 054d vendorcmd_c5 ; set I2CS register
l 0703 vendorcmd_b2_ep0buf0_2a_part2
l 071b vendorcmd_out

l 071d SetupCommand

; no EZUSB_Discon
l 0ee9 EZUSB_Delay
l 12b3 EZUSB_Delay1ms
l 1114 EZUSB_Resume
; no EZUSB_SUSP
l 0fb7 EZUSB_WriteI2C_extended_ ; addr in r7, length in r5, dat in r2:r3 (high:low)
l 0ffb EZUSB_WriteI2C_          ; addr in r7, length in r5, dat in r2:r3 (high:low)
l 10b1 EZUSB_ReadI2C_           ; addr in r7, length in r5, dat in r2:r3 (high:low)
l 11d8 EZUSB_WriteI2C_extended  ; addr in r7, length in r5, dat in r2:r3 (high:low)
l 1211 EZUSB_ReadI2C            ; addr in r7, length in r5, dat in r2:r3 (high:low)
l 1228 EZUSB_WriteI2C           ; addr in r7, length in r5, dat in r2:r3 (high:low)

l 0e84 clr_USBINT_and_set_dptr_to_e65d

l 0400 usb_descriptor_data
b 0400-0485

l 0a0d TD_Init
c 0a0d-0bf2

l 0c00 interrupt_autovectors
c 0c00-0cff

l 11f5 ISR_Sudav
l 127a ISR_Sof
l 1267 ISR_Sutok
l 123f ISR_Susp
l 1194 ISR_Ures
l 11b6 ISR_Highspeed
l 128d ISR_Ep0ack
l 0bfd ISR_Stub
l 0bfe ISR_Ep0in
l 0bff ISR_Ep0out
l 1308 ISR_Ep1in
l 1309 ISR_Ep1out
l 130a ISR_Ep2inout
l 130b ISR_Ep4inout
l 130c ISR_Ep6inout
l 130d ISR_Ep8inout
l 130e ISR_Ibn
;l 0bfd ISR_Stub
l 130f ISR_Ep0pingnak
l 1310 ISR_Ep1pingnak
l 1311 ISR_Ep2inoutPING
l 1312 ISR_Ep4inoutPING
l 1313 ISR_Ep6inoutPING
l 1314 ISR_Ep8inoutPING
l 1315 ISR_Errorlimit
;l 0bfd ISR_Stub
;l 0bfd ISR_Stub
;l 0bfd ISR_Stub
l 1316 ISR_Ep2inoutISOERR
l 1317 ISR_Ep4inoutISOERR
l 1318 ISR_Ep6inoutISOERR
l 1319 ISR_Ep8inoutISOERR
l 131a ISR_Ep2pflag
l 131b ISR_Ep4pflag
l 131c ISR_Ep6pflag
l 131d ISR_Ep8pflag
l 131e ISR_Ep2eflag
l 131f ISR_Ep4eflag
l 1320 ISR_Ep6eflag
l 1321 ISR_Ep8eflag
l 1322 ISR_Ep2fflag
l 1323 ISR_Ep4fflag
l 1324 ISR_Ep6fflag
l 1325 ISR_Ep8fflag
l 1326 ISR_GpifComplete
l 1327 ISR_GpifWaveform
