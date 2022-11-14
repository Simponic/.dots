## Dependencies

### SBCL

`sudo pacman -S sbcl`

### Quicklisp:

In a shell:

```bash
cd ~
curl -O https://beta.quicklisp.org/quicklisp.lisp
sbcl --load quicklisp.lisp
```

Then in the REPL:

```common-lisp
(quicklisp-quickstart:install)
(ql:add-to-init-file)
```

And install some packages from quicklisp:

```common-lisp
(ql:quickload '(:clx :cl-ppcre :alexandria :sb-cltl :swank))
```

And in your .xinitrc:
```
export SBCL_HOME=/usr/lib/sbcl
```

### Other

You'll probably want some stuff on your modeline. My modeline setup is hacky AF so you'll want the following:

- `ifconfig` (in `net-tools` in Arch)
- `acpi`
- `lm_sensors`
- `pamixer`

## Building and Installing

```bash
mkdir ~/src
git clone git@github.com:stumpwm/stumpwm.git ~/src/stumpwm
cd ~/src/stumpwm
./autogen.sh
./configure
make -j6
sudo make install
```

## Configuration

- If the environment variable LAPTOP exists, then the battery will show in the modeling. You can edit `/etc/environment` if you want it in other programs too.
