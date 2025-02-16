#
# Copyright 2025 Johann Hanne
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of
# this software and associated documentation files (the "Software"), to deal in
# the Software without restriction, including without limitation the rights to
# use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
# of the Software, and to permit persons to whom the Software is furnished to do
# so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#

# Version 1.0.0 (2025-02-16)

import sys
import struct

infname = sys.argv[1]
outfname = sys.argv[2]

f = open(infname, 'rb')

magic, vid, pid, did, cfg = struct.unpack('<BHHHB', f.read(8))

sys.stdout.write(f'magic {magic:02x}\n')
sys.stdout.write(f'vid {vid:04x}\n')
sys.stdout.write(f'pid {pid:04x}\n')
sys.stdout.write(f'did {did:04x}\n')
sys.stdout.write(f'cfg {cfg:02x}\n')

fw = bytearray(16384)
lastaddr = 0

done = False

while not done:
    l, addr = struct.unpack('>HH', f.read(4))

    if (l & 0x8000) != 0:
        l &= 0x7fff
        done = True

    if addr == 0xe600:
        sys.stdout.write(f'e600: {f.read(l).hex()}\n')
    else:
        endaddr = addr + l
        if endaddr > lastaddr:
            lastaddr = endaddr

        fw[addr:addr + l] = f.read(l)

        sys.stdout.write(f'{l} bytes at address {addr:04x}\n')

f.close()

fout = open(outfname, 'wb')

if lastaddr > 8192:
    fout.write(fw)
else:
    fout.write(fw[0:8192])

fout.close()
