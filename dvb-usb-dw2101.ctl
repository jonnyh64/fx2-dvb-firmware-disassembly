i 11ee-1fff ; file padding to 8192 bytes

l 0033 interrupt_vector_RESUME
l 0043 interrupt_autovector_USBINT
l 004B interrupt_vector_I2CINT
l 0053 interrupt_autovector_FIFO

l 004e resume_isr
l 0740 i2c_isr

l 0ba9 startup1
l 0bf0 pre_main
b 0bef
l 11c2 main
l 0a68 main1
l 0836 main2

m 04 Sleep   ; 20h.4
m 00 Rwuen   ; 20h.0
m 02 Selfpwr ; 20h.2
m 01 GotSUD  ; 20h.1

r 19 AlternateSetting ; rb3r1
r 1a buffer_in_use    ; rb3r2
r 1e Configuration    ; rb3r6

l 0056 DR_VendorCmnd
l 005d DR_VendorCmnd_jmptbl
a 005d-005e
b 005f
a 0060-0061
b 0062
a 0063-0064
b 0065
a 0066-0067
b 0068
a 0069-006a
b 006b
a 006c-006d
b 006e
a 006f-0070
b 0071
a 0072-0073
b 0074
a 0075-0076
b 0077
a 0078-0079
b 007a
a 007b-007c
b 007d
a 007e-007f
b 0080
w 0081
a 0083
l 031b vendorcmd_b2
l 0396 vendorcmd_b2_ep0buf0_2a ; i2c_write address=0x68 numbytes=2 data=ep0buf[1..2] (ep0buf[1..2] is copied to 0x0009 before i2c write)
l 03b3 vendorcmd_b2_ep0buf0_2c ; i2c_write address=0x60 numbytes=4 data=ep0buf[3..6] (ep0buf[2..6] copied to 0x0000 before i2c write)
l 03fc vendorcmd_b2_ep0buf0_2e ; i2c_read  address=0x60 numbytes=1 to memory address 0x0005 (via 0x0009)
l 0411 vendorcmd_b2_ep0buf0_30 ; control_gpio_pa6 (set if ep0buf[1] == 0 else clear)
l 037b vendorcmd_b2_ep0buf0_32 ; i2c_write address=ep0buf[1] numbytes=2 data=epbuf[2..3]
l 0427 vendorcmd_b3 ; if 20h.5 bit is set, get 3 bytes: b0=0x2f, b1=undefined, b2=memory address 0x0005 (if 20h.5 is not set, get byte 0x00)
l 02fc vendorcmd_b5 ; i2c_write address=0x68 numbytes=1 data=SETUPDAT[2] + i2c_read address=0x68 numbytes=1 data=EP0BUF[0]
l 02c4 vendorcmd_b6 ; i2c_write address=SETUPDAT[2] numbytes=SETUPDAT[3] data=SETUPDAT[4] + i2c_read address=SETUPDAT[2] numbytes=1 data=EP0BUF[2]
l 01c8 vendorcmd_b7 ; control_port_d
l 0175 vendorcmd_b8 ; get byte from buffer at 0xe756 (=EP0BUF[0x16], but seems to be used as IR reception buffer)
l 0154 vendorcmd_b9 ; get 2 bytes: b0=USBCS, b1=1 if USBCS.7 (=USB high speed mode) is NOT set else 2
l 010b vendorcmd_ba
l 00f4 vendorcmd_bb
l 00d2 vendorcmd_bc ; control_port_d
l 00ba vendorcmd_bd
l 0085 vendorcmd_be ; i2c_write address=0x7f
l 046a vendorcmd_out

l 0498 SetupCommand
l 0549 SetupCommand_case_SC_GET_STATUS        ; 0x00
l 059d SetupCommand_case_SC_CLEAR_FEATURE     ; 0x01
l 05f7 SetupCommand_case_SC_SET_FEATURE       ; 0x03
l 0543 SetupCommand_case_SC_GET_CONFIGURATION ; 0x08
l 053d SetupCommand_case_SC_SET_CONFIGURATION ; 0x09
l 0531 SetupCommand_case_SC_GET_INTERFACE     ; 0x0a
l 0537 SetupCommand_case_SC_SET_INTERFACE     ; 0x0b
l 04c8 SetupCommand_case_SC_GET_DESCRIPTOR    ; 0x06
l 0634 SetupCommand_case_default

