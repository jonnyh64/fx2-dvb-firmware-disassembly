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
import tempfile
import pathlib
import shutil
import subprocess

pathlib.Path('disassembly').mkdir(exist_ok=True)

with tempfile.TemporaryDirectory() as tmpdirname:
    tmpdir = pathlib.Path(tmpdirname)

    # d52 cannot handle absolute paths, because it will interpret the leading '/'
    # as option; create a symlink therefore...

    pathlib.Path('tmp').unlink(missing_ok=True)
    pathlib.Path('tmp').symlink_to(tmpdir)

    for ctlfname in pathlib.Path('.').glob('*.ctl'):

        fname = f'{ctlfname.stem}.fw'

        if (p := pathlib.Path(fname)).exists():
            #print(p.name)

            shutil.copy(p, tmpdir / f'{p.stem}.bin')

            commonctlf = open('fx2_common.ctl', 'rb')
            srcctlf = open(f'{p.stem}.ctl', 'rb')
            ctlf = open(tmpdir / f'{p.stem}.ctl', 'wb')
            shutil.copyfileobj(commonctlf, ctlf)
            shutil.copyfileobj(srcctlf, ctlf)
            ctlf.close()
            srcctlf.close()
            commonctlf.close()

            subprocess.run(('d52', '-d', f'tmp/{p.stem}.bin'))

            shutil.copy(f'tmp/{p.stem}.d52', f'disassembly/{p.stem}.d52')

    pathlib.Path('tmp').unlink()
