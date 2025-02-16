# Warning

The FX2(LP) chip is end of life. It makes generally no sense to use it in new
hardware designs.

# Rationale

This disassembly was done to understand how DVB (or generally digital TV) PC
receivers based on the Cypress (now Infineon) FX2(LP) USB interface chip work.
I was planning to build my own DVB PC board and wanted to reuse an existing
firmware instead of writing yet another one. For this, I needed to make my
board compatible with such a firmware (the FX2 allows some flexibility for USB
communication, the data interface and GPIO usage), so I disassembled the
interesting parts and wrote some documentation about it. This documentation
is mostly meant for myself, but I publish it in the hope that it will be
interesting for others as well.

# FX2 introduction

The documentation on the Internet is quite extensive, so I will make this very
short: The FX2 is a widely used USB2 high speed interface chip with the
following key features (from my personal point of view):
- Low external BOM count - in essence, just a few decoupling caps and a crystal
  are needed
- Flexible synchronous/asynchronous parallel digital data interface
- Many GPIOs (depending on the exact IC variant)
- 8051 CPU core (not needed to handle USB transfers, so it doesn't limit USB
  performance)
- Integrated SRAM (8192 KiB for FX2, 16384 KiB for FX2LP)
- Can use default USB VID/PID or load custom VID/PID from I2C EEPROM
- Can load firmware via USB or from external I2C EEPROM
- Can use 8-bit addressable I2C EEPROM (i.e., up to 256 bytes) at
  I2C address 0x50
- Can use 16-bit addressable I2C EEPROM (i.e., up to 65536 bytes) at
  I2C address 0x51

# Getting the firmware

I will not share any firmware as I do not own the rights for it, but I will
provide some hints on how to obtain it.

## USB loaded firmware

The USB loaded firmware images are quite easy to get. Just use your favorite
search engine and enter the filename.

These files are raw RAM images containing 8051 code. The USB host will transfer
it to FX2 RAM (address 0x0) via Cypress defined USB vendor commands and then
release the 8051 CPU from reset.

I have disassembled the following files. If you want to do some disassembling
yourself, make sure you have the following versions with the given MD5 sums,
as the d52 ctl files I'm providing will only properly work with these:
```
1348945cda1a2a4cdc773df20e0fba91  dvb-usb-dw2101.fw
a84a315087846ae8aa3eccd85391d24d  dvb-usb-dw2102.fw
5e7d4fa2e25b3b9f2b0ffcfcba1ddccd  dvb-usb-dw2104.fw
50130abae1e90c24621955c06a7e792a  dvb-usb-dw3101.fw
c5d2829270030ef81076707f4e049ffa  dvb-usb-p1100.fw
5de7eb9cb7eefbb89343b64596de3a1d  dvb-usb-p7500.fw
c2b9e373ec0362ceb00a57d9b1ec83b5  dvb-usb-s630.fw
2946e99fe3a4973ba905fcf59111cf40  dvb-usb-s660.fw
```

## I2C EEPROM based firmware

An FX2 I2C boot EEPROM will contain a magic number, USB VID/PID/DID and a
number of chunks which the ROM bootloader will load into RAM (see the FX2
documentation for details).

I have tried to use the i2cget and i2cdump Linux command line tools, but they
didn't work for me, even after I patched the kernel to advertise the I2C_*
constants which will make i2cget/i2cdump believe it is supported. This can
be probably made working, but I did not invest more time in this approach.

Instead I put the following code into drivers/media/usb/dvb-usb/dw2102.c
from the Linux kernel:

```C
static void dumpeeprom(struct dvb_usb_adapter *adap)
{
    struct dvb_usb_device *d = adap->dev;
    u8 *buf;
    u8 *p;
    int chunklen = 32;
    int offs;

    buf = kmalloc(6 + chunklen + 1, GFP_KERNEL);

    buf[0] = 0x09;
    buf[1] = 2;
    buf[2] = chunklen;
    buf[3] = 0x51;

    for (offs = 0; offs < 16384; offs += chunklen)
    {
        buf[4] = (offs & 0xff00) >> 8;
        buf[5] =  offs & 0x00ff;

        if (dvb_usb_generic_rw(d, buf, 6, buf + 6, chunklen + 1, 0) < 0)
        {
            err("dumpeeprom failed\n");
        }
        else
        {
            p = buf + 7;
            info("dumpeeprom %04x "
                 "%02x%02x%02x%02x%02x%02x%02x%02x"
                 "%02x%02x%02x%02x%02x%02x%02x%02x"
                 "%02x%02x%02x%02x%02x%02x%02x%02x"
                 "%02x%02x%02x%02x%02x%02x%02x%02x",
                 offs,
                 p[ 0], p[ 1], p[ 2], p[ 3], p[ 4], p[ 5], p[ 6], p[ 7],
                 p[ 8], p[ 9], p[10], p[11], p[12], p[13], p[14], p[15],
                 p[16], p[17], p[18], p[19], p[20], p[21], p[22], p[23],
                 p[24], p[25], p[26], p[27], p[28], p[29], p[30], p[31]);
        }
    }

    kfree(buf);
}
```

This function can be called from e.g. tt_s2_4600_frontend_attach. This
approach is a little crude, but acceptable as it is only required once (you
will probably want to remove this hack from the kernel again after you got
the EEPROM dump!).

After recompiling the patched kernel and booting it, the ASCII dump can be
read with the dmesg Linux command. For converting it to a binary EEPROM image,
use the eepromdump_hex_to_bin.py utility:

```
dmesg | python3 eepromdump_hex_to_bin.py >dvb-usb-eepromdump.bin
```

The utility eepromdump_to_fw_ram_image.py will convert the binary EEPROM image
to a RAM image (this RAM image can be loaded in the FX2 in the same way as
dvb-usb-dw2101.fw etc.):

```
python3 eepromdump_to_fw_ram_image.py dvb-usb-eepromdump.bin dvb-usb.fw
```

# Creating the disassemblies

First, install the d52 disassembler to a directory which is included in your
PATH environment variable.

Put the *.fw files (e.g. dvb-usb-dw2101.fw) into the directory where all the
*.ctl files from this project reside and run the create_disassembly.py script:

```
python3 create_disassembly.py
```

This script will run the d52 disassembler for every ctl file to which a
corresponding fw file exists. All disassemblies will be written to a
directory called "disassembly".
