i 1b93-1fff ; file padding to 8192 bytes

l 000B interrupt_vector_TF0
l 0013 interrupt_vector_IE1
l 001B interrupt_vector_TF1
l 002B interrupt_vector_TF2_or_EXF2
l 0033 interrupt_vector_RESUME
l 0043 interrupt_autovector_USBINT
l 004B interrupt_vector_I2CINT
l 0053 interrupt_autovector_FIFO

l 1aed tf0_isr
l 195e ie1_isr
c 195e-1986
l 1b92 tf1_isr
c 1b92-1b92
l 1807 tf2_or_exf2_isr
l 1b5b resume_isr
l 10ed i2c_isr

c 0000-0002
b 0003-000a
c 000b-000d
b 000e-0012
c 0013-0015
b 0016-001a
c 001b-001d
b 001e-002a
c 002b-002d
b 002e-0032
c 0033-0035
b 0036-0042
c 0043-0045
b 0046-004a
c 004b-004d
b 004e-0052
c 0053-0055
b 0056-007f

l 14b8 startup1
c 14b8-14c4
l 14ff pre_main
c 14ff-1542
l 0c50 main
c 0c50-0d8a

m 0e Sleep   ; 21h.6
m 08 Rwuen   ; 21h.0
m 0b Selfpwr ; 21h.3
m 09 GotSUD  ; 21h.1

;r 19 AlternateSetting ; rb3r1
;r 1e Configuration    ; rb3r6

l 0080 handle_ep1command
c 0080-048d

l 009b ep1command_jmptbl
a 009b
b 009d
a 009e
b 00a0
a 00a1
b 00a3
a 00a4
b 00a6
a 00a7
b 00a9
a 00aa
b 00ac
a 00ad
b 00af
a 00b0
b 00b2
a 00b3
b 00b5
a 00b6
b 00b8
a 00b9
b 00bb
a 00bc
b 00be
a 00bf
b 00c1
a 00c2
b 00c4
a 00c5
b 00c7
a 00c8
b 00ca
a 00cb
b 00cd
a 00ce
b 00d0
a 00d1
b 00d3
a 00d4
a 00d6
l 0181 ep1command_08_i2c_write
l 021d ep1command_09_i2c_read
l 00d8 ep1command_0b
l 01b4 ep1command_0c
l 0293 ep1command_0d
l 02c3 ep1command_0e
l 02e0 ep1command_10_rc_query
l 0109 ep1command_36_stream_enable
l 013a ep1command_37_stream_disable
l 0345 ep1command_46
l 014d ep1command_50
l 015d ep1command_51
l 02f6 ep1command_60
l 031e ep1command_61
l 00fa ep1command_dc
l 0103 ep1command_de
l 016d ep1command_e8
l 0179 ep1command_e9
l 00eb ep1command_eb

l 048e SetupCommand

l 1b91 empty_function
c 1b91-1b91

l 1b0a reset_port_d
c 1b0a-1b16

l 1a71 setup_timer_and_interrupts
c 1a71-1a88

l 1a28 setup_usb_descriptor_registers
c 1a28-1a40

l 11f9 setup_fifo_and_i2c
c 11f9-12d9

; patches VID/PID?
l 0d8b relocate_and_patch_usb_descriptors
c 0d8b-0dbf

c 12da-13ff

l 1400 interrupt_autovectors
c 1400-14ff  

l 1a41 ISR_Sudav
l 1935 ISR_Sof
l 1a9f ISR_Sutok
l 1a59 ISR_Susp
l 15cf ISR_Ures
l 1653 ISR_Highspeed
l 1b6d ISR_Ep0ack
l 1b6e ISR_Stub
l 1b6f ISR_Ep0in
l 1b70 ISR_Ep0out
l 1b71 ISR_Ep1in
l 1b72 ISR_Ep1out
l 1b73 ISR_Ep2inout
l 1b74 ISR_Ep4inout
l 1b75 ISR_Ep6inout
l 1b76 ISR_Ep8inout
l 1b77 ISR_Ibn
;l 1b6e ISR_Stub
l 1b78 ISR_Ep0pingnak
l 1b79 ISR_Ep1pingnak
l 1b7a ISR_Ep2inoutPING
l 1b7b ISR_Ep4inoutPING
l 1b7c ISR_Ep6inoutPING
l 1b7d ISR_Ep8inoutPING
l 1b7e ISR_Errorlimit
;l 1b6e ISR_Stub
;l 1b6e ISR_Stub
;l 1b6e ISR_Stub   
l 1b7f ISR_Ep2inoutISOERR
l 1b80 ISR_Ep4inoutISOERR
l 1b81 ISR_Ep6inoutISOERR
l 1b82 ISR_Ep8inoutISOERR
l 1b83 ISR_Ep2pflag 
l 1b84 ISR_Ep4pflag
l 1b85 ISR_Ep6pflag
l 1b86 ISR_Ep8pflag
l 1b87 ISR_Ep2eflag
l 1b88 ISR_Ep4eflag
l 1b89 ISR_Ep6eflag
l 1b8a ISR_Ep8eflag
l 1b8b ISR_Ep2fflag
l 1b8c ISR_Ep4fflag
l 1b8d ISR_Ep6fflag 
l 1b8e ISR_Ep8fflag
l 1b8f ISR_GpifComplete
l 1b90 ISR_GpifWaveform

c 1a41-1b90

b 14fe

l 0b00 usb_descriptor_data
b 0b00-0c4f

l 16d1 gpioctl
c 16d1-1709
l 170a gpioctl_subfunc
c 170a-173b

c 173c-1934

l 1b51 TD_Suspend
l 1b56 TD_Resume
l 1987 EZUSB_Susp
c 1987-199a
l 18dd EZUSB_Resume

l 13fc poll_ep1