l 1083 i2c_write_and_read_addr68
l 1158 i2c_write_addr68
l 116b i2c_read_addr60
l 117c i2c_write_addr60

;l 0f78 HighSpeedCapable ;WRONG!

l 08fd DR_GetDescriptor ; WRONG??
l 0f15 DR_SetConfiguration
c 0f15-0f4b
c 0ff8-100b
l 1197 DR_GetConfiguration
l 11b2 DR_SetInterface
l 11a0 DR_GetInterface
l 11c8 DR_GetStatus
l 11ca DR_ClearFeature
l 11cc DR_SetFeature

;l 0e7d epcs

l 063f TD_Init
c 063f-073d

l 0cc0 usb_descriptor_data
b 0cc0-0d45

l 0df8 get_setupdat2

l 0003 EZUSB_Discon ; really??
l 0ecf EZUSB_Delay
l 0eed EZUSB_Delay1ms
l 0f4c EZUSB_Resume
l 0ff8 EZUSB_SUSP
l 0fcf EZUSB_WriteI2C_ ; i2caddr in r7, length in r5, data in r2:r3 (high:low)
l 0fa4 EZUSB_ReadI2C_  ; i2caddr in r7, length in r5, data in r2:r3 (high:low)
l 1106 EZUSB_WriteI2C  ; i2caddr in r7, length in r5, data in r2:r3 (high:low)
l 10ef EZUSB_ReadI2C   ; i2caddr in r7, length in r5, data in r2:r3 (high:low)

l 0deb get_buffered_ir_byte

l 0e00 clr_USBINT_and_set_dptr_to_e65d

l 0900 interrupt_autovectors
c 0900-09ff

l 11a9 control_gpio_pa6

l 10a4 ISR_Sudav
l 1145 ISR_Sof
l 1132 ISR_Sutok
l 111d ISR_Susp
l 101d ISR_Ures
l 103f ISR_Highspeed
l 0032 ISR_Ep0ack
l 0052 ISR_Stub
l 08ff ISR_Ep0in
l 11ce ISR_Ep0out
l 10c0 ISR_Ep1in
l 11cf ISR_Ep1out
l 11d0 ISR_Ep2inout
l 11d1 ISR_Ep4inout
l 11d2 ISR_Ep6inout
l 11d3 ISR_Ep8inout
l 11d4 ISR_Ibn
;l 0052 ISR_Stub
l 11d5 ISR_Ep0pingnak
l 11d6 ISR_Ep1pingnak
l 11d7 ISR_Ep2inoutPING
l 11d8 ISR_Ep4inoutPING
l 11d9 ISR_Ep6inoutPING
l 11da ISR_Ep8inoutPING
l 11db ISR_Errorlimit
;l 0052 ISR_Stub
;l 0052 ISR_Stub
;l 0052 ISR_Stub
l 11dc ISR_Ep2inoutISOERR
l 11dd ISR_Ep4inoutISOERR
l 11de ISR_Ep6inoutISOERR
l 11df ISR_Ep8inoutISOERR
l 11e0 ISR_Ep2pflag
l 11e1 ISR_Ep4pflag
l 11e2 ISR_Ep6pflag
l 11e3 ISR_Ep8pflag
l 11e4 ISR_Ep2eflag
l 11e5 ISR_Ep4eflag
l 11e6 ISR_Ep6eflag
l 11e7 ISR_Ep8eflag
l 11e8 ISR_Ep2fflag
l 11e9 ISR_Ep4fflag
l 11ea ISR_Ep6fflag
l 11eb ISR_Ep8fflag
l 11ec ISR_GpifComplete
l 11ed ISR_GpifWaveform
